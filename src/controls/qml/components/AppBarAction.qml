// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import Fluid as MD

/*!
    \class AppBarAction
    \brief Describes an action shown by an AppBar or SearchAppBar.

    AppBarAction extends \ref Action with app-bar visibility, overflow, priority,
    and presentation settings. The inherited \c text is both the accessible
    name of the action button and the label used by the overflow menu.

    For more information see the
    <a href="https://m3.material.io/components/app-bars/overview">Material Design 3 app bar guidelines</a>.
*/
MD.Action {
    /*!
        Controls whether an action may be moved to the overflow menu.

        - \c AutoOverflow: The action remains visible while space permits.
        - \c NeverOverflow: The action always remains directly visible.
        - \c AlwaysOverflow: The action is always placed in the overflow menu.
    */
    enum OverflowPolicy {
        AutoOverflow,
        NeverOverflow,
        AlwaysOverflow
    }

    /*!
        Controls how the action is presented while directly visible.

        - \c IconButton: A standard Material icon button.
        - \c FilledButton: A filled button containing an optional icon and text.
        - \c Avatar: A circular avatar loaded from \c icon.source, with
            \c icon.name used as its fallback.
    */
    enum Presentation {
        IconButton,
        FilledButton,
        Avatar
    }

    //! Whether the action participates in the app bar and overflow menu.
    property bool visible: true

    /*!
        The action's overflow priority.

        Higher-priority automatic actions are retained before lower-priority
        actions. Equal priorities preserve their original order.
    */
    property int priority: 0

    //! The policy controlling whether this action moves into overflow.
    property int overflowPolicy: AppBarAction.AutoOverflow

    //! The visual presentation used while this action is directly visible.
    property int presentation: AppBarAction.IconButton
}
