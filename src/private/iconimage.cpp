// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#include "iconimage.h"

#include <QtGui/qpainter.h>
#include <QtQuick/private/qquickimagebase_p_p.h>

namespace Fluid {

IconImage::IconImage(QQuickItem *parent)
    : QQuickImage(parent)
{
}

QColor IconImage::color() const
{
    return m_color;
}

void IconImage::setColor(const QColor &color)
{
    if (m_color == color)
        return;

    m_color = color;
    // A pixmap may still be receiving asynchronous data. Apply the latest
    // color when that load completes rather than replacing its pending request.
    if (!m_sourceImage.isNull() && status() != Loading) {
        applyTint();
        QQuickImage::pixmapChange();
        update();
    }
    emit colorChanged();
}

void IconImage::pixmapChange()
{
    // Keep the untinted pixels so color changes never accumulate and a
    // transparent tint can restore the source without another load.
    m_sourceImage = image();
    if (m_color.alpha() > 0)
        applyTint();
    QQuickImage::pixmapChange();
}

void IconImage::applyTint()
{
    if (m_sourceImage.isNull())
        return;

    QImage rendered = m_sourceImage;
    if (m_color.alpha() > 0) {
        rendered = rendered.convertToFormat(QImage::Format_ARGB32_Premultiplied);
        QPainter painter(&rendered);
        painter.setCompositionMode(QPainter::CompositionMode_SourceIn);
        painter.fillRect(rendered.rect(), m_color);
    }

    // Replace only this item's pixmap, leaving the shared source cache intact.
    // Tinting pixels also works with the software scene graph backend.
    QQuickImageBasePrivate::get(this)->currentPix->setImage(rendered);
}

} // namespace Fluid
