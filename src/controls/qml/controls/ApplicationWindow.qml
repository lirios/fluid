// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick.Templates as T
import Fluid as MD

T.ApplicationWindow {
    property MD.typescale typescale: MD.Tokens.typescale.bodyMedium

    color: MD.Style.surfaceColor

    font.family: typescale.face === MD.Style.TypeFace.Brand ? MD.Style.brandFontFamily : MD.Style.plainFontFamily
    font.pixelSize: typescale.size
    font.weight: typescale.weight
    font.letterSpacing: typescale.tracking
}
