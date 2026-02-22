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

class Rectangle : public QQuickItem
{
    Q_OBJECT
    QML_NAMED_ELEMENT(RectangleImpl)

    Q_PROPERTY(qreal radius READ radius WRITE setRadius NOTIFY radiusChanged FINAL)
    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged FINAL)
    Q_PROPERTY(CornersGroup corners READ corners WRITE setCorners NOTIFY cornersChanged FINAL)
public:
    Rectangle(QQuickItem *parent = nullptr);
    ~Rectangle() override;

    CornersGroup corners() const;
    void setCorners(const CornersGroup &);

    qreal radius() const;
    void setRadius(qreal newRadius);

    QColor color() const;
    void setColor(const QColor &newColor);

    void componentComplete() override;

Q_SIGNALS:
    void cornersChanged();
    void radiusChanged();
    void colorChanged();

protected:
    void itemChange(QQuickItem::ItemChange change,
                    const QQuickItem::ItemChangeData &value) override;
    QSGNode *updatePaintNode(QSGNode *node, QQuickItem::UpdatePaintNodeData *data) override;

private:
    CornersGroup m_corners;
    qreal m_radius;
    QColor m_color;
};

} // namespace Fluid