// SPDX-FileCopyrightText: 2025-2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-FileCopyrightText: 2024-2025 hypengw <hypengwip@gmail.com>
// SPDX-License-Identifier: MPL-2.0
//
// Originally based on code by hypengw, licensed under the MIT license.

#pragma once

#include <optional>

#include <QQmlEngine>
#include <QQuickItem>

namespace Fluid {

class Elevation : public QQuickItem
{
    Q_OBJECT
    QML_NAMED_ELEMENT(ElevationImpl)
    Q_PROPERTY(qreal elevation READ elevation WRITE setElevation NOTIFY elevationChanged FINAL)
    Q_PROPERTY(qreal radius READ radius WRITE setRadius NOTIFY radiusChanged FINAL)
    Q_PROPERTY(qreal topLeftRadius READ topLeftRadius WRITE setTopLeftRadius NOTIFY
                       topLeftRadiusChanged FINAL)
    Q_PROPERTY(qreal topRightRadius READ topRightRadius WRITE setTopRightRadius NOTIFY
                       topRightRadiusChanged FINAL)
    Q_PROPERTY(qreal bottomLeftRadius READ bottomLeftRadius WRITE setBottomLeftRadius NOTIFY
                       bottomLeftRadiusChanged FINAL)
    Q_PROPERTY(qreal bottomRightRadius READ bottomRightRadius WRITE setBottomRightRadius NOTIFY
                       bottomRightRadiusChanged FINAL)
    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged FINAL)
public:
    Elevation(QQuickItem *parent = nullptr);
    ~Elevation() override;

    qreal elevation() const;
    void setElevation(qreal elevation);

    qreal radius() const;
    void setRadius(qreal newRadius);

    qreal topLeftRadius() const;
    void setTopLeftRadius(qreal newTopLeftRadius);

    qreal topRightRadius() const;
    void setTopRightRadius(qreal newTopRightRadius);

    qreal bottomLeftRadius() const;
    void setBottomLeftRadius(qreal newBottomLeftRadius);

    qreal bottomRightRadius() const;
    void setBottomRightRadius(qreal newBottomRightRadius);

    QColor color() const;
    void setColor(const QColor &newColor);

    void componentComplete() override;

Q_SIGNALS:
    void elevationChanged(qreal elevation);
    void radiusChanged(qreal radius);
    void topLeftRadiusChanged(qreal topLeftRadius);
    void topRightRadiusChanged(qreal topRightRadius);
    void bottomLeftRadiusChanged(qreal bottomLeftRadius);
    void bottomRightRadiusChanged(qreal bottomRightRadius);
    void colorChanged(QColor color);

protected:
    void itemChange(QQuickItem::ItemChange change,
                    const QQuickItem::ItemChangeData &value) override;
    QSGNode *updatePaintNode(QSGNode *node, QQuickItem::UpdatePaintNodeData *data) override;

private:
    qreal m_elevation = 0.0;
    qreal m_radius = 0.0;
    std::optional<qreal> m_topLeftRadius;
    std::optional<qreal> m_topRightRadius;
    std::optional<qreal> m_bottomLeftRadius;
    std::optional<qreal> m_bottomRightRadius;
    QColor m_color = Qt::black;
};

} // namespace Fluid