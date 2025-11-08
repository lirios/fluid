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

#pragma once

#include <QQmlEngine>
#include <QQuickItem>

#include "cornersgroup.h"

namespace Fluid {

class Elevation : public QQuickItem
{
    Q_OBJECT
    QML_NAMED_ELEMENT(ElevationImpl)
    Q_PROPERTY(qreal elevation READ elevation WRITE setElevation NOTIFY elevationChanged FINAL)
    Q_PROPERTY(qreal radius READ radius WRITE setRadius NOTIFY radiusChanged FINAL)
    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged FINAL)
    Q_PROPERTY(CornersGroup corners READ corners WRITE setCorners NOTIFY cornersChanged FINAL)
public:
    Elevation(QQuickItem *parent = nullptr);
    ~Elevation() override;

    qreal elevation() const;
    void setElevation(qreal elevation);
    Q_SIGNAL void elevationChanged(qreal elevation);

    const CornersGroup &corners() const;
    void setCorners(const CornersGroup &);
    Q_SIGNAL void cornersChanged(CornersGroup);

    qreal radius() const;
    void setRadius(qreal newRadius);
    Q_SIGNAL void radiusChanged(qreal radius);

    QColor color() const;
    void setColor(const QColor &newColor);
    Q_SIGNAL void colorChanged(QColor color);

    void componentComplete() override;

protected:
    void itemChange(QQuickItem::ItemChange change,
                    const QQuickItem::ItemChangeData &value) override;
    QSGNode *updatePaintNode(QSGNode *node, QQuickItem::UpdatePaintNodeData *data) override;

private:
    qreal m_elevation;
    CornersGroup m_corners;
    qreal m_radius;
    QColor m_color;
};

} // namespace Fluid