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

#include "rectanglematerial.h"

using namespace Qt::StringLiterals;

namespace Fluid::SceneGraph {

RectangleMaterial::RectangleMaterial()
{
    setFlag(QSGMaterial::Blending, true);
}

QSGMaterialShader *RectangleMaterial::createShader(QSGRendererInterface::RenderMode) const
{
    return new RectangleShader{};
}

QSGMaterialType *RectangleMaterial::type() const
{
    static QSGMaterialType staticType;
    return &staticType;
}

int RectangleMaterial::compare(const QSGMaterial *other) const
{
    // auto material = static_cast<const RectangleMaterial *>(other);
    return QSGMaterial::compare(other);
}

RectangleShader::RectangleShader()
{
    setShaderFileName(QSGMaterialShader::VertexStage,
                      ":/Fluid/assets/shaders/rectangle.vert.qsb"_L1);
    setShaderFileName(QSGMaterialShader::FragmentStage,
                      ":/Fluid/assets/shaders/rectangle.frag.qsb"_L1);
}

bool RectangleShader::updateUniformData(RenderState &state, QSGMaterial *newMaterial,
                                        QSGMaterial *oldMaterial)
{
    Q_UNUSED(newMaterial);
    Q_UNUSED(oldMaterial);
    bool changed = false;
    QByteArray *buf = state.uniformData();
    Q_ASSERT(buf->size() >= 68);

    if (state.isMatrixDirty()) {
        const QMatrix4x4 m = state.combinedMatrix();
        memcpy(buf->data(), m.constData(), 64);
        changed = true;
    }

    if (state.isOpacityDirty()) {
        const float opacity = state.opacity();
        memcpy(buf->data() + 64, &opacity, 4);
        changed = true;
    }
    return changed;
}

} // namespace Fluid::SceneGraph