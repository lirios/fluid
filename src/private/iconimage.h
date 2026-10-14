// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtGui/qcolor.h>
#include <QtGui/qimage.h>
#include <QtQml/qqmlregistration.h>
#include <QtQuick/private/qquickimage_p.h>

namespace Fluid {

/*! \brief Private image renderer with an optional alpha-preserving tint. */
class IconImage : public QQuickImage
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged FINAL)

public:
    explicit IconImage(QQuickItem *parent = nullptr);

    QColor color() const;
    void setColor(const QColor &color);

signals:
    void colorChanged();

protected:
    void pixmapChange() override;

private:
    void applyTint();

    QColor m_color = Qt::transparent;
    QImage m_sourceImage;
};

} // namespace Fluid
