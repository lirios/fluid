// SPDX-FileCopyrightText: 2025-2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-FileCopyrightText: 2024-2025 hypengw <hypengwip@gmail.com>
// SPDX-License-Identifier: MPL-2.0
//
// Originally based on code by hypengw, licensed under the MIT license.

#include <QQuickWindow>
#include <QSGFlatColorMaterial>
#include <QSGGeometry>
#include <QSGRendererInterface>

#include "elevation.h"
#include "elevationmaterial.h"
#include "geometry.h"

// Some parameters come from:
// https://github.com/flutter/engine/blob/3.24.3/display_list/skia/dl_sk_dispatcher.cc#L295
// https://github.com/google/skia/blob/canvaskit/0.38.2/src/gpu/ganesh/SurfaceDrawContext.cpp#L1077
constexpr float kAmbientAlpha = 0.039f;
constexpr float kSpotAlpha = 0.25f;
constexpr float kShadowLightRadius = 800.0f;
constexpr float kShadowLightHeight = 600.0f;
constexpr QVector3D kLightPos = { 0, -1, 1 };

namespace Fluid {

namespace SceneGraph {

class ElevationNode : public QSGGeometryNode
{
public:
    ElevationNode()
    {
        setGeometry(createShadowGeometry().release());
        setMaterial(new ElevationMaterial{});
        setFlags(QSGNode::OwnsGeometry | QSGNode::OwnsMaterial);
    }

    void init(QQuickItem *item)
    {
        static_cast<ElevationMaterial *>(material())->init_fadeoff_texture(item->window());
    }

    void updateGeometry()
    {
        // auto             vertices =
        // static_cast<ShadowVertex*>(geometry()->vertexData());
        SceneGraph::ShadowParams params;
        {
            params.z_plane_params = QVector3D(0, 0, elevation);
            params.light_pos = kLightPos;
            params.light_radius = kShadowLightRadius / kShadowLightHeight;
            params.radius = radius;
            if (elevation == 0) {
                params.flags |= SceneGraph::ShadowFlags::TransparentOccluder_ShadowFlag;
            }
            params.flags |= SceneGraph::ShadowFlags::DirectionalLight_ShadowFlag;
            auto c = this->color;
            c.setAlphaF(kAmbientAlpha * this->color.alphaF());
            params.ambient_color = c.rgba();
            c.setAlphaF(kSpotAlpha * this->color.alphaF());
            params.spot_color = c.rgba();

            for (int i = 0; i < 4; i++) {
                params.radius[i] = std::min<float>(params.radius[i], rect.height() / 2.0f);
            }
        }
        updateShadowGeometry(geometry(), params, rect);

        markDirty(QSGNode::DirtyGeometry);
    }

