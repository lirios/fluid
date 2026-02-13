/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2024-2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQuick.Templates as T
import Fluid as MD

T.Label {
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
