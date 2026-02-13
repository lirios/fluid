// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick.Templates as T

T.Button {
    /*!
        This property determines how the icon and text are displayed within the button.
    */
    enum Display {
        IconOnly,
        TextOnly,
        TextBesideIcon,
        TextUnderIcon
    }

    //! The type of button to display. This controls the default background and foreground colors, as well as the elevation.
    enum Type {
        Elevated,
        Filled,
        Tonal,
        Outlined,
        Text
    }

    /*!
        The shape of the button. This controls the corner radius and overall appearance.
        Shape morphs when the button is pressed or selected.
    */
    enum Shape {
        Round,
        Square
    }

    //! The size of the button. This controls the padding, font size, and overall dimensions.
    enum Size {
        ExtraSmall,
        Small,
        Medium,
        Large,
        ExtraLarge
    }
}
