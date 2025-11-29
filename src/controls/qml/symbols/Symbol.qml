// Copyright (C) 2025 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import Fluid as MD

/*!
    \brief Displays an icon from the Material Symbols collection.

    To use an icon from the <a href="https://fonts.google.com/icons">Material Symbols collection</a>.
    Material Symbols are a set of icons consisting of over 2500 glyphs in a single font file with
    a wide range of design variants, check the
    <a href="https://developers.google.com/fonts/docs/material_symbols">guide here</a>.

    Set the \c name property to the name of the icon in its group in the form of \c group/icon_name. For example:
    \code{.qml}
    import QtQuick
    import Fluid as MD

    MD.Symbol {
        name: MD.SymbolNames.symbolShoppingCart
    }
    \endcode

    This icon will by default use the light icon color from Material Design. To use the dark icon
    color:
    \code{.qml}
    import QtQuick
    import Fluid as MD

    MD.Symbol {
        MD.Style.theme: MD.Style.Dark

        name: MD.SymbolNames.symbolShoppingCart
    }
    \endcode
*/
Item {
    id: icon

    enum Style {
        Outlined,
        Rounded,
        Sharp
    }

    enum Grade {
        LowEmphasis,
        NormalEmphasis,
        HighEmphasis
    }

    enum OpticalSize {
        Small,
        Normal,
        Medium,
        Large
    }

    /*!
        The name of the icon.
    */
    property string name

    /*!
        The size of the icon. Defaults to 24px.
    */
    property int size: 24

    /*!
        The color of the icon.
    */
    property color color: MD.Style.onBackgroundColor

    /*!
        The symbol style.
    */
    property int style: Symbol.Style.Outlined

    /*!
        Symbol stroke weight. Weight can also affect the overall size of the symbol.
    */
    property int weight: Font.Normal

    /*!
        Filled state.
    */
    property bool fill: false

    /*!
        Emphasis of the symbol. Defaults to 0 (normal emphasis).
        Adjustments to grade are more granular than adjustments to weight and have a small impact
        on the size of the symbol.

        * Low emphasis: to reduce glare for a light symbol on a dark background.
        * Normal emphasis: symbol is not highlighted.
        * High emphasis: to highlight a symbol.
    */
    property int grade: Symbol.Grade.NormalEmphasis

    /*
        Automatically adjust the stroke weight when the symbol size is increased or decreased.
        Optical size ranges from 20dp to 48dp.
        Defaults to OpticalSize.Normal.
     */
    property int opticalSize: Symbol.OpticalSize.Normal

    property alias horizontalAlignment: text.horizontalAlignment
    property alias verticalAlignment: text.verticalAlignment

    property real _fill: icon.fill ? 1.0 : 0.0
    Behavior on _fill {
        NumberAnimation {
            duration: 250
        }
    }

    implicitWidth: size
    implicitHeight: size

    Text {
        id: text

        anchors.centerIn: parent

        font.family: {
            switch (icon.style) {
            case Symbol.Style.Rounded:
                return MD.Theme.symbolsRoundedFontFamily;
            case Symbol.Style.Sharp:
                return MD.Theme.symbolsSharpFontFamily;
            case Symbol.Style.Outlined:
            default:
                return MD.Theme.symbolsOutlinedFontFamily;
            }
        }
        font.variableAxes: {
            const fillValues = [0, 0.25, 0.5, 0.75, 1];
            const gradeValues = [-25, 0, 200];
            const weightValues = [Font.Thin, Font.ExtraLight, Font.Light, Font.Normal, Font.Medium, Font.DemiBold, Font.Bold];
            const opticalSizes = [20, 24, 40, 48];

            function closestValue(arr, val) {
                if (val <= arr[0])
                    return arr[0];
                if (val >= arr[arr.length - 1])
                    return arr[arr.length - 1];
                for (let i = 0; i < arr.length; ++i) {
                    if (val <= arr[i])
                        return arr[i];
                }
                return arr[arr.length - 1];
            }

            const variableAxes = {
                "FILL": closestValue(fillValues, icon._fill),
                "GRAD": closestValue(gradeValues, icon.grade),
                "wght": closestValue(weightValues, icon.weight),
                "opsz": closestValue(opticalSizes, icon.opticalSize)
            };
            return variableAxes;
        }
        font.pixelSize: icon.size / scale

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        text: MD.SymbolMappings.getSymbolName(icon.name) ?? "\u2753"
        textFormat: Text.PlainText

        // lineHeight: MD.Token.typescale.labelLarge.lineHeight
        lineHeightMode: Text.FixedHeight

        // scale: 1.0 / MD.Token.calculateCurveScale(Screen.devicePixelRatio)

        color: icon.color
    }
}
