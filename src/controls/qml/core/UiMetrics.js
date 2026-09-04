.pragma library

// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0
.import Fluid as MD

/*!
    \file UiMetrics.js
    \brief Provides shared geometry helpers for Fluid controls.

    These helpers consume Material 3 component tokens and derive control metrics;
    UiMetrics.js is an internal library utility, not a standalone M3 component.
*/

function resolveShapeRadius(shape, width, height) {
    if (width <= 0 || height <= 0)
        return 0;

    if (shape !== MD.Tokens.shape.cornerValueFull)
        return shape;

    return Math.min(width, height) / 2;
}

function fabContainerWidth(control) {
    const tokens = control.MD.Tokens.fab;
    switch (control.size) {
    case MD.FAB.Size.Default: return tokens.containerWidth;
    case MD.FAB.Size.Medium: return tokens.mediumContainerWidth;
    case MD.FAB.Size.Large: return tokens.largeContainerWidth;
    }
}

function fabContainerHeight(control) {
    const tokens = control.MD.Tokens.fab;
    switch (control.size) {
    case MD.FAB.Size.Default: return tokens.containerHeight;
    case MD.FAB.Size.Medium: return tokens.mediumContainerHeight;
    case MD.FAB.Size.Large: return tokens.largeContainerHeight;
    }
}

function fabContainerShape(control) {
    const tokens = control.MD.Tokens.fab;
    switch (control.size) {
    case MD.FAB.Size.Default: return tokens.containerShape;
    case MD.FAB.Size.Medium: return tokens.mediumContainerShape;
    case MD.FAB.Size.Large: return tokens.largeContainerShape;
    }
}

function fabIconSize(control) {
    const tokens = control.MD.Tokens.fab;
    switch (control.size) {
    case MD.FAB.Size.Default: return tokens.iconSize;
    case MD.FAB.Size.Medium: return tokens.mediumIconSize;
    case MD.FAB.Size.Large: return tokens.largeIconSize;
    }
}

function fabLeadingSpace(control) {
    const tokens = control.MD.Tokens.fab;
    switch (control.size) {
    case MD.FAB.Size.Default: return tokens.leadingSpace;
    case MD.FAB.Size.Medium: return tokens.mediumLeadingSpace;
    case MD.FAB.Size.Large: return tokens.largeLeadingSpace;
    }
}

function fabTrailingSpace(control) {
    const tokens = control.MD.Tokens.fab;
    switch (control.size) {
    case MD.FAB.Size.Default: return tokens.trailingSpace;
    case MD.FAB.Size.Medium: return tokens.mediumTrailingSpace;
    case MD.FAB.Size.Large: return tokens.largeTrailingSpace;
    }
}

function fabSpacing(control) {
    const tokens = control.MD.Tokens.fab;
    switch (control.size) {
    case MD.FAB.Size.Default: return tokens.iconLabelSpace;
    case MD.FAB.Size.Medium: return tokens.mediumIconLabelSpace;
    case MD.FAB.Size.Large: return tokens.largeIconLabelSpace;
    }
}

function fabTypescale(control) {
    const tokens = control.MD.Tokens.typescale;
    switch (control.size) {
    case MD.FAB.Size.Default: return tokens.titleMedium;
    case MD.FAB.Size.Medium: return tokens.titleLarge;
    case MD.FAB.Size.Large: return tokens.headlineSmall;
    }
}

function buttonShape(control) {
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
        return round ? (control.checked ? tokens.selectedContainerShapeRoundExtraSmall : tokens.containerShapeRound) : (control.checked ? tokens.selectedContainerShapeSquareExtraSmall : tokens.containerShapeSquareExtraSmall);
    case MD.Button.Size.Small:
        return round ? (control.checked ? tokens.selectedContainerShapeRoundSmall : tokens.containerShapeRound) : (control.checked ? tokens.selectedContainerShapeSquareSmall : tokens.containerShapeSquareSmall);
    case MD.Button.Size.Medium:
        return round ? (control.checked ? tokens.selectedContainerShapeRoundMedium : tokens.containerShapeRound) : (control.checked ? tokens.selectedContainerShapeSquareMedium : tokens.containerShapeSquareMedium);
    case MD.Button.Size.Large:
        return round ? (control.checked ? tokens.selectedContainerShapeRoundLarge : tokens.containerShapeRound) : (control.checked ? tokens.selectedContainerShapeSquareLarge : tokens.containerShapeSquareLarge);
    case MD.Button.Size.ExtraLarge:
        return round ? (control.checked ? tokens.selectedContainerShapeRoundExtraLarge : tokens.containerShapeRound) : (control.checked ? tokens.selectedContainerShapeSquareExtraLarge : tokens.containerShapeSquareExtraLarge);
    }
}

function buttonTypescale(control) {
    const tokens = control.MD.Tokens.typescale;
    switch (control.size) {
    case MD.Button.Size.ExtraSmall:
    case MD.Button.Size.Small: return tokens.labelLarge;
    case MD.Button.Size.Medium: return tokens.titleMedium;
    case MD.Button.Size.Large: return tokens.headlineSmall;
    case MD.Button.Size.ExtraLarge: return tokens.headlineLarge;
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
