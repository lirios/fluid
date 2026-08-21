.pragma library

// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0
.import Fluid as MD

function buttonRadius(control) {
    const tokens = control.MD.Tokens.button;
    if (control.pressed) {
        switch (control.size) {
        case MD.Button.Size.ExtraSmall: return tokens.pressedContainerShapeExtraSmall;
        case MD.Button.Size.Small: return tokens.pressedContainerShapeSmall;
        case MD.Button.Size.Medium: return tokens.pressedContainerShapeMedium;
        case MD.Button.Size.Large: return tokens.pressedContainerShapeLarge;
        case MD.Button.Size.ExtraLarge: return tokens.pressedContainerShapeExtraLarge;
        }
    }

    const round = control.shape === MD.Button.Shape.Round;
    switch (control.size) {
    case MD.Button.Size.ExtraSmall:
        return round ? (control.checked ? tokens.selectedContainerShapeRoundExtraSmall : tokens.containerShapeRound) : (control.checked ? tokens.selectedContainerShapeSquare : tokens.containerShapeSquareExtraSmall);
    case MD.Button.Size.Small:
        return round ? (control.checked ? tokens.selectedContainerShapeRoundSmall : tokens.containerShapeRound) : (control.checked ? tokens.selectedContainerShapeSquare : tokens.containerShapeSquareSmall);
    case MD.Button.Size.Medium:
        return round ? (control.checked ? tokens.selectedContainerShapeRoundMedium : tokens.containerShapeRound) : (control.checked ? tokens.selectedContainerShapeSquare : tokens.containerShapeSquareMedium);
    case MD.Button.Size.Large:
        return round ? (control.checked ? tokens.selectedContainerShapeRoundLarge : tokens.containerShapeRound) : (control.checked ? tokens.selectedContainerShapeSquare : tokens.containerShapeSquareLarge);
    case MD.Button.Size.ExtraLarge:
        return round ? (control.checked ? tokens.selectedContainerShapeRoundExtraLarge : tokens.containerShapeRound) : (control.checked ? tokens.selectedContainerShapeSquare : tokens.containerShapeSquareExtraLarge);
    }
}

function buttonInset(control) {
    return Math.max(0, (control.MD.Tokens.button.minimumInteractiveSize - buttonHeight(control)) / 2);
}

function buttonPadding(control) {
    const tokens = control.MD.Tokens.button;
    switch (control.size) {
    case MD.Button.Size.ExtraSmall: return tokens.leadingSpaceExtraSmall;
    case MD.Button.Size.Small: return tokens.leadingSpaceSmall;
    case MD.Button.Size.Medium: return tokens.leadingSpaceMedium;
    case MD.Button.Size.Large: return tokens.leadingSpaceLarge;
    case MD.Button.Size.ExtraLarge: return tokens.leadingSpaceExtraLarge;
    }
}

function buttonSpacing(control) {
    const tokens = control.MD.Tokens.button;
    switch (control.size) {
    case MD.Button.Size.ExtraSmall: return tokens.iconLabelSpaceExtraSmall;
    case MD.Button.Size.Small: return tokens.iconLabelSpaceSmall;
    case MD.Button.Size.Medium: return tokens.iconLabelSpaceMedium;
    case MD.Button.Size.Large: return tokens.iconLabelSpaceLarge;
    case MD.Button.Size.ExtraLarge: return tokens.iconLabelSpaceExtraLarge;
    }
}

function buttonIconSize(control) {
    const tokens = control.MD.Tokens.button;
    switch (control.size) {
    case MD.Button.Size.ExtraSmall: return tokens.iconSizeExtraSmall;
    case MD.Button.Size.Small: return tokens.iconSizeSmall;
    case MD.Button.Size.Medium: return tokens.iconSizeMedium;
    case MD.Button.Size.Large: return tokens.iconSizeLarge;
    case MD.Button.Size.ExtraLarge: return tokens.iconSizeExtraLarge;
    }
}

function buttonHeight(control) {
    const tokens = control.MD.Tokens.button;
    switch (control.size) {
    case MD.Button.Size.ExtraSmall: return tokens.containerHeightExtraSmall;
    case MD.Button.Size.Small: return tokens.containerHeightSmall;
    case MD.Button.Size.Medium: return tokens.containerHeightMedium;
    case MD.Button.Size.Large: return tokens.containerHeightLarge;
    case MD.Button.Size.ExtraLarge: return tokens.containerHeightExtraLarge;
    }
}

function buttonOutlineWidth(control) {
    const tokens = control.MD.Tokens.button;
    switch (control.size) {
    case MD.Button.Size.ExtraSmall: return tokens.outlinedOutlineWidthExtraSmall;
    case MD.Button.Size.Small: return tokens.outlinedOutlineWidthSmall;
    case MD.Button.Size.Medium: return tokens.outlinedOutlineWidthMedium;
    case MD.Button.Size.Large: return tokens.outlinedOutlineWidthLarge;
    case MD.Button.Size.ExtraLarge: return tokens.outlinedOutlineWidthExtraLarge;
    }
}
