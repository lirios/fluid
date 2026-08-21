.pragma library

// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0
.import Fluid as MD

function buttonRadius(control) {
    // When pressed it morphs into a square shape
    if (control.pressed) {
        switch (control.size) {
            case MD.Button.Size.ExtraSmall:
            case MD.Button.Size.Small:
                return control.MD.Tokens.cornerRadiusSmall;
            case MD.Button.Size.Medium:
                return control.MD.Tokens.cornerRadiusMedium;
            case MD.Button.Size.Large:
            case MD.Button.Size.ExtraLarge:
                return control.MD.Tokens.cornerRadiusLarge;
        }
    }

    // Radius when not pressed depends on the shape and checked state of the button
    switch (control.size) {
        case MD.Button.Size.ExtraSmall:
        case MD.Button.Size.Small:
            if (control.shape === MD.Button.Shape.Round)
                return control.checked ? control.MD.Tokens.cornerRadiusMedium : control.MD.Tokens.cornerRadiusFull;
            else
                return control.checked ? control.MD.Tokens.cornerRadiusFull : control.MD.Tokens.cornerRadiusMedium;
        case MD.Button.Size.Medium:
            if (control.shape === MD.Button.Shape.Round)
                return control.checked ? control.MD.Tokens.cornerRadiusLarge : control.MD.Tokens.cornerRadiusFull;
            else
                return control.checked ? control.MD.Tokens.cornerRadiusFull : control.MD.Tokens.cornerRadiusLarge;
        case MD.Button.Size.Large:
        case MD.Button.Size.ExtraLarge:
            if (control.shape === MD.Button.Shape.Round)
                return control.checked ? control.MD.Tokens.cornerRadiusExtraLarge : control.MD.Tokens.cornerRadiusFull;
            else
                return control.checked ? control.MD.Tokens.cornerRadiusFull : control.MD.Tokens.cornerRadiusExtraLarge;
    }
}

function buttonInset(control) {
    // Extra small and small icon buttons must have a target size of 48x48 to be accessible,
    // so we calculate the necessary insets to achieve that when the implicit content size is smaller than 48x48.
    switch (control.size) {
    case MD.Button.Size.ExtraSmall:
        return 48 - 32;
    case MD.Button.Size.Small:
        return 48 - 40;
    default:
        return 0;
    }
}

function buttonPadding(control) {
    switch (control.size) {
    case MD.Button.Size.ExtraSmall:
        return 12;
    case MD.Button.Size.Small:
        return 16;
    case MD.Button.Size.Medium:
        return 24;
    case MD.Button.Size.Large:
        return 48;
    case MD.Button.Size.ExtraLarge:
        return 64;
    }
}

function buttonSpacing(control) {
    switch (control.size) {
    case MD.Button.Size.ExtraSmall:
        return 4;
    case MD.Button.Size.Small:
        return 8;
    case MD.Button.Size.Medium:
        return 8;
    case MD.Button.Size.Large:
        return 12;
    case MD.Button.Size.ExtraLarge:
        return 16;
    }
}

function buttonIconSize(control) {
    switch (control.size) {
    case MD.Button.Size.ExtraSmall:
        return 20;
    case MD.Button.Size.Small:
        return 20;
    case MD.Button.Size.Medium:
        return 24;
    case MD.Button.Size.Large:
        return 32;
    case MD.Button.Size.ExtraLarge:
        return 40;
    }
}
