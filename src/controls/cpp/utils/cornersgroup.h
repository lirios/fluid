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
#include <QVector4D>

namespace Fluid {

class CornersGroup
{
    Q_GADGET
    QML_VALUE_TYPE(corners)
    QML_CONSTRUCTIBLE_VALUE
    Q_PROPERTY(qreal radius READ radius FINAL)
    Q_PROPERTY(qreal topLeft READ topLeft WRITE setTopLeft FINAL)
    Q_PROPERTY(qreal topRight READ topRight WRITE setTopRight FINAL)
    Q_PROPERTY(qreal bottomLeft READ bottomLeft WRITE setBottomLeft FINAL)
    Q_PROPERTY(qreal bottomRight READ bottomRight WRITE setBottomRight FINAL)
public:
    Q_INVOKABLE CornersGroup() noexcept;
    Q_INVOKABLE CornersGroup(qreal) noexcept;
    Q_INVOKABLE CornersGroup(qreal topLeft, qreal topRight, qreal bottomLeft,
                             qreal bottomRight) noexcept;
    ~CornersGroup();

    CornersGroup(const CornersGroup &) = default;
    CornersGroup(CornersGroup &&) = default;
    CornersGroup &operator=(const CornersGroup &) = default;
    CornersGroup &operator=(CornersGroup &&) = default;

    qreal radius() const noexcept;
    void setRadius(qreal) noexcept;

    qreal topLeft() const noexcept;
    void setTopLeft(qreal newTopLeft) noexcept;

    qreal topRight() const noexcept;
    void setTopRight(qreal newTopRight) noexcept;

    qreal bottomLeft() const noexcept;
    void setBottomLeft(qreal newBottomLeft) noexcept;

    qreal bottomRight() const noexcept;
    void setBottomRight(qreal newBottomRight) noexcept;

    Q_INVOKABLE QVector4D toVector4D() const noexcept;
    operator QVector4D() const noexcept;

private:
    qreal m_bottomRight;
    qreal m_topRight;
    qreal m_bottomLeft;
    qreal m_topLeft;
};

} // namespace Fluid