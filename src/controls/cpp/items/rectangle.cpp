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
#include <QSGRectangleNode>
#include <QSGRendererInterface>
#include <QSGGeometry>
#include <QSGFlatColorMaterial>

#include "rectangle.h"
#include "geometry.h"
#include "rectanglematerial.h"

namespace Fluid {

namespace SceneGraph {

class RectangleNode : public QSGGeometryNode
{
public:
    RectangleNode()
    {
        setGeometry(createRectangleGeometry().release());
        setMaterial(new RectangleMaterial{});
        setFlags(QSGNode::OwnsGeometry | QSGNode::OwnsMaterial);
    }

    void updateGeometry()
    {
        auto vertices = static_cast<RectangleVertex *>(geometry()->vertexData());

        for (int i = 0; i < 4; i++) {
            radius[i] = std::min<float>(radius[i], rect.size().height() / 2.0f);
        }
        QVector2D size = { (float)rect.size().width(), (float)rect.size().height() };
        updateRectangleGeometry(vertices, size, color, radius);
        markDirty(QSGNode::DirtyGeometry);
    }

    QRectF rect;
    QRgb color{ 0 };
    QVector4D radius;
};

} // namespace SceneGraph

Rectangle::Rectangle(QQuickItem *parentItem)
    : QQuickItem(parentItem)
    , m_corners()
    , m_radius(0)
    , m_color(Qt::transparent)
{
    setFlag(QQuickItem::ItemHasContents, true);
    connect(this, &Rectangle::colorChanged, this, &Rectangle::update);
    connect(this, &Rectangle::cornersChanged, this, &Rectangle::update);
}

Rectangle::~Rectangle()
{
}

auto Rectangle::corners() const -> CornersGroup
{
    return m_corners;
}
void Rectangle::setCorners(const CornersGroup &c)
{
    m_corners = c;
    cornersChanged();
}

qreal Rectangle::radius() const
{
    return m_radius;
}

void Rectangle::setRadius(qreal newRadius)
{
    if (qFuzzyCompare(m_radius, newRadius)) {
        return;
    }
    m_radius = newRadius;
    setCorners(m_radius);
    radiusChanged();
}

QColor Rectangle::color() const
{
    return m_color;
}

void Rectangle::setColor(const QColor &newColor)
{
    if (newColor == m_color) {
        return;
    }

    m_color = newColor;
    colorChanged();
}

void Rectangle::componentComplete()
{
    QQuickItem::componentComplete();
}

void Rectangle::itemChange(QQuickItem::ItemChange change, const QQuickItem::ItemChangeData &value)
{
    if (change == QQuickItem::ItemSceneChange && value.window) {
        // checkSoftwareItem();
    }

    QQuickItem::itemChange(change, value);
}

QSGNode *Rectangle::updatePaintNode(QSGNode *node, QQuickItem::UpdatePaintNodeData *data)
{
    Q_UNUSED(data);

    if (boundingRect().isEmpty()) {
        delete node;
        return nullptr;
    }

    auto shadowNode = static_cast<Fluid::SceneGraph::RectangleNode *>(node);
    if (!shadowNode) {
        shadowNode = new Fluid::SceneGraph::RectangleNode{};
    }
    shadowNode->rect = boundingRect();
    shadowNode->radius = m_corners.toVector4D();
    shadowNode->color = m_color.rgba();
    shadowNode->updateGeometry();
    return shadowNode;
}

} // namespace Fluid
