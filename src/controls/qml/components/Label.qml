// SPDX-FileCopyrightText: 2024-2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick.Templates as T
import Fluid as MD

/*!
    \class Label
    \brief Displays text using a selectable Material 3 type scale.

    The default is the Material label-medium type scale. Set \c typescale to any
    value exposed by Tokens.typescale to apply its size, weight, and tracking.

    For more information see the
    <a href="https://m3.material.io/styles/typography/overview">Material Design 3 typography guidelines</a>.
*/
T.Label {
    //! The Material type scale used to render the label.
    property MD.typescale typescale: MD.Tokens.typescale.labelMedium

    antialiasing: true

    color: MD.Style.onSurfaceVariantColor
    // TODO: linkColor from palette

    textFormat: T.Label.PlainText

    font.family: typescale.face === MD.Style.TypeFace.Brand ? MD.Style.brandFontFamily : MD.Style.plainFontFamily
    font.pixelSize: typescale.fontSize
    font.weight: typescale.fontWeight
    font.letterSpacing: typescale.tracking

    lineHeight: typescale.lineHeight
    lineHeightMode: T.Label.FixedHeight

    wrapMode: T.Label.Wrap

    elide: T.Label.ElideRight
}
