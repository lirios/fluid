// SPDX-FileCopyrightText: 2025 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-FileCopyrightText: 2024-2025 hypengw <hypengwip@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#include "geometry.h"
#include "skia_shadow.h"

namespace Fluid {
using scalar = float;

namespace SceneGraph {

namespace {
/*
  0 ------- 1
   |      /
   |     /
   |    /
   |   /
   |  /
   | /
  2
            5
          / |
         /  |
        /   |
       /    |
      /     |
     /      |
  3 ------- 4
*/

template <typename T>
inline void set_rect(T *v, T *lt, T *rt, T *lb, T *rb)
{
    v[0] = *lt;
    v[1] = *rt;
    v[2] = *lb;
    v[3] = *lb;
    v[4] = *rb;
    v[5] = *rt;
}

template <typename T>
inline void set_rect_flip(T *v, T *lt, T *rt, T *lb, T *rb)
{
    v[0] = *lt;
    v[1] = *rt;
    v[2] = *rb;
    v[3] = *rb;
    v[4] = *lt;
    v[5] = *lb;
}

// four points

inline void secorners(RectangleVertex *v, QVector2D o, QVector2D s, float outter, float inner)
{
    auto helper = [](RectangleVertex *v, QVector2D lt, QVector2D rt, QVector2D lb, QVector2D rb,
                     float outter, float inner) {
        v[0].setPoint(lt);
        v[0].ce_x = 0;
        v[0].ce_y = 0;
        v[0].ce_distance_to_outter = outter;
        v[0].ce_distance_to_inner = inner;

        v[1].setPoint(rt);
        v[1].ce_x = 0;
        v[1].ce_y = 0;
        v[1].ce_distance_to_outter = outter;
        v[1].ce_distance_to_inner = inner;

        v[2].setPoint(lb);
        v[2].ce_x = 0;
        v[2].ce_y = 0;
        v[2].ce_distance_to_outter = outter;
        v[2].ce_distance_to_inner = inner;

        v[3].setPoint(lb);
        v[3].ce_x = 0;
        v[3].ce_y = 0;
        v[3].ce_distance_to_outter = outter;
        v[3].ce_distance_to_inner = inner;

        v[4].setPoint(rb);
        v[4].ce_x = 0;
        v[4].ce_y = 0;
        v[4].ce_distance_to_outter = outter;
        v[4].ce_distance_to_inner = inner;

        v[5].setPoint(rt);
        v[5].ce_x = 0;
        v[5].ce_y = 0;
        v[5].ce_distance_to_outter = outter;
        v[5].ce_distance_to_inner = inner;
    };
    QVector2D lt = o;
    QVector2D rt = o + QVector2D{ s.x(), 0 };
    QVector2D lb = o + QVector2D{ 0, s.y() };
    QVector2D rb = o + s;
    helper(v, lt, rt, lb, rb, outter, inner);
};

template <typename T>
inline void set_right_bottom_corner(T *v, QVector2D size, float r, float outter, float inner)
{
    secorners(v, { size.x() - r, size.y() - r }, { r, r }, outter, inner);

    float offset = 1.0;
    v[1].ce_x = offset;
    v[5].ce_x = offset;

    v[2].ce_y = offset;
    v[3].ce_y = offset;

    v[4].ce_x = 1;
    v[4].ce_y = 1;
}

template <typename T>
inline void set_right_top_corner(T *v, QVector2D size, float r, float outter, float inner)
{
    secorners(v, { size.x() - r, 0 }, { r, r }, outter, inner);
    float offset = 1.0;
    v[4].ce_x = offset;
    v[0].ce_y = offset;

    v[1].ce_x = 1;
    v[1].ce_y = 1;
    v[5].ce_x = 1;
    v[5].ce_y = 1;
}

template <typename T>
inline void set_left_bottom_corner(T *v, QVector2D size, float r, float outter, float inner)
{
    secorners(v, { 0, size.y() - r }, { r, r }, outter, inner);
    float offset = 1.0;
    v[0].ce_x = offset;
    v[4].ce_y = offset;

    v[2].ce_x = 1;
    v[2].ce_y = 1;
    v[3].ce_x = 1;
    v[3].ce_y = 1;
}

template <typename T>
inline void set_left_top_corner(T *v, QVector2D, float r, float outter, float inner)
{
    secorners(v, { }, { r, r }, outter, inner);
    float offset = 1.0;
    v[2].ce_x = offset;
    v[3].ce_x = offset;

    v[1].ce_y = offset;
    v[5].ce_y = offset;

    v[0].ce_x = 1;
    v[0].ce_y = 1;
}

} // namespace

} // namespace SceneGraph

std::unique_ptr<QSGGeometry, std::default_delete<QSGGeometry>> SceneGraph::createRectangleGeometry()
{
    static QSGGeometry::Attribute attrs[] = {
        QSGGeometry::Attribute::createWithAttributeType(0, 2, QSGGeometry::FloatType,
                                                        QSGGeometry::PositionAttribute),
        QSGGeometry::Attribute::createWithAttributeType(1, 4, QSGGeometry::FloatType,
                                                        QSGGeometry::UnknownAttribute),
        QSGGeometry::Attribute::createWithAttributeType(2, 4, QSGGeometry::FloatType,
                                                        QSGGeometry::UnknownAttribute),
    };

    static QSGGeometry::AttributeSet attrset = { 3, sizeof(RectangleVertex), attrs };

    auto out = std::make_unique<QSGGeometry>(attrset, 6 * 9);
    out->setDrawingMode(QSGGeometry::DrawTriangles);
    return out;
}

void SceneGraph::updateRectangleGeometry(RectangleVertex *v, QVector2D size, QRgb color,
                                         QVector4D radius)
{
    const auto u = 6;

    auto lt = v;
    auto rt = v + u;
    auto lb = v + u * 2;
    auto rb = v + u * 3;

    auto outter = std::max({ radius[0], radius[1], radius[2], radius[3], 2.0f });
    auto inner = -1.0f / outter;

    set_left_top_corner(lt, size, radius[0], std::max(radius[0], 2.0f), inner);
    set_right_top_corner(rt, size, radius[1], std::max(radius[1], 2.0f), inner);
    set_left_bottom_corner(lb, size, radius[2], std::max(radius[2], 2.0f), inner);
    set_right_bottom_corner(rb, size, radius[3], std::max(radius[3], 2.0f), inner);

    auto top = v + u * 4;
    auto left = v + u * 5;
    auto bottom = v + u * 6;
    auto right = v + u * 7;
    auto middle = v + u * 8;

    set_rect(top, lt + 5, rt + 0, lt + 4, rt + 2);
    if (top[0].ce_distance_to_outter - top[1].ce_distance_to_outter > 0.1f) {
        top[1].ce_distance_to_outter = top[0].ce_distance_to_outter * 10.0f;
    }
    set_rect_flip(bottom, lb + 1, rb + 0, lb + 4, rb + 2);
    if (bottom[0].ce_distance_to_outter - bottom[1].ce_distance_to_outter > 0.1f) {
        bottom[1].ce_distance_to_outter = bottom[0].ce_distance_to_outter * 10.0f;
    }
    set_rect(left, lt + 3, lt + 4, lb + 0, lb + 1);
    if (left[0].ce_distance_to_outter - left[2].ce_distance_to_outter > 0.1f) {
        left[2].ce_distance_to_outter = left[0].ce_distance_to_outter * 10.0f;
    }
    set_rect_flip(right, rt + 2, rt + 4, rb + 0, rb + 1);
    if (right[0].ce_distance_to_outter - right[2].ce_distance_to_outter > 0.1f) {
        right[2].ce_distance_to_outter = right[0].ce_distance_to_outter * 10.0f;
    }
    set_rect(middle, lt + 4, rt + 2, lb + 1, rb + 0);

    for (int i = 0; i < u * 9; i++) {
        v[i].setColor(color);
    }
}

std::unique_ptr<QSGGeometry, std::default_delete<QSGGeometry>> SceneGraph::createShadowGeometry()
{
    static QSGGeometry::Attribute attrs[] = {
        QSGGeometry::Attribute::createWithAttributeType(0, 2, QSGGeometry::FloatType,
                                                        QSGGeometry::PositionAttribute),
        QSGGeometry::Attribute::createWithAttributeType(1, 4, QSGGeometry::FloatType,
                                                        QSGGeometry::UnknownAttribute),
        QSGGeometry::Attribute::createWithAttributeType(2, 3, QSGGeometry::FloatType,
                                                        QSGGeometry::UnknownAttribute),
    };

    static QSGGeometry::AttributeSet attrset = { 3, sizeof(ShadowVertex), attrs };

    auto out = std::make_unique<QSGGeometry>(attrset, 0);
    out->setDrawingMode(QSGGeometry::DrawTriangles);
    return out;
}

void SceneGraph::updateShadowGeometry(QSGGeometry *geo, const ShadowParams &params,
                                      const QRectF &rect)
{
    float occluderHeight = params.z_plane_params.z();
    bool transparent = (params.flags & ShadowFlags::TransparentOccluder_ShadowFlag);
    bool directional = (params.flags & ShadowFlags::DirectionalLight_ShadowFlag);
    auto devLightPos = params.light_pos;
    auto max_radius = std::min(rect.width(), rect.height()) / 2.0;
    bool is_oval = params.radius.x() >= max_radius && params.radius.y() >= max_radius
            && params.radius.z() >= max_radius && params.radius.w() >= max_radius
            && qFuzzyCompare(rect.width(), rect.height());

    std::array<std::optional<Skia::ShadowCircularRRectOp>, 2> ops;

    if (params.ambient_color > 0) {
        scalar devSpaceInsetWidth = Skia::AmbientBlurRadius(occluderHeight);
        const scalar umbraRecipAlpha = Skia::AmbientRecipAlpha(occluderHeight);
        const scalar devSpaceAmbientBlur = devSpaceInsetWidth * umbraRecipAlpha;

        // Outset the shadow rrect to the border of the penumbra
        scalar ambientPathOutset = devSpaceInsetWidth; // * devToSrcScale;
        QRectF ambientRRect = rect.adjusted(-ambientPathOutset, -ambientPathOutset,
                                            ambientPathOutset, ambientPathOutset);
        QVector4D ambientRadii;
        for (int i = 0; i < 4; ++i)
            ambientRadii[i] = std::min<float>(params.radius[i] + ambientPathOutset, max_radius);

        if (transparent) {
            // set a large inset to force a fill
            devSpaceInsetWidth = ambientRRect.width();
        }
        ops[0] = Skia::ShadowCircularRRectOp(params.ambient_color, ambientRRect, ambientRadii,
                                             is_oval, devSpaceAmbientBlur, devSpaceInsetWidth);
    }

    if (params.spot_color > 0) {
        scalar devSpaceSpotBlur;
        scalar spotScale;
        QVector2D spotOffset;
        if (directional) {
            Skia::GetDirectionalParams(occluderHeight, devLightPos.x(), devLightPos.y(),
                                       devLightPos.z(), params.light_radius, &devSpaceSpotBlur,
                                       &spotScale, &spotOffset);
        } else {
            Skia::GetSpotParams(occluderHeight, devLightPos.x(), devLightPos.y(), devLightPos.z(),
                                params.light_radius, &devSpaceSpotBlur, &spotScale, &spotOffset);
        }
        // handle scale of radius due to CTM
        const scalar srcSpaceSpotBlur = devSpaceSpotBlur; // * devToSrcScale;

        // // This offset is in dev space, need to transform it into source space.
        // SkMatrix ctmInverse;
        // if (viewMatrix.invert(&ctmInverse)) {
        //     ctmInverse.mapPoints(&spotOffset, 1);
        // } else {
        //     // Since the matrix is a similarity, this should never happen, but just in case...
        //     SkDebugf("Matrix is degenerate. Will not render spot shadow correctly!\n");
        //     SkASSERT(false);
        // }

        // Compute the transformed shadow rrect
        QRectF spotShadowRRect;
        {
            auto dw = (spotScale - 1.0f) * rect.width() / 2.0f;
            auto dh = (spotScale - 1.0f) * rect.height() / 2.0f;
            spotShadowRRect =
                    rect.translated(spotOffset.x(), spotOffset.y()).adjusted(-dw, -dh, dw, dh);
        }
        // SkMatrix shadowTransform;
        // shadowTransform.setScaleTranslate(spotScale, spotScale, spotOffset.fX, spotOffset.fY);
        // rrect.transform(shadowTransform, &spotShadowRRect);
        QVector4D spotRadii = params.radius * spotScale;

        // Compute the insetWidth
        scalar blurOutset = srcSpaceSpotBlur;
        scalar insetWidth = blurOutset;
        if (transparent) {
            // If transparent, just do a fill
            insetWidth += spotShadowRRect.width();
        } else {
            // For shadows, instead of using a stroke we specify an inset from the penumbra
            // border. We want to extend this inset area so that it meets up with the caster
            // geometry. The inset geometry will by default already be inset by the blur width.
            //
            // We compare the min and max corners inset by the radius between the original
            // rrect and the shadow rrect. The distance between the two plus the difference
            // between the scaled radius and the original radius gives the distance from the
            // transformed shadow shape to the original shape in that corner. The max
            // of these gives the maximum distance we need to cover.
            //
            // Since we are outsetting by 1/2 the blur distance, we just add the maxOffset to
            // that to get the full insetWidth.
            scalar maxOffset;
            // is rect
            if (params.radius.length() == 0) {
                // Manhattan distance works better for rects
                maxOffset = std::max(std::max(std::abs(spotShadowRRect.left() - rect.left()),
                                              std::abs(spotShadowRRect.top() - rect.top())),
                                     std::max(std::abs(spotShadowRRect.right() - rect.right()),
                                              std::abs(spotShadowRRect.bottom() - rect.bottom())));
            } else {
                scalar dr = 0;
                for (int i = 0; i < 4; ++i)
                    dr = std::max(dr, spotRadii[i] - params.radius[i]);
                QVector2D upperLeftOffset = QVector2D(spotShadowRRect.left() - rect.left() + dr,
                                                      spotShadowRRect.top() - rect.top() + dr);
                QVector2D lowerRightOffset =
                        QVector2D(spotShadowRRect.right() - rect.right() - dr,
                                  spotShadowRRect.bottom() - rect.bottom() - dr);
                maxOffset = std::sqrt(std::max(upperLeftOffset.lengthSquared(),
                                               lowerRightOffset.lengthSquared()))
                        + dr;
            }
            insetWidth += std::max(blurOutset, maxOffset);
        }

        // Outset the shadow rrect to the border of the penumbra
        spotShadowRRect.adjust(-blurOutset, -blurOutset, blurOutset, blurOutset);
        spotRadii += QVector4D(blurOutset, blurOutset, blurOutset, blurOutset);

        ops[1] = Skia::ShadowCircularRRectOp(params.spot_color, spotShadowRRect, spotRadii,
                                             is_oval, 2.0f * devSpaceSpotBlur, insetWidth);
    }

    int vertex_count = 0;
    int index_count = 0;
    for (auto &p : ops) {
        if (p) {
            vertex_count += p->fVertCount;
            index_count += p->fIndexCount;
        }
    }
    geo->allocate(vertex_count, index_count);

    auto vertices = static_cast<ShadowVertex *>(geo->vertexData());
    auto indexes = (std::uint16_t *)geo->indexData();
    int vertice_offset = 0;
    for (auto &p : ops) {
        if (p) {
            auto type = p->fGeoData.type;
            if (p->fGeoData.is_circle) {
                bool isStroked = (Skia::ShadowCircularRRectOp::kStroke_RRectType == type);
                p->fillInCircleVerts(isStroked, &vertices);
            } else {
                p->fillInRRectVerts(&vertices);
            }
            for (int i = 0; i < p->fIndexCount; i++) {
                indexes[i] = p->fIndexPtr[i] + vertice_offset;
            }
            indexes += p->fIndexCount;
            vertice_offset += p->fVertCount;
        }
    }
}

} // namespace Fluid
