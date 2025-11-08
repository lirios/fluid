/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2025 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 * Copyright (C) 2024-2025 hypengw <hypengwip@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

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

    \sa CornersGroup
*/

/*!
    \brief Constructs an Elevation item with an optional parent.
    \param parentItem The parent QQuickItem, if any.
*/
Elevation::Elevation(QQuickItem *parentItem)
    : QQuickItem(parentItem)
    , m_elevation(0)
    , m_corners()
    , m_radius(0)
    , m_color(Qt::black)
{
    setFlag(QQuickItem::ItemHasContents, true);
    connect(this, &Elevation::elevationChanged, this, &Elevation::update);
    connect(this, &Elevation::colorChanged, this, &Elevation::update);
    connect(this, &Elevation::cornersChanged, this, &Elevation::update);
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
    \brief Returns the corners group.
    \return CornersGroup representing the corner radii.
*/
const CornersGroup &Elevation::corners() const
{
    return m_corners;
}

/*!
    \brief Sets the corners group.
    \param c New CornersGroup representing the corner radii.
*/
void Elevation::setCorners(const CornersGroup &c)
{
    m_corners = c;
    Q_EMIT cornersChanged(c);
}

/*!
    \brief Returns the current radius.
    \return Radius as a qreal.
*/
qreal Elevation::radius() const
{
    return m_radius;
}

/*!
    \brief Sets the radius for all corners.
    \param newRadius New radius value.
*/
void Elevation::setRadius(qreal newRadius)
{
    if (qFuzzyCompare(m_radius, newRadius)) {
        return;
    }

    m_radius = newRadius;
    setCorners(m_radius);
    Q_EMIT radiusChanged(m_radius);
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
    shadowNode->radius = m_corners.toVector4D();
    shadowNode->color = m_color.rgb();
    shadowNode->updateGeometry();
    return shadowNode;
}

} // namespace Fluid