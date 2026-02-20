// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QRgb>

namespace Palette {

enum ToneIndex {
    Tone0 = 0,
    Tone4,
    Tone5,
    Tone6,
    Tone10,
    Tone12,
    Tone15,
    Tone17,
    Tone20,
    Tone22,
    Tone24,
    Tone25,
    Tone30,
    Tone35,
    Tone40,
    Tone50,
    Tone60,
    Tone70,
    Tone80,
    Tone87,
    Tone90,
    Tone92,
    Tone94,
    Tone95,
    Tone96,
    Tone98,
    Tone99,
    Tone100
};

enum PaletteType {
    Primary = 0,
    Secondary,
    Tertiary,
    Error,
    Neutral,
    NeutralVariant
};

// Material Design reference palette in tone order.
//
// It is defined as [type][tone]
// Type is defined in PaletteType.
// Tone is defined in ToneIndex.
//
// Palette values are stored as QRgb for efficient conversion to QColor.
//
// Source: https://m3.material.io/styles/color/the-color-system/tokens
// Source:
// https://github.com/material-foundation/material-tokens/blob/main/dsp/dist/styledictionary/css/variables.css
static const QRgb refPalette[6][28] = {
    // Primary
    {
            0xff000000u, // Tone 0
            0xff10002fu, // Tone 4
            0xff14003bu, // Tone 5
            0xff170042u, // Tone 6
            0xff21005du, // Tone 10
            0xff260563u, // Tone 12
            0xff2d0c6bu, // Tone 15
            0xff31136eu, // Tone 17
            0xff381e72u, // Tone 20
            0xff3c2577u, // Tone 22
            0xff412c7cu, // Tone 24
            0xff43307eu, // Tone 25
            0xff4f378bu, // Tone 30
            0xff5b4397u, // Tone 35
            0xff6750a4u, // Tone 40
            0xff7f67beu, // Tone 50
            0xff9a82dbu, // Tone 60
            0xffb69df8u, // Tone 70
            0xffd0bcffu, // Tone 80
            0xffe2d3ffu, // Tone 87
            0xffeaddffu, // Tone 90
            0xffefe3ffu, // Tone 92
            0xfff4eaffu, // Tone 94
            0xfff6edffu, // Tone 95
            0xfff9f0ffu, // Tone 96
            0xfffef7ffu, // Tone 98
            0xfffffbfeu, // Tone 99
            0xffffffffu, // Tone 100
    },
    // Secondary
    {
            0xff000000u, // Tone 0
            0xff0f0d12u, // Tone 4
            0xff131017u, // Tone 5
            0xff15121bu, // Tone 6
            0xff1d192bu, // Tone 10
            0xff211d2fu, // Tone 12
            0xff282336u, // Tone 15
            0xff2c273au, // Tone 17
            0xff332d41u, // Tone 20
            0xff373145u, // Tone 22
            0xff3c364au, // Tone 24
            0xff3e384cu, // Tone 25
            0xff4a4458u, // Tone 30
            0xff564f64u, // Tone 35
            0xff625b71u, // Tone 40
            0xff7a7289u, // Tone 50
            0xff958da5u, // Tone 60
            0xffb0a7c0u, // Tone 70
            0xffccc2dcu, // Tone 80
            0xffe0d6f0u, // Tone 87
            0xffe8def8u, // Tone 90
            0xffeee4fbu, // Tone 92
            0xfff3eafeu, // Tone 94
            0xfff6edffu, // Tone 95
            0xfff9f0ffu, // Tone 96
            0xfffef7ffu, // Tone 98
            0xfffffbfeu, // Tone 99
            0xffffffffu, // Tone 100
    },
    // Tertiary
    {
            0xff000000u, // Tone 0
            0xff180812u, // Tone 4
            0xff1e0a16u, // Tone 5
            0xff220b17u, // Tone 6
            0xff31111du, // Tone 10
            0xff361622u, // Tone 12
            0xff3d1d29u, // Tone 15
            0xff42202du, // Tone 17
            0xff4a2532u, // Tone 20
            0xff4f2936u, // Tone 22
            0xff542e3bu, // Tone 24
            0xff56303du, // Tone 25
            0xff633b48u, // Tone 30
            0xff704654u, // Tone 35
            0xff7d5260u, // Tone 40
            0xff986977u, // Tone 50
            0xffb58392u, // Tone 60
            0xffd29dacu, // Tone 70
            0xffefb8c8u, // Tone 80
            0xfffacedcu, // Tone 87
            0xffffd8e4u, // Tone 90
            0xffffe0e9u, // Tone 92
            0xffffe8eeu, // Tone 94
            0xffffecf1u, // Tone 95
            0xfffff0f3u, // Tone 96
            0xfffff8f8u, // Tone 98
            0xfffffbfau, // Tone 99
            0xffffffffu, // Tone 100
    },
    // Error
    {
            0xff000000u, // Tone 0
            0xff240504u, // Tone 4
            0xff2d0605u, // Tone 5
            0xff310806u, // Tone 6
            0xff410e0bu, // Tone 10
            0xff49100du, // Tone 12
            0xff541210u, // Tone 15
            0xff591310u, // Tone 17
            0xff601410u, // Tone 20
            0xff661612u, // Tone 22
            0xff6b1814u, // Tone 24
            0xff6e1915u, // Tone 25
            0xff8c1d18u, // Tone 30
            0xffa1261fu, // Tone 35
            0xffb3261eu, // Tone 40
            0xffdc362eu, // Tone 50
            0xffe46962u, // Tone 60
            0xffec928eu, // Tone 70
            0xfff2b8b5u, // Tone 80
            0xfff7d3d0u, // Tone 87
            0xfff9dedcu, // Tone 90
            0xfffae4e3u, // Tone 92
            0xfffbebeau, // Tone 94
            0xfffceeeeu, // Tone 95
            0xfffdf1f1u, // Tone 96
            0xfffff8f7u, // Tone 98
            0xfffffbffu, // Tone 99
            0xffffffffu, // Tone 100
    },
    // Neutral
    {
            0xff000000u, // Tone 0
            0xff0e0e0fu, // Tone 4
            0xff111113u, // Tone 5
            0xff131315u, // Tone 6
            0xff1c1b1fu, // Tone 10
            0xff201f23u, // Tone 12
            0xff262529u, // Tone 15
            0xff2a292du, // Tone 17
            0xff313033u, // Tone 20
            0xff363438u, // Tone 22
            0xff3b393du, // Tone 24
            0xff3d3b3fu, // Tone 25
            0xff48464au, // Tone 30
            0xff545156u, // Tone 35
            0xff605d62u, // Tone 40
            0xff787579u, // Tone 50
            0xff938f94u, // Tone 60
            0xffaea9b0u, // Tone 70
            0xffc9c5cau, // Tone 80
            0xffddd9ddu, // Tone 87
            0xffe6e1e5u, // Tone 90
            0xffece7ebu, // Tone 92
            0xfff1ecf1u, // Tone 94
            0xfff4eff4u, // Tone 95
            0xfff7f2f7u, // Tone 96
            0xfffdf8fdu, // Tone 98
            0xfffffbfeu, // Tone 99
            0xffffffffu, // Tone 100
    },
    // Neutral Variant
    {
            0xff000000u, // Tone 0
            0xff0d0a11u, // Tone 4
            0xff100d15u, // Tone 5
            0xff131018u, // Tone 6
            0xff1d1a22u, // Tone 10
            0xff211e26u, // Tone 12
            0xff28252du, // Tone 15
            0xff2c2931u, // Tone 17
            0xff322f37u, // Tone 20
            0xff36333bu, // Tone 22
            0xff3b3840u, // Tone 24
            0xff3d3a42u, // Tone 25
            0xff49454fu, // Tone 30
            0xff54515au, // Tone 35
            0xff605d66u, // Tone 40
            0xff79747eu, // Tone 50
            0xff938f99u, // Tone 60
            0xffaea9b4u, // Tone 70
            0xffcac4d0u, // Tone 80
            0xffded8e4u, // Tone 87
            0xffe7e0ecu, // Tone 90
            0xffede6f2u, // Tone 92
            0xfff2ebf7u, // Tone 94
            0xfff5eefau, // Tone 95
            0xfff8f1fcu, // Tone 96
            0xfffef7ffu, // Tone 98
            0xfffffbfeu, // Tone 99
            0xffffffffu, // Tone 100
    },
};

} // namespace Palette
