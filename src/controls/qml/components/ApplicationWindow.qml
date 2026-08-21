// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick.Templates as T
import Fluid as MD

/*!
    \class ApplicationWindow
    \brief A top-level application window with Material 3 color and typography defaults.

    ApplicationWindow applies the current surface color and type scale to the window.
    Child controls inherit the resulting font unless they select another type scale.

    For more information see the Material Design 3
    <a href="https://m3.material.io/styles/color/system/overview">color</a> and
    <a href="https://m3.material.io/styles/typography/overview">typography</a> guidelines.
*/
T.ApplicationWindow {
    //! The default Material type scale inherited by content in the window.
    property MD.typescale typescale: MD.Tokens.typescale.bodyMedium

    color: MD.Style.surfaceColor

    font.family: typescale.face === MD.Style.TypeFace.Brand ? MD.Style.brandFontFamily : MD.Style.plainFontFamily
    font.pixelSize: typescale && typescale.size !== undefined ? typescale.size : MD.Tokens.typescale.bodyMedium.fontSize
    font.weight: typescale && typescale.weight !== undefined ? typescale.weight : MD.Tokens.typescale.bodyMedium.fontWeight
    font.letterSpacing: typescale && typescale.tracking !== undefined ? typescale.tracking : MD.Tokens.typescale.bodyMedium.tracking
}
