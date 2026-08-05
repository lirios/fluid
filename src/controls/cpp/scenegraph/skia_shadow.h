// SPDX-FileCopyrightText: 2025 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-FileCopyrightText: 2024-2025 hypengw <hypengwip@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#include "geometry.h"

// https://github.com/google/skia/blob/canvaskit/0.38.2/src/gpu/ganesh/ops/ShadowRRectOp.cpp

namespace Fluid::Skia {

using scalar = float;

template <typename T>
static constexpr const T &SkTPin(const T &x, const T &lo, const T &hi)
{
    return std::max(lo, std::min(x, hi));
}

constexpr auto sk_double_round(double x)
{
    return std::floor((x) + 0.5);
}
constexpr auto sk_float_round(double x)
{
    return (float)std::floor((x) + 0.5);
}

template <typename T, std::enable_if_t<std::is_floating_point_v<T>, bool> = true>
static inline constexpr bool SkIsNaN(T x)
{
    return x != x;
}

#if defined(_MSC_VER) && !defined(__clang__)
#  define SK_CHECK_NAN(resultVal) \
      if (SkIsNaN(x)) {           \
          return resultVal;       \
      }
#else
#  define SK_CHECK_NAN(resultVal)
#endif

inline constexpr int SK_MaxS32FitsInFloat = 2147483520;
inline constexpr int SK_MinS32FitsInFloat = -SK_MaxS32FitsInFloat;
static constexpr int sk_float_saturate2int(float x)
{
    SK_CHECK_NAN(SK_MaxS32FitsInFloat)
    x = x < SK_MaxS32FitsInFloat ? x : SK_MaxS32FitsInFloat;
    x = x > SK_MinS32FitsInFloat ? x : SK_MinS32FitsInFloat;
    return (int)x;
}
constexpr auto SkScalarRoundToInt(double x)
{
    return sk_float_saturate2int(sk_float_round(x));
}

static constexpr auto kAmbientHeightFactor = 1.0f / 128.0f;
static constexpr auto kAmbientGeomFactor = 64.0f;
// Assuming that we have a light height of 600 for the spot shadow,
// the spot values will reach their maximum at a height of approximately 292.3077.
// We'll round up to 300 to keep it simple.
static constexpr auto kMaxAmbientRadius = 300 * kAmbientHeightFactor * kAmbientGeomFactor;

static inline float divide_and_pin(float numer, float denom, float min, float max)
{
    float result = SkTPin(numer / denom, min, max);
    // ensure that SkTPin handled non-finites correctly
    Q_ASSERT(result >= min && result <= max);
    return result;
}
constexpr auto SK_Scalar1{ 1.0f };
constexpr auto SK_ScalarNearlyZero{ (SK_Scalar1 / (1 << 12)) };

inline scalar AmbientBlurRadius(scalar height)
{
    return std::min(height * kAmbientHeightFactor * kAmbientGeomFactor, kMaxAmbientRadius);
}
inline scalar AmbientRecipAlpha(scalar height)
{
    return 1.0f + std::max(height * kAmbientHeightFactor, 0.0f);
}

inline scalar SpotBlurRadius(scalar occluderZ, scalar lightZ, scalar lightRadius)
{
    return lightRadius * divide_and_pin(occluderZ, lightZ - occluderZ, 0.0f, 0.95f);
}

inline void GetSpotParams(scalar occluderZ, scalar lightX, scalar lightY, scalar lightZ,
                          scalar lightRadius, scalar *blurRadius, scalar *scale,
                          QVector2D *translate)
{
    scalar zRatio = divide_and_pin(occluderZ, lightZ - occluderZ, 0.0f, 0.95f);
    *blurRadius = lightRadius * zRatio;
    *scale = divide_and_pin(lightZ, lightZ - occluderZ, 1.0f, 1.95f);
    *translate = QVector2D(-zRatio * lightX, -zRatio * lightY);
}

inline void GetDirectionalParams(scalar occluderZ, scalar lightX, scalar lightY, scalar lightZ,
                                 scalar lightRadius, scalar *blurRadius, scalar *scale,
                                 QVector2D *translate)
{
    *blurRadius = lightRadius * occluderZ;
    *scale = 1;
    // Max z-ratio is "max expected elevation"/"min allowable z"
    constexpr scalar kMaxZRatio = 64 / SK_ScalarNearlyZero;
    scalar zRatio = divide_and_pin(occluderZ, lightZ, 0.0f, kMaxZRatio);
    *translate = QVector2D(-zRatio * lightX, -zRatio * lightY);
}

class ShadowCircularRRectOp
{
public:
    using scalar = float;
    enum RRectType {
        kFill_RRectType,
        kStroke_RRectType,
        kOverstroke_RRectType,
    };
    // An insetWidth > 1/2 rect width or height indicates a simple fill.
    ShadowCircularRRectOp(QRgb color, const QRectF &devRect, float devRadius, bool isCircle,
                          float blurRadius, float insetWidth)
        : fIndexPtr(nullptr)
    {
        QRectF bounds = devRect;
        Q_ASSERT(insetWidth > 0);
        scalar innerRadius = 0.0f;
        scalar outerRadius = devRadius;
        scalar umbraInset;

        RRectType type = kFill_RRectType;
        if (isCircle) {
            umbraInset = 0;
        } else {
            umbraInset = std::max(outerRadius, blurRadius);
        }

        // If stroke is greater than width or height, this is still a fill,
        // otherwise we compute stroke params.
        if (isCircle) {
            innerRadius = devRadius - insetWidth;
            type = innerRadius > 0 ? kStroke_RRectType : kFill_RRectType;
        } else {
            if (insetWidth <= 0.5f * std::min(devRect.width(), devRect.height())) {
                // We don't worry about a real inner radius, we just need to know if we
                // need to create overstroke vertices.
                innerRadius = std::max(insetWidth - umbraInset, 0.0f);
                type = innerRadius > 0 ? kOverstroke_RRectType : kStroke_RRectType;
            }
        }

        // this->setBounds(bounds, HasAABloat::kNo, IsHairline::kNo);

        fGeoData = (Geometry{ color, outerRadius, umbraInset, innerRadius, blurRadius, bounds, type,
                              isCircle });
        if (isCircle) {
            fVertCount = circle_type_to_vert_count(kStroke_RRectType == type);
            fIndexCount = circle_type_to_index_count(kStroke_RRectType == type);
            fIndexPtr = circle_type_to_indices(kStroke_RRectType == type);
        } else {
            fVertCount = rrect_type_to_vert_count(type);
            fIndexCount = rrect_type_to_index_count(type);
            fIndexPtr = rrect_type_to_indices(type);
        }
    }
    struct Geometry
    {
        QRgb color;
        scalar outer_radius;
        scalar umbra_inset;
        scalar inner_radius;
        scalar blur_radius;
        QRectF dev_bounds;
        RRectType type;
        bool is_circle;
    };

