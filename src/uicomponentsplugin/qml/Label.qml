/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (c) 2012 Pier Luigi Fiorini
 * Copyright (c) 2011 Marco Martin
 *
 * Author(s):
 *    Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *    Marco Martin <mart@kde.org>
 *
 * $BEGIN_LICENSE:LGPL-ONLY$
 *
 * This file may be used under the terms of the GNU Lesser General
 * Public License as published by the Free Software Foundation and
 * appearing in the file LICENSE.LGPL included in the packaging of
 * this file, either version 2.1 of the License, or (at your option) any
 * later version.  Please review the following information to ensure the
 * GNU Lesser General Public License version 2.1 requirements
 * will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
 *
 * If you have questions regarding the use of this file, please contact
 * us via http://www.maui-project.org/.
 *
 * $END_LICENSE$
 ***************************************************************************/

/**Documented API
Inherits:
        Text

Imports:
        QtQuick 2.0
        FluidCore

Description:
    This is a label which uses the plasma theme.
    The characteristics of the text will be automatically set
    according to the plasma theme. If you need a more customized
    text item use the Text component from QtQuick.

Properties:
    string text:
    The most important property is "text".
    For the other ones see the primitive QML Text element

Methods:
    See the primitive QML Text element

Signals:
    See the primitive QML Text element
**/

import QtQuick 2.0
import FluidCore 1.0 as FluidCore

Text {
    id: root

    height: Math.max(paintedHeight, theme.defaultFont.mSize.height*1.6)
    verticalAlignment: lineCount > 1 ? Text.AlignTop : Text.AlignVCenter

    font.capitalization: theme.defaultFont.capitalization
    font.family: theme.defaultFont.family
    font.italic: theme.defaultFont.italic
    font.letterSpacing: theme.defaultFont.letterSpacing
    font.pointSize: theme.defaultFont.pointSize
    font.strikeout: theme.defaultFont.strikeout
    font.underline: theme.defaultFont.underline
    font.weight: theme.defaultFont.weight
    font.wordSpacing: theme.defaultFont.wordSpacing
    color: theme.windowTextColor
}
