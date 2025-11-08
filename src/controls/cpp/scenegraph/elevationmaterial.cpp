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

#include <mutex>

#include <QImage>
#include <QQuickWindow>
#include <QSGTexture>

#include "elevationmaterial.h"
#include "skia_shadow.h"

using namespace Qt::StringLiterals;

namespace Fluid::SceneGraph {

ElevationMaterial::ElevationMaterial()
    : m_fadeoff_texture(nullptr)
{
    setFlag(QSGMaterial::Blending, true);
}

ElevationMaterial::~ElevationMaterial()
{
    delete m_fadeoff_texture;
}

QSGMaterialShader *ElevationMaterial::createShader(QSGRendererInterface::RenderMode) const
{
    return new ElevationShader{};
}

QSGMaterialType *ElevationMaterial::type() const
{
    static QSGMaterialType staticType;
    return &staticType;
}

int ElevationMaterial::compare(const QSGMaterial *other) const
{
    // auto material = static_cast<const ElevationMaterial *>(other);
    return QSGMaterial::compare(other);
}

auto ElevationMaterial::strength_texture() -> QSGTexture *
{
    return m_fadeoff_texture;
}
void ElevationMaterial::init_fadeoff_texture(QQuickWindow *win)
{
    const int width = 128;
    const int height = 1;
    // Create a grayscale image (R8 equivalent)
    QImage image(width, height, QImage::Format_Grayscale8);

    // Fill the image with values for the red channel (e.g., gradient)
    uchar *row = image.scanLine(0);
    for (int i = 0; i < 128; i++) {
        float d = Skia::SK_Scalar1 - i / 127.0f;
        row[i] = Skia::SkScalarRoundToInt(((float)std::exp(-4 * d * d) - 0.018f) * 255);
    }

    // Create the texture from the grayscale image
    QSGTexture *texture = win->createTextureFromImage(image);
    m_fadeoff_texture = texture;
}

ElevationShader::ElevationShader()
{
    setShaderFileName(QSGMaterialShader::VertexStage, ":/Fluid/assets/shaders/shadow.vert.qsb"_L1);
    setShaderFileName(QSGMaterialShader::FragmentStage,
                      ":/Fluid/assets/shaders/shadow.frag.qsb"_L1);
}

bool ElevationShader::updateUniformData(RenderState &state, QSGMaterial *newMaterial,
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
        const float opacity = std::pow(state.opacity(), 3);
        memcpy(buf->data() + 64, &opacity, 4);
        changed = true;
    }
    return changed;
}

void ElevationShader::updateSampledImage(RenderState &state, int binding, QSGTexture **texture,
                                         QSGMaterial *newMaterial, QSGMaterial *)
{
    auto mat = static_cast<ElevationMaterial *>(newMaterial);
    if (binding == 1) {
        *texture = mat->strength_texture();
        texture[0]->commitTextureOperations(state.rhi(), state.resourceUpdateBatch());
    }
}

} // namespace Fluid::SceneGraph