    // In the case of a normal fill, we draw geometry for the circle as an octagon.
    static constexpr uint16_t gFillCircleIndices[] = {
        // enter the octagon
        // clang-format off
        0, 1, 8, 1, 2, 8,
        2, 3, 8, 3, 4, 8,
        4, 5, 8, 5, 6, 8,
        6, 7, 8, 7, 0, 8,
        // clang-format on
    };

    // For stroked circles, we use two nested octagons.
    static constexpr uint16_t gStrokeCircleIndices[] = {
        // enter the octagon
        // clang-format off
        0, 1,  9, 0,  9,  8,
        1, 2, 10, 1, 10,  9,
        2, 3, 11, 2, 11, 10,
        3, 4, 12, 3, 12, 11,
        4, 5, 13, 4, 13, 12,
        5, 6, 14, 5, 14, 13,
        6, 7, 15, 6, 15, 14,
        7, 0,  8, 7,  8, 15,
        // clang-format on
    };

    static constexpr uint16_t gRRectIndices[] = {
        // clang-format off
    // overstroke quads
    // we place this at the beginning so that we can skip these indices when rendering as filled
    0, 6, 25, 0, 25, 24,
    6, 18, 27, 6, 27, 25,
    18, 12, 26, 18, 26, 27,
    12, 0, 24, 12, 24, 26,

    // corners
    0, 1, 2, 0, 2, 3, 0, 3, 4, 0, 4, 5,
    6, 11, 10, 6, 10, 9, 6, 9, 8, 6, 8, 7,
    12, 17, 16, 12, 16, 15, 12, 15, 14, 12, 14, 13,
    18, 19, 20, 18, 20, 21, 18, 21, 22, 18, 22, 23,

    // edges
    0, 5, 11, 0, 11, 6,
    6, 7, 19, 6, 19, 18,
    18, 23, 17, 18, 17, 12,
    12, 13, 1, 12, 1, 0,

    // fill quad
    // we place this at the end so that we can skip these indices when rendering as stroked
    0, 6, 18, 0, 18, 12,
        // clang-format on
    };

