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

#include <QSGMaterial>

namespace Fluid::SceneGraph {

class ElevationMaterial : public QSGMaterial
{
public:
    ElevationMaterial();
    ~ElevationMaterial();

    QSGMaterialShader *createShader(QSGRendererInterface::RenderMode) const override;
    QSGMaterialType *type() const override;
    int compare(const QSGMaterial *other) const override;

    void init_fadeoff_texture(QQuickWindow *win);
    auto strength_texture() -> QSGTexture *;

private:
    QSGTexture *m_fadeoff_texture;
};

class ElevationShader : public QSGMaterialShader
{
public:
    ElevationShader();

    bool updateUniformData(QSGMaterialShader::RenderState &state, QSGMaterial *newMaterial,
                           QSGMaterial *oldMaterial) override;

    void updateSampledImage(RenderState &, int binding, QSGTexture **texture,
                            QSGMaterial *newMaterial, QSGMaterial *) override;
};

} // namespace Fluid::SceneGraph