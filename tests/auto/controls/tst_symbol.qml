// SPDX-FileCopyrightText: 2018 Michael Spencer <sonrisesoftware@gmail.com>
// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtTest
import Fluid as MD

TestCase {
    id: testCase
    name: "SymbolTests"
    width: 160
    height: 160
    visible: true
    when: windowShown

    Component {
        id: symbolComponent
        MD.Symbol { name: MD.Symbols.settings }
    }

    function renderedText(symbol) {
        return symbol.children.find(child => child instanceof Text);
    }

    function test_name_and_size() {
        const symbol = createTemporaryObject(symbolComponent, testCase);
        verify(symbol);
        const text = renderedText(symbol);
        verify(text);
        compare(text.text, MD.Symbols.settings);
        compare(symbol.implicitWidth, MD.Tokens.symbol.size);
        compare(symbol.implicitHeight, MD.Tokens.symbol.size);

        symbol.name = MD.Symbols.search;
        compare(text.text, MD.Symbols.search);
        symbol.iconWidth = 40;
        symbol.iconHeight = 32;
        compare(symbol.implicitWidth, 40);
        compare(symbol.implicitHeight, 32);
        compare(text.font.pixelSize, 40);
    }

    function test_font_family_data() {
        return [
            { tag: "outlined", style: MD.Symbol.Style.Outlined,
              family: MD.Theme.symbolsOutlinedFontFamily },
            { tag: "rounded", style: MD.Symbol.Style.Rounded,
              family: MD.Theme.symbolsRoundedFontFamily },
            { tag: "sharp", style: MD.Symbol.Style.Sharp,
              family: MD.Theme.symbolsSharpFontFamily }
        ];
    }

    function test_font_family(data) {
        const symbol = createTemporaryObject(symbolComponent, testCase, { style: data.style });
        verify(symbol);
        compare(renderedText(symbol).font.family, data.family);
    }

    function test_fill_and_color() {
        const symbol = createTemporaryObject(symbolComponent, testCase);
        const text = renderedText(symbol);
        compare(text.font.variableAxes.FILL, 0);
        compare(text.renderType, Text.QtRendering);

        symbol.fill = true;
        compare(text.font.variableAxes.FILL, 1);
        compare(text.renderType, Text.NativeRendering);
        symbol.color = "#123456";
        compare(text.color, "#123456");
    }

    function test_theme_color_data() {
        return [
            { tag: "light", theme: MD.Style.Light },
            { tag: "dark", theme: MD.Style.Dark }
        ];
    }

    function test_theme_color(data) {
        const symbol = createTemporaryObject(symbolComponent, testCase, { "MD.Style.theme": data.theme });
        verify(symbol);
        compare(symbol.MD.Style.theme, data.theme);
        compare(symbol.color, symbol.MD.Style.onBackgroundColor);
        compare(renderedText(symbol).color, symbol.color);
    }
}