    static constexpr float SK_FloatSqrt2 = 1.41421356f;

    // overstroke count
    static constexpr int kIndicesPerOverstrokeRRect = std::size(gRRectIndices) - 6;
    // simple stroke count skips overstroke indices
    static constexpr int kIndicesPerStrokeRRect = kIndicesPerOverstrokeRRect - 6 * 4;
    // fill count adds final quad to stroke count
    static constexpr int kIndicesPerFillRRect = kIndicesPerStrokeRRect + 6;
    static constexpr int kVertsPerStrokeRRect = 24;
    static constexpr int kVertsPerOverstrokeRRect = 28;
    static constexpr int kVertsPerFillRRect = 24;

    static constexpr int kIndicesPerFillCircle = std::size(gFillCircleIndices);
    static constexpr int kIndicesPerStrokeCircle = std::size(gStrokeCircleIndices);
    static constexpr int kVertsPerStrokeCircle = 16;
    static constexpr int kVertsPerFillCircle = 9;

    static int circle_type_to_vert_count(bool stroked)
    {
        return stroked ? kVertsPerStrokeCircle : kVertsPerFillCircle;
    }

    static int circle_type_to_index_count(bool stroked)
    {
        return stroked ? kIndicesPerStrokeCircle : kIndicesPerFillCircle;
    }

    static const uint16_t *circle_type_to_indices(bool stroked)
    {
        return stroked ? gStrokeCircleIndices : gFillCircleIndices;
    }

    static int rrect_type_to_vert_count(RRectType type)
    {
        switch (type) {
        case kFill_RRectType:
            return kVertsPerFillRRect;
        case kStroke_RRectType:
            return kVertsPerStrokeRRect;
        case kOverstroke_RRectType:
            return kVertsPerOverstrokeRRect;
        }
        Q_UNREACHABLE();
    }

    static int rrect_type_to_index_count(RRectType type)
    {
        switch (type) {
        case kFill_RRectType:
            return kIndicesPerFillRRect;
        case kStroke_RRectType:
            return kIndicesPerStrokeRRect;
        case kOverstroke_RRectType:
            return kIndicesPerOverstrokeRRect;
        }
        Q_UNREACHABLE();
    }

