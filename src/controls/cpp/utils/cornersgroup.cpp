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

#include "cornersgroup.h"

namespace Fluid {

/**
 * @class Fluid::CornersGroup
 * @brief Represents the corner radii for a rectangular material-design shape.
 *
 * CornersGroup stores four independent corner radii (top-left, top-right,
 * bottom-left, bottom-right) used to describe the rounded corners of a shape.
 * Radii are expressed in the framework's logical units (qreal) and may be
 * converted to a QVector4D for GPU/paint operations or uniform uploads.
 *
 * The class is lightweight, trivially copyable, and all accessor and mutator
 * operations are noexcept.
 *
 * Usage notes:
 * - Use setRadius() to set a uniform radius on all corners.
 * - radius() returns the maximum of the four corner values — useful when a
 *   single conservative inset or bound is required.
 * - toVector4D() / operator QVector4D() return the corner radii packed as a
 *   QVector4D in the order: (top-left, top-right, bottom-left, bottom-right).
 *
 * Threading:
 * - Instances are not internally synchronized. Concurrent access must be
 *   externally synchronized if mutations may occur.
 *
 * Examples:
 * @code
 * // uniform rounded rectangle
 * Fluid::CornersGroup u(4.0);
 *
 * // different radii
 * Fluid::CornersGroup c(5.0, 3.0, 4.0, 2.0);
 *
 * // upload to shader as vec4: (tl, tr, bl, br)
 * QVector4D v = c.toVector4D();
 * @endcode
 */

/**
 * @brief Default constructs all radii to 0.
 */
CornersGroup::CornersGroup() noexcept
    : CornersGroup(0)
{
}

/**
 * @brief Constructs with all four radii set to r.
 * @param r Radius applied to all corners.
 */
CornersGroup::CornersGroup(qreal r) noexcept
    : CornersGroup(r, r, r, r)
{
}

/**
 * @brief Constructs with individually specified radii.
 * @param topLeft Radius for the top-left corner.
 * @param topRight Radius for the top-right corner.
 * @param bottomLeft Radius for the bottom-left corner.
 * @param bottomRight Radius for the bottom-right corner.
 */
CornersGroup::CornersGroup(qreal topLeft, qreal topRight, qreal bottomLeft,
                           qreal bottomRight) noexcept
    : m_bottomRight(bottomRight)
    , m_topRight(topRight)
    , m_bottomLeft(bottomLeft)
    , m_topLeft(topLeft)
{
}

/**
 * @brief Default destructor.
 */
CornersGroup::~CornersGroup()
{
}

/**
 * @brief Returns the largest of the four corner radii.
 * - Useful when computing a conservative inset or collision radius.
 * @return maximum of (top-left, top-right, bottom-left, bottom-right).
 */
auto CornersGroup::radius() const noexcept -> qreal
{
    // return max
    return std::max({ m_topLeft, m_topRight, m_bottomLeft, m_bottomRight });
}

/**
 * @brief Sets all four corner radii to the same value.
 * @param v Radius value applied to every corner.
 */
void CornersGroup::setRadius(qreal v) noexcept
{
    m_topLeft = v;
    m_topRight = v;
    m_bottomLeft = v;
    m_bottomRight = v;
}

/**
 * @brief Returns the top-left corner radius.
 * @return top-left corner radius.
 */
qreal CornersGroup::topLeft() const noexcept
{
    return m_topLeft;
}

/**
 * @brief Sets the top-left corner radius.
 * @param newTopLeft New radius for the top-left corner.
 */
void CornersGroup::setTopLeft(qreal newTopLeft) noexcept
{
    m_topLeft = newTopLeft;
}

/**
 * @brief Returns the top-right corner radius.
 * @return top-right corner radius.
 */
qreal CornersGroup::topRight() const noexcept
{
    return m_topRight;
}

/**
 * @brief Sets the top-right corner radius.
 * @param newTopRight New radius for the top-right corner.
 */
void CornersGroup::setTopRight(qreal newTopRight) noexcept
{
    m_topRight = newTopRight;
}

/**
 * @brief Returns the bottom-left corner radius.
 * @return bottom-left corner radius.
 */
qreal CornersGroup::bottomLeft() const noexcept
{
    return m_bottomLeft;
}

/**
 * @brief Sets the bottom-left corner radius.
 * @param newBottomLeft New radius for the bottom-left corner.
 */
void CornersGroup::setBottomLeft(qreal newBottomLeft) noexcept
{
    m_bottomLeft = newBottomLeft;
}

/**
 * @brief Returns the bottom-right corner radius.
 * @return bottom-right corner radius.
 */
qreal CornersGroup::bottomRight() const noexcept
{
    return m_bottomRight;
}

/**
 * @brief Sets the bottom-right corner radius.
 * @param newBottomRight New radius for the bottom-right corner.
 */
void CornersGroup::setBottomRight(qreal newBottomRight) noexcept
{
    m_bottomRight = newBottomRight;
}

/**
 * @brief Converts the corner radii to a QVector4D.
 * @return QVector4D representation of the corner radii.
 */
QVector4D CornersGroup::toVector4D() const noexcept
{
    return QVector4D{ (float)m_topLeft, (float)m_topRight, (float)m_bottomLeft,
                      (float)m_bottomRight };
}

/**
 * @brief Conversion operator to QVector4D.
 * @return QVector4D representation of the corner radii.
 */
CornersGroup::operator QVector4D() const noexcept
{
    return toVector4D();
}

} // namespace Fluid