// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtTest
import Fluid as MD

Item {
    width: 320
    height: 240

    Item {
        id: lightHost
        MD.Style.theme: MD.Style.Light

        Item {
            id: lightChild
        }
    }

    Item {
        id: darkHost
        MD.Style.theme: MD.Style.Dark
    }

    Item {
        id: switchingHost
        MD.Style.theme: MD.Style.Light

        Item {
            id: switchingChild
        }

        Item {
            id: fixedDarkChild
            MD.Style.theme: MD.Style.Dark
        }
    }

    Item {
        id: systemHost
        MD.Style.theme: MD.Style.System
    }

    SignalSpy {
        id: switchingHostThemeSpy
        target: switchingHost.MD.Style
        signalName: "themeChanged"
    }

    SignalSpy {
        id: switchingChildThemeSpy
        target: switchingChild.MD.Style
        signalName: "themeChanged"
    }

    SignalSpy {
        id: fixedDarkChildThemeSpy
        target: fixedDarkChild.MD.Style
        signalName: "themeChanged"
    }

    TestCase {
        name: "ColorTokenTests"

        function schemeProperties() {
            return [
                "background", "error", "errorContainer", "inverseOnSurface",
                "inversePrimary", "inverseSurface", "onBackground", "onError",
                "onErrorContainer", "onPrimary", "onPrimaryContainer", "onPrimaryFixed",
                "onPrimaryFixedVariant", "onSecondary", "onSecondaryContainer",
                "onSecondaryFixed", "onSecondaryFixedVariant", "onSurface",
                "onSurfaceVariant", "onTertiary", "onTertiaryContainer", "onTertiaryFixed",
                "onTertiaryFixedVariant", "outline", "outlineVariant", "primary",
                "primaryContainer", "primaryFixed", "primaryFixedDim", "scrim", "secondary",
                "secondaryContainer", "secondaryFixed", "secondaryFixedDim", "surface",
                "surfaceBright", "surfaceContainer", "surfaceContainerHigh",
                "surfaceContainerHighest", "surfaceContainerLow", "surfaceContainerLowest",
                "surfaceDim", "surfaceTint", "surfaceVariant", "tertiary",
                "tertiaryContainer", "tertiaryFixed", "tertiaryFixedDim"
            ];
        }

        function lightMappings() {
            return {
                background: "neutral98", error: "error40", errorContainer: "error90",
                inverseOnSurface: "neutral95", inversePrimary: "primary80",
                inverseSurface: "neutral20", onBackground: "neutral10", onError: "error100",
                onErrorContainer: "error10", onPrimary: "primary100",
                onPrimaryContainer: "primary10", onPrimaryFixed: "primary10",
                onPrimaryFixedVariant: "primary30", onSecondary: "secondary100",
                onSecondaryContainer: "secondary10", onSecondaryFixed: "secondary10",
                onSecondaryFixedVariant: "secondary30", onSurface: "neutral10",
                onSurfaceVariant: "neutralVariant30", onTertiary: "tertiary100",
                onTertiaryContainer: "tertiary10", onTertiaryFixed: "tertiary10",
                onTertiaryFixedVariant: "tertiary30", outline: "neutralVariant50",
                outlineVariant: "neutralVariant80", primary: "primary40",
                primaryContainer: "primary90", primaryFixed: "primary90",
                primaryFixedDim: "primary80", scrim: "neutral0", secondary: "secondary40",
                secondaryContainer: "secondary90", secondaryFixed: "secondary90",
                secondaryFixedDim: "secondary80", surface: "neutral98",
                surfaceBright: "neutral98", surfaceContainer: "neutral94",
                surfaceContainerHigh: "neutral92", surfaceContainerHighest: "neutral90",
                surfaceContainerLow: "neutral96", surfaceContainerLowest: "neutral100",
                surfaceDim: "neutral87", surfaceTint: "primary40",
                surfaceVariant: "neutralVariant90", tertiary: "tertiary40",
                tertiaryContainer: "tertiary90", tertiaryFixed: "tertiary90",
                tertiaryFixedDim: "tertiary80"
            };
        }

        function darkMappings() {
            return {
                background: "neutral6", error: "error80", errorContainer: "error30",
                inverseOnSurface: "neutral20", inversePrimary: "primary40",
                inverseSurface: "neutral90", onBackground: "neutral90", onError: "error20",
                onErrorContainer: "error90", onPrimary: "primary20",
                onPrimaryContainer: "primary90", onPrimaryFixed: "primary10",
                onPrimaryFixedVariant: "primary30", onSecondary: "secondary20",
                onSecondaryContainer: "secondary90", onSecondaryFixed: "secondary10",
                onSecondaryFixedVariant: "secondary30", onSurface: "neutral90",
                onSurfaceVariant: "neutralVariant80", onTertiary: "tertiary20",
                onTertiaryContainer: "tertiary90", onTertiaryFixed: "tertiary10",
                onTertiaryFixedVariant: "tertiary30", outline: "neutralVariant60",
                outlineVariant: "neutralVariant30", primary: "primary80",
                primaryContainer: "primary30", primaryFixed: "primary90",
                primaryFixedDim: "primary80", scrim: "neutral0", secondary: "secondary80",
                secondaryContainer: "secondary30", secondaryFixed: "secondary90",
                secondaryFixedDim: "secondary80", surface: "neutral6",
                surfaceBright: "neutral24", surfaceContainer: "neutral12",
                surfaceContainerHigh: "neutral17", surfaceContainerHighest: "neutral22",
                surfaceContainerLow: "neutral10", surfaceContainerLowest: "neutral4",
                surfaceDim: "neutral6", surfaceTint: "primary80",
                surfaceVariant: "neutralVariant30", tertiary: "tertiary80",
                tertiaryContainer: "tertiary30", tertiaryFixed: "tertiary90",
                tertiaryFixedDim: "tertiary80"
            };
        }

        function verifyScheme(scheme, mappings, name) {
            const properties = schemeProperties();
            compare(properties.length, 48, name + " property count");
            compare(Object.keys(mappings).length, 48, name + " mapping count");
            for (const propertyName of properties)
                compare(scheme[propertyName], MD.Tokens.palette[mappings[propertyName]],
                        name + "." + propertyName);
        }

        function verifyStyle(style, scheme, name) {
            for (const propertyName of schemeProperties())
                compare(style[propertyName + "Color"], scheme[propertyName],
                        name + "." + propertyName + "Color");
            compare(style.shadowColor, MD.Tokens.palette.black, name + ".shadowColor");
        }

        function test_palette() {
            const expected = {
                black: "#000000",
                error0: "#000000", error10: "#410e0b", error100: "#ffffff",
                error20: "#601410", error30: "#8c1d18", error40: "#b3261e",
                error50: "#dc362e", error60: "#e46962", error70: "#ec928e",
                error80: "#f2b8b5", error90: "#f9dedc", error95: "#fceeee",
                error99: "#fffbf9",
                neutral0: "#000000", neutral10: "#1d1b20", neutral100: "#ffffff",
                neutral12: "#211f26", neutral17: "#2b2930", neutral20: "#322f35",
                neutral22: "#36343b", neutral24: "#3b383e", neutral30: "#48464c",
                neutral4: "#0f0d13", neutral40: "#605d64", neutral50: "#79767d",
                neutral6: "#141218", neutral60: "#938f96", neutral70: "#aea9b1",
                neutral80: "#cac5cd", neutral87: "#ded8e1", neutral90: "#e6e0e9",
                neutral92: "#ece6f0", neutral94: "#f3edf7", neutral95: "#f5eff7",
                neutral96: "#f7f2fa", neutral98: "#fef7ff", neutral99: "#fffbff",
                neutralVariant0: "#000000", neutralVariant10: "#1d1a22",
                neutralVariant100: "#ffffff", neutralVariant20: "#322f37",
                neutralVariant30: "#49454f", neutralVariant40: "#605d66",
                neutralVariant50: "#79747e", neutralVariant60: "#938f99",
                neutralVariant70: "#aea9b4", neutralVariant80: "#cac4d0",
                neutralVariant90: "#e7e0ec", neutralVariant95: "#f5eefa",
                neutralVariant99: "#fffbfe",
                primary0: "#000000", primary10: "#21005d", primary100: "#ffffff",
                primary20: "#381e72", primary30: "#4f378b", primary40: "#6750a4",
                primary50: "#7f67be", primary60: "#9a82db", primary70: "#b69df8",
                primary80: "#d0bcff", primary90: "#eaddff", primary95: "#f6edff",
                primary99: "#fffbfe",
                secondary0: "#000000", secondary10: "#1d192b", secondary100: "#ffffff",
                secondary20: "#332d41", secondary30: "#4a4458", secondary40: "#625b71",
                secondary50: "#7a7289", secondary60: "#958da5", secondary70: "#b0a7c0",
                secondary80: "#ccc2dc", secondary90: "#e8def8", secondary95: "#f6edff",
                secondary99: "#fffbfe",
                tertiary0: "#000000", tertiary10: "#31111d", tertiary100: "#ffffff",
                tertiary20: "#492532", tertiary30: "#633b48", tertiary40: "#7d5260",
                tertiary50: "#986977", tertiary60: "#b58392", tertiary70: "#d29dac",
                tertiary80: "#efb8c8", tertiary90: "#ffd8e4", tertiary95: "#ffecf1",
                tertiary99: "#fffbfa", white: "#ffffff"
            };
            compare(Object.keys(expected).length, 91, "palette property count");
            for (const propertyName in expected)
                compare(MD.Tokens.palette[propertyName], expected[propertyName], propertyName);
        }

        function test_lightScheme() {
            verifyScheme(MD.Tokens.light, lightMappings(), "light");
        }

        function test_darkScheme() {
            verifyScheme(MD.Tokens.dark, darkMappings(), "dark");
        }

        function test_explicitStyleRoles() {
            verifyStyle(lightHost.MD.Style, MD.Tokens.light, "light style");
            verifyStyle(darkHost.MD.Style, MD.Tokens.dark, "dark style");
        }

        function test_styleInheritanceAndSwitching() {
            switchingHost.MD.Style.theme = MD.Style.Light;
            compare(switchingChild.MD.Style.theme, MD.Style.Light);
            verifyStyle(switchingChild.MD.Style, MD.Tokens.light, "inherited light style");
            verifyStyle(fixedDarkChild.MD.Style, MD.Tokens.dark, "explicit dark child");

            switchingHost.MD.Style.theme = MD.Style.Dark;
            compare(switchingChild.MD.Style.theme, MD.Style.Dark);
            verifyStyle(switchingChild.MD.Style, MD.Tokens.dark, "inherited dark style");
            compare(fixedDarkChild.MD.Style.theme, MD.Style.Dark);
            verifyStyle(fixedDarkChild.MD.Style, MD.Tokens.dark,
                        "explicit dark child after parent switch");

            switchingHost.MD.Style.theme = MD.Style.Light;
        }

        function test_themeSignalsAndExplicitOverride() {
            switchingHost.MD.Style.theme = MD.Style.Light;
            switchingHostThemeSpy.clear();
            switchingChildThemeSpy.clear();
            fixedDarkChildThemeSpy.clear();

            switchingHost.MD.Style.theme = MD.Style.Dark;
            compare(switchingHostThemeSpy.count, 1, "parent theme signal");
            compare(switchingChildThemeSpy.count, 1, "inherited child theme signal");
            compare(fixedDarkChildThemeSpy.count, 0, "explicit child remains overridden");
            compare(fixedDarkChild.MD.Style.theme, MD.Style.Dark);

            switchingHost.MD.Style.theme = MD.Style.Light;
        }

        function test_fixedRolesAreThemeInvariant() {
            const fixedRoles = [
                "primaryFixed", "primaryFixedDim", "onPrimaryFixed",
                "onPrimaryFixedVariant", "secondaryFixed", "secondaryFixedDim",
                "onSecondaryFixed", "onSecondaryFixedVariant", "tertiaryFixed",
                "tertiaryFixedDim", "onTertiaryFixed", "onTertiaryFixedVariant"
            ];
            for (const propertyName of fixedRoles) {
                compare(MD.Tokens.light[propertyName], MD.Tokens.dark[propertyName],
                        propertyName + " token invariance");
                compare(lightHost.MD.Style[propertyName + "Color"],
                        darkHost.MD.Style[propertyName + "Color"],
                        propertyName + " style invariance");
            }
        }

        function test_systemStyleResolvesConsistently() {
            const primary = systemHost.MD.Style.primaryColor.toString();
            const isLight = primary === MD.Tokens.light.primary.toString();
            const isDark = primary === MD.Tokens.dark.primary.toString();
            verify(isLight || isDark, "System theme must resolve to the light or dark scheme");
            compare(systemHost.MD.Style.theme, isLight ? MD.Style.Light : MD.Style.Dark);
            verifyStyle(systemHost.MD.Style, isLight ? MD.Tokens.light : MD.Tokens.dark,
                        "system style");
        }

        function test_lightStyleInheritance() {
            compare(lightChild.MD.Style.theme, MD.Style.Light);
            verifyStyle(lightChild.MD.Style, MD.Tokens.light, "light child style");
        }
    }
}