    static const uint16_t *rrect_type_to_indices(RRectType type)
    {
        switch (type) {
        case kFill_RRectType:
        case kStroke_RRectType:
            return gRRectIndices + 6 * 4;
        case kOverstroke_RRectType:
            return gRRectIndices;
        }
        Q_UNREACHABLE();
    }

public:
    void fillInCircleVerts(bool isStroked, SceneGraph::ShadowVertex **vp) const
    {
        const auto &args = this->fGeoData;
        QRgb color = args.color;
        scalar outerRadius = args.outer_radius;
        scalar innerRadius = args.inner_radius;
        scalar blurRadius = args.blur_radius;
        scalar distanceCorrection = outerRadius / blurRadius;

        const QRectF &bounds = args.dev_bounds;

        // The inner radius in the vertex data must be specified in normalized space.
        innerRadius = innerRadius / outerRadius;

        auto center = QVector2D(bounds.center().x(), bounds.center().y());
        scalar halfWidth = 0.5f * bounds.width();
        scalar octOffset = 0.41421356237f; // sqrt(2) - 1

        auto v = vp[0];

        v->setPoint(center + QVector2D(-octOffset * halfWidth, -halfWidth));
        v->setColor(color);
        v->setOffset({ -octOffset, -1 });
        v->distance_correction = distanceCorrection;
        v++;

        // Second vertex
        v->setPoint(center + QVector2D(octOffset * halfWidth, -halfWidth));
        v->setColor(color);
        v->setOffset({ octOffset, -1 });
        v->distance_correction = distanceCorrection;
        v++;

        // Third vertex
        v->setPoint(center + QVector2D(halfWidth, -octOffset * halfWidth));
        v->setColor(color);
        v->setOffset({ 1, -octOffset });
        v->distance_correction = distanceCorrection;
        v++;

        // Fourth vertex
        v->setPoint(center + QVector2D(halfWidth, octOffset * halfWidth));
        v->setColor(color);
        v->setOffset({ 1, octOffset });
        v->distance_correction = distanceCorrection;
        v++;

        // Fifth vertex
        v->setPoint(center + QVector2D(octOffset * halfWidth, halfWidth));
        v->setColor(color);
        v->setOffset({ octOffset, 1 });
        v->distance_correction = distanceCorrection;
        v++;

        // Sixth vertex
        v->setPoint(center + QVector2D(-octOffset * halfWidth, halfWidth));
        v->setColor(color);
        v->setOffset({ -octOffset, 1 });
        v->distance_correction = distanceCorrection;
        v++;

        // Seventh vertex
        v->setPoint(center + QVector2D(-halfWidth, octOffset * halfWidth));
        v->setColor(color);
        v->setOffset({ -1, octOffset });
        v->distance_correction = distanceCorrection;
        v++;

        // Eighth vertex
        v->setPoint(center + QVector2D(-halfWidth, -octOffset * halfWidth));
        v->setColor(color);
        v->setOffset({ -1, -octOffset });
        v->distance_correction = distanceCorrection;
        v++;

        if (isStroked) {
            // compute the inner ring
            // cosine and sine of pi/8
            scalar c = 0.923579533f;
            scalar s = 0.382683432f;
            scalar r = args.inner_radius;
            v->setPoint(center + QVector2D(-s * r, -c * r));
            v->setColor(color);
            v->setOffset({ -s * innerRadius, -c * innerRadius });
            v->distance_correction = distanceCorrection;
            v++;

            // Second vertex
            v->setPoint(center + QVector2D(s * r, -c * r));
            v->setColor(color);
            v->setOffset({ s * innerRadius, -c * innerRadius });
            v->distance_correction = distanceCorrection;
            v++;

            // Third vertex
            v->setPoint(center + QVector2D(c * r, -s * r));
            v->setColor(color);
            v->setOffset({ c * innerRadius, -s * innerRadius });
            v->distance_correction = distanceCorrection;
            v++;

            // Fourth vertex
            v->setPoint(center + QVector2D(c * r, s * r));
            v->setColor(color);
            v->setOffset({ c * innerRadius, s * innerRadius });
            v->distance_correction = distanceCorrection;
            v++;

            // Fifth vertex
            v->setPoint(center + QVector2D(s * r, c * r));
            v->setColor(color);
            v->setOffset({ s * innerRadius, c * innerRadius });
            v->distance_correction = distanceCorrection;
            v++;

            // Sixth vertex
            v->setPoint(center + QVector2D(-s * r, c * r));
            v->setColor(color);
            v->setOffset({ -s * innerRadius, c * innerRadius });
            v->distance_correction = distanceCorrection;
            v++;

            // Seventh vertex
            v->setPoint(center + QVector2D(-c * r, s * r));
            v->setColor(color);
            v->setOffset({ -c * innerRadius, s * innerRadius });
            v->distance_correction = distanceCorrection;
            v++;

            // Eighth vertex
            v->setPoint(center + QVector2D(-c * r, -s * r));
            v->setColor(color);
            v->setOffset({ -c * innerRadius, -s * innerRadius });
            v->distance_correction = distanceCorrection;
            v++;
        } else {
            // filled
            v->setPoint(center);
            v->setColor(color);
            v->setOffset({ 0, 0 });
            v->distance_correction = distanceCorrection;
            v++;
        }

        vp[0] = v;
    }
    void fillInRRectVerts(SceneGraph::ShadowVertex **vp) const
    {
        const Geometry &args = this->fGeoData;
        QRgb color = args.color;
        scalar outer_radius = args.outer_radius;

        const QRectF &bounds = args.dev_bounds;

        scalar umbra_inset = args.umbra_inset;
        scalar min_dim = 0.5f * std::min(bounds.width(), bounds.height());
        if (umbra_inset > min_dim) {
            umbra_inset = min_dim;
        }

        scalar xInner[4] = { (float)bounds.left() + umbra_inset,
                             (float)bounds.right() - umbra_inset,
                             (float)bounds.left() + umbra_inset,
                             (float)bounds.right() - umbra_inset };
        scalar xMid[4] = { (float)bounds.left() + outer_radius,
                           (float)bounds.right() - outer_radius,
                           (float)bounds.left() + outer_radius,
                           (float)bounds.right() - outer_radius };
        scalar xOuter[4] = { (float)bounds.left(), (float)bounds.right(), (float)bounds.left(),
                             (float)bounds.right() };
        scalar yInner[4] = { (float)bounds.top() + umbra_inset, (float)bounds.top() + umbra_inset,
                             (float)bounds.bottom() - umbra_inset,
                             (float)bounds.bottom() - umbra_inset };
        scalar yMid[4] = { (float)bounds.top() + outer_radius, (float)bounds.top() + outer_radius,
                           (float)bounds.bottom() - outer_radius,
                           (float)bounds.bottom() - outer_radius };
        scalar yOuter[4] = { (float)bounds.top(), (float)bounds.top(), (float)bounds.bottom(),
                             (float)bounds.bottom() };

        scalar blurRadius = args.blur_radius;

        // In the case where we have to inset more for the umbra, our two triangles in the
        // corner get skewed to a diamond rather than a square. To correct for that,
        // we also skew the vectors we send to the shader that help define the circle.
        // By doing so, we end up with a quarter circle in the corner rather than the
        // elliptical curve.

        // This is a bit magical, but it gives us the correct results at extrema:
        //   a) umbraInset == outerRadius produces an orthogonal vector
        //   b) outerRadius == 0 produces a diagonal vector
        // And visually the corner looks correct.
        QVector2D outerVec = QVector2D(outer_radius - umbra_inset, -outer_radius - umbra_inset);
        outerVec.normalize();
        // We want the circle edge to fall fractionally along the diagonal at
        //      (sqrt(2)*(umbraInset - outerRadius) + outerRadius)/sqrt(2)*umbraInset
        //
        // Setting the components of the diagonal offset to the following value will give us that.
        scalar diag_val =
                umbra_inset / (SK_FloatSqrt2 * (outer_radius - umbra_inset) - outer_radius);
        QVector2D diag_vec = QVector2D(diag_val, diag_val);
        scalar distance_correction = umbra_inset / blurRadius;

        auto v = vp[0];
        // build corner by corner
        for (int i = 0; i < 4; ++i) {
            // inner point
            v->setPoint(xInner[i], yInner[i]);
            v->setColor(color);
            v->setOffset({ 0, 0 });
            v->distance_correction = distance_correction;
            v++;

            // outer points
            v->setPoint(xOuter[i], yInner[i]);
            v->setColor(color);
            v->setOffset({ 0, -1 });
            v->distance_correction = distance_correction;
            v++;

            v->setPoint(xOuter[i], yMid[i]);
            v->setColor(color);
            v->setOffset(outerVec);
            v->distance_correction = distance_correction;
            v++;

            v->setPoint(xOuter[i], yOuter[i]);
            v->setColor(color);
            v->setOffset(diag_vec);
            v->distance_correction = distance_correction;
            v++;

            v->setPoint(xMid[i], yOuter[i]);
            v->setColor(color);
            v->setOffset(outerVec);
            v->distance_correction = distance_correction;
            v++;

            v->setPoint(xInner[i], yOuter[i]);
            v->setColor(color);
            v->setOffset({ 0, -1 });
            v->distance_correction = distance_correction;
            v++;
        }

        // Add the additional vertices for overstroked rrects.
        // Effectively this is an additional stroked rrect, with its
        // parameters equal to those in the center of the 9-patch. This will
        // give constant values across this inner ring.
        if (kOverstroke_RRectType == args.type) {
            Q_ASSERT(args.inner_radius > 0.0f);

            scalar inset = umbra_inset + args.inner_radius;

            // TL
            v->setPoint(bounds.left() + inset, bounds.top() + inset);
            v->setColor(color);
            v->setOffset({ 0, 0 });
            v->distance_correction = distance_correction;
            v++;

            // TR
            v->setPoint(bounds.right() - inset, bounds.top() + inset);
            v->setColor(color);
            v->setOffset({ 0, 0 });
            v->distance_correction = distance_correction;
            v++;

            // BL
            v->setPoint(bounds.left() + inset, bounds.bottom() - inset);
            v->setColor(color);
            v->setOffset({ 0, 0 });
            v->distance_correction = distance_correction;
            v++;

            // BR
            v->setPoint(bounds.right() - inset, bounds.bottom() - inset);
            v->setColor(color);
            v->setOffset({ 0, 0 });
            v->distance_correction = distance_correction;
            v++;
        }

        vp[0] = v;
    }

    Geometry fGeoData;
    int fVertCount;
    int fIndexCount;
    const uint16_t *fIndexPtr;
};

} // namespace Fluid::Skia