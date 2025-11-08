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

#include <QSGGeometry>
#include <QColor>
#include <QVector4D>

namespace Fluid::SceneGraph {

struct BasicVertex
{
    // position
    float x;
    float y;

    // color
    float r;
    float g;
    float b;
    float a;

    void setPoint(float x, float y) noexcept
    {
        this->x = x;
        this->y = y;
    }
    void setPoint(QVector2D v) noexcept
    {
        x = v.x();
        y = v.y();
    }
    void setColor(QRgb c) noexcept
    {
        r = qRed(c) / 255.0f;
        g = qGreen(c) / 255.0f;
        b = qBlue(c) / 255.0f;
        a = qAlpha(c) / 255.0f;
    }
    void setColor(const QColor &c) noexcept
    {
        setColor(c.rgb());
    }
};

struct RectangleVertex : BasicVertex
{
    // circle edge
    float ce_x; // if in x edge
    float ce_y; // if in y edge
    float ce_distance_to_outter; // from inner rect
    float ce_distance_to_inner; // from inner rect

    operator QVector2D() const
    {
        return { x, y };
    }
    operator QColor() const
    {
        return QColor::fromRgbF(r, g, b, a);
    }
};

std::unique_ptr<QSGGeometry, std::default_delete<QSGGeometry>> createRectangleGeometry();

// tl tr bl br
void updateRectangleGeometry(RectangleVertex *vertexs, QVector2D size, QRgb color,
                             QVector4D radius);

struct ShadowVertex : BasicVertex
{
    // shadow
    float offset_x;
    float offset_y;
    float distance_correction;

    void setOffset(QVector2D v) noexcept
    {
        offset_x = v.x();
        offset_y = v.y();
    }
};

std::unique_ptr<QSGGeometry, std::default_delete<QSGGeometry>> createShadowGeometry();

enum ShadowFlags {
    None_ShadowFlag = 0x00,
    /** The occluding object is not opaque. Knowing that the occluder is opaque allows
     * us to cull shadow geometry behind it and improve performance. */
    TransparentOccluder_ShadowFlag = 0x01,
    /** Don't try to use analytic shadows. */
    GeometricOnly_ShadowFlag = 0x02,
    /** Light position represents a direction, light radius is blur radius at elevation 1 */
    DirectionalLight_ShadowFlag = 0x04,
    /** Concave paths will only use blur to generate the shadow */
    ConcaveBlurOnly_ShadowFlag = 0x08,
    /** mask for all shadow flags */
    All_ShadowFlag = 0x0F
};

struct ShadowParams
{
    QVector3D z_plane_params;
    QVector3D light_pos;
    float light_radius{ 0 };
    QRgb ambient_color{ 0 };
    QRgb spot_color{ 0 };
    uint32_t flags{ 0 };
    QVector4D radius;
};

void updateShadowGeometry(QSGGeometry *geo, const ShadowParams &params, const QRectF &rect);

} // namespace Fluid::SceneGraph