    double elevation;
    QRectF rect;
    QColor color;
    QVector4D radius;
};

} // namespace SceneGraph

/*
 * Elevation
 */

/*!
    \class Elevation
    \brief A QQuickItem that renders elevation-based shadow effects.

    The Elevation class provides a visual shadow effect that simulates material design
    elevation. It renders shadows beneath the item based on the specified elevation level,
    corner radii, and color. The shadow is rendered using a custom scene graph node
    (ElevationNode) that handles the geometry and material for the shadow effect.

    The class supports:
    - Configurable elevation levels that affect shadow intensity and spread
    - Customizable corner radii for rounded shadows
    - Adjustable shadow color and opacity
    - Automatic updates when properties change

    \note This class uses Qt's scene graph API for efficient rendering.
    \note The shadow effect follows Material Design principles with ambient and spot lighting.
*/

/*!
    \brief Constructs an Elevation item with an optional parent.
    \param parentItem The parent QQuickItem, if any.
*/
Elevation::Elevation(QQuickItem *parentItem)
    : QQuickItem(parentItem)
{
    setFlag(QQuickItem::ItemHasContents, true);
    connect(this, &Elevation::elevationChanged, this, &Elevation::update);
    connect(this, &Elevation::colorChanged, this, &Elevation::update);
    connect(this, &Elevation::bottomLeftRadiusChanged, this, &Elevation::update);
    connect(this, &Elevation::bottomRightRadiusChanged, this, &Elevation::update);
    connect(this, &Elevation::topLeftRadiusChanged, this, &Elevation::update);
    connect(this, &Elevation::topRightRadiusChanged, this, &Elevation::update);
}

/*!
    \brief Destructor for the Elevation item.
*/
Elevation::~Elevation()
{
}

/*!
    \brief Returns the current elevation level.
    \return Elevation level as a double.
*/
qreal Elevation::elevation() const
{
    return m_elevation;
}

/*!
    \brief Sets the elevation level.
    \param l New elevation level.
*/
void Elevation::setElevation(qreal l)
{
    if (!qFuzzyCompare(l, m_elevation)) {
        m_elevation = l;
        Q_EMIT elevationChanged(m_elevation);
    }
}

/*!
    \brief Returns the current radius.

    If any individual corner radius has been explicitly set, returns the maximum
    of all four corner radii. Otherwise returns the uniform radius value.

    \return Radius as a qreal.
*/
qreal Elevation::radius() const
{
    if (m_topLeftRadius.has_value() || m_topRightRadius.has_value()
        || m_bottomLeftRadius.has_value() || m_bottomRightRadius.has_value()) {
        return std::max(
                { topLeftRadius(), topRightRadius(), bottomLeftRadius(), bottomRightRadius() });
    }
    return m_radius;
}

/*!
    \brief Sets the radius for all corners.

    Clears any individually overridden corner radii, so all four corners
    will use this value. Individual radii set afterwards will override it.

    \param newRadius New radius value.
*/
void Elevation::setRadius(qreal newRadius)
{
    const qreal oldTL = topLeftRadius();
    const qreal oldTR = topRightRadius();
    const qreal oldBL = bottomLeftRadius();
    const qreal oldBR = bottomRightRadius();

    const bool changed = !qFuzzyCompare(m_radius, newRadius);
    m_radius = newRadius;

    // Clear individual overrides — setRadius resets all corners to the same value
    m_topLeftRadius.reset();
    m_topRightRadius.reset();
    m_bottomLeftRadius.reset();
    m_bottomRightRadius.reset();

    if (changed)
        Q_EMIT radiusChanged(m_radius);
    if (!qFuzzyCompare(oldTL, m_radius))
        Q_EMIT topLeftRadiusChanged(m_radius);
    if (!qFuzzyCompare(oldTR, m_radius))
        Q_EMIT topRightRadiusChanged(m_radius);
    if (!qFuzzyCompare(oldBL, m_radius))
        Q_EMIT bottomLeftRadiusChanged(m_radius);
    if (!qFuzzyCompare(oldBR, m_radius))
        Q_EMIT bottomRightRadiusChanged(m_radius);
}

qreal Elevation::topLeftRadius() const
{
    return m_topLeftRadius.value_or(m_radius);
}

void Elevation::setTopLeftRadius(qreal newTopLeftRadius)
{
    if (qFuzzyCompare(topLeftRadius(), newTopLeftRadius))
        return;

    const qreal oldRadius = radius();
    m_topLeftRadius = newTopLeftRadius;
    Q_EMIT topLeftRadiusChanged(newTopLeftRadius);
    if (!qFuzzyCompare(radius(), oldRadius))
        Q_EMIT radiusChanged(radius());
}

qreal Elevation::topRightRadius() const
{
    return m_topRightRadius.value_or(m_radius);
}

void Elevation::setTopRightRadius(qreal newTopRightRadius)
{
    if (qFuzzyCompare(topRightRadius(), newTopRightRadius))
        return;

    const qreal oldRadius = radius();
    m_topRightRadius = newTopRightRadius;
    Q_EMIT topRightRadiusChanged(newTopRightRadius);
    if (!qFuzzyCompare(radius(), oldRadius))
        Q_EMIT radiusChanged(radius());
}

qreal Elevation::bottomLeftRadius() const
{
    return m_bottomLeftRadius.value_or(m_radius);
}

void Elevation::setBottomLeftRadius(qreal newBottomLeftRadius)
{
    if (qFuzzyCompare(bottomLeftRadius(), newBottomLeftRadius))
        return;

    const qreal oldRadius = radius();
    m_bottomLeftRadius = newBottomLeftRadius;
    Q_EMIT bottomLeftRadiusChanged(newBottomLeftRadius);
    if (!qFuzzyCompare(radius(), oldRadius))
        Q_EMIT radiusChanged(radius());
}

qreal Elevation::bottomRightRadius() const
{
    return m_bottomRightRadius.value_or(m_radius);
}

void Elevation::setBottomRightRadius(qreal newBottomRightRadius)
{
    if (qFuzzyCompare(bottomRightRadius(), newBottomRightRadius))
        return;

    const qreal oldRadius = radius();
    m_bottomRightRadius = newBottomRightRadius;
    Q_EMIT bottomRightRadiusChanged(newBottomRightRadius);
    if (!qFuzzyCompare(radius(), oldRadius))
        Q_EMIT radiusChanged(radius());
}

/*!
    \brief Returns the current shadow color.
    \return QColor representing the shadow color.
*/
QColor Elevation::color() const
{
    return m_color;
}

/*!
    \brief Sets the shadow color.
    \param newColor New QColor for the shadow.
*/
void Elevation::setColor(const QColor &newColor)
{
    if (newColor == m_color) {
        return;
    }

    m_color = newColor;
    Q_EMIT colorChanged(m_color);
}

/*!
    \brief Called when the component is complete.
*/
void Elevation::componentComplete()
{
    QQuickItem::componentComplete();
}

/*!
    \brief Handles item changes.
    \param change The type of change.
    \param value Additional data related to the change.
*/
void Elevation::itemChange(QQuickItem::ItemChange change, const QQuickItem::ItemChangeData &value)
{
    if (change == QQuickItem::ItemSceneChange && value.window) {
        // checkSoftwareItem();
    }

    QQuickItem::itemChange(change, value);
}

/*!
    \brief Updates the paint node for rendering.
    \param node The existing QSGNode, if any.
    \param data Additional data for updating the paint node.
    \return Updated QSGNode for rendering.
*/
QSGNode *Elevation::updatePaintNode(QSGNode *node, QQuickItem::UpdatePaintNodeData *data)
{
    Q_UNUSED(data);

    if (boundingRect().isEmpty()) {
        delete node;
        return nullptr;
    }
    auto shadowNode = static_cast<SceneGraph::ElevationNode *>(node);

    if (!shadowNode) {
        shadowNode = new SceneGraph::ElevationNode{};
        shadowNode->init(this);
    }
    shadowNode->rect = boundingRect();
    shadowNode->elevation = m_elevation;
    shadowNode->radius = QVector4D{ (float)topLeftRadius(), (float)topRightRadius(),
                                    (float)bottomLeftRadius(), (float)bottomRightRadius() };
    shadowNode->color = m_color.rgb();
    shadowNode->updateGeometry();
    return shadowNode;
}

} // namespace Fluid