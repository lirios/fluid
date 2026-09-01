// SPDX-FileCopyrightText: 2025 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QObject>
#include <QQmlEngine>

#include "appbar.h"
#include "button.h"
#include "checkbox.h"
#include "colordark.h"
#include "colorlight.h"
#include "dialog.h"
#include "divider.h"
#include "elevationtokens.h"
#include "exposeddropdownmenu.h"
#include "fab.h"
#include "fabmenu.h"
#include "iconbutton.h"
#include "listitem.h"
#include "menu.h"
#include "motiontokens.h"
#include "palette.h"
#include "shapetokens.h"
#include "typescale.h"
#include "slider.h"
#include "statetokens.h"
#include "switch.h"
#include "symbol.h"
#include "tooltip.h"

namespace Fluid {

/*!
    \brief Material Design 3 design tokens.

    Provides access to Material Design 3 system and component tokens.

    \code{.qml}
    import QtQuick
    import Fluid as MD

    Rectangle {
        topLeftRadius: MD.Tokens.shape.cornerMedium.topLeft
        topRightRadius: MD.Tokens.shape.cornerMedium.topRight
        bottomLeftRadius: MD.Tokens.shape.cornerMedium.bottomLeft
        bottomRightRadius: MD.Tokens.shape.cornerMedium.bottomRight

        Text {
            font.pixelSize: MD.Tokens.typescale.titleLarge.fontSize
        }
    }
    \endcode

    For more information see the
    <a href="https://m3.material.io/styles">Material Design 3 guidelines</a>.
*/
class Tokens : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

    // System tokens
    Q_PROPERTY(Fluid::ShapeTokens shape READ shape CONSTANT FINAL)
    Q_PROPERTY(Fluid::ElevationTokens elevation READ elevation CONSTANT FINAL)
    Q_PROPERTY(Fluid::StateTokens state READ state CONSTANT FINAL)
    Q_PROPERTY(Fluid::MotionTokens motion READ motion CONSTANT FINAL)
    Q_PROPERTY(Fluid::PaletteTokens palette READ palette CONSTANT FINAL)
    Q_PROPERTY(Fluid::ColorLightTokens light READ light CONSTANT FINAL)
    Q_PROPERTY(Fluid::ColorDarkTokens dark READ dark CONSTANT FINAL)

    // Typography tokens
    Q_PROPERTY(Fluid::TypeScale *typescale READ typescale CONSTANT FINAL)
    Q_PROPERTY(
            Fluid::EmphasizedTypeScale *emphasizedTypeScale READ emphasizedTypeScale CONSTANT FINAL)

    // Component tokens - App bar
    Q_PROPERTY(Fluid::AppBar appBar READ appBar CONSTANT FINAL)

    // Component tokens - Button
    Q_PROPERTY(Fluid::Button button READ button CONSTANT FINAL)

    // Component tokens - Check box
    Q_PROPERTY(Fluid::CheckBox checkBox READ checkBox CONSTANT FINAL)

    // Component tokens - Dialog
    Q_PROPERTY(Fluid::Dialog dialog READ dialog CONSTANT FINAL)

    // Component tokens - Floating action button
    Q_PROPERTY(Fluid::Fab fab READ fab CONSTANT FINAL)

    // Component tokens - FAB menu
    Q_PROPERTY(Fluid::FabMenu fabMenu READ fabMenu CONSTANT FINAL)

    // Component tokens - Icon button
    Q_PROPERTY(Fluid::IconButton iconButton READ iconButton CONSTANT FINAL)

    // Component tokens - List item
    Q_PROPERTY(Fluid::ListItem listItem READ listItem CONSTANT FINAL)

    // Component tokens - Menu
    Q_PROPERTY(Fluid::Menu menu READ menu CONSTANT FINAL)

    // Component tokens - Exposed dropdown menu
    Q_PROPERTY(
            Fluid::ExposedDropdownMenu exposedDropdownMenu READ exposedDropdownMenu CONSTANT FINAL)

    // Component tokens - Slider
    Q_PROPERTY(Fluid::Slider slider READ slider CONSTANT FINAL)

    // Component tokens - Divider
    Q_PROPERTY(Fluid::Divider divider READ divider CONSTANT FINAL)

    // Component tokens - Switch
    Q_PROPERTY(Fluid::Switch switch READ switchControl CONSTANT FINAL)

    // Component tokens - Symbol
    Q_PROPERTY(Fluid::Symbol symbol READ symbol CONSTANT FINAL)

    // Component tokens - Tool tip
    Q_PROPERTY(Fluid::ToolTip toolTip READ toolTip CONSTANT FINAL)

public:
    explicit Tokens(QObject *parent = nullptr);

    ShapeTokens shape() const;
    ElevationTokens elevation() const;
    StateTokens state() const;
    MotionTokens motion() const;
    PaletteTokens palette() const;
    ColorLightTokens light() const;
    ColorDarkTokens dark() const;

    // Typography tokens
    TypeScale *typescale() const;
    EmphasizedTypeScale *emphasizedTypeScale() const;

    // Component tokens - App bar
    AppBar appBar() const;

    // Component tokens - Button
    Button button() const;

    // Component tokens - Check box
    CheckBox checkBox() const;

    // Component tokens - Dialog
    Dialog dialog() const;

    // Component tokens - Floating action button
    Fab fab() const;

    // Component tokens - FAB menu
    FabMenu fabMenu() const;

    // Component tokens - Icon button
    IconButton iconButton() const;

    // Component tokens - List item
    ListItem listItem() const;

    // Component tokens - Menu
    Menu menu() const;

    // Component tokens - Exposed dropdown menu
    //! Returns the immutable exposed-dropdown-menu component token group.
    ExposedDropdownMenu exposedDropdownMenu() const;

    // Component tokens - Slider
    Slider slider() const;

    // Component tokens - Divider
    Divider divider() const;

    // Component tokens - Switch
    Switch switchControl() const;

    // Component tokens - Symbol
    Symbol symbol() const;

    // Component tokens - Tool tip
    ToolTip toolTip() const;

    static Tokens *create(QQmlEngine *engine, QJSEngine *jsEngine);

private:
    TypeScale *m_typescale = nullptr;
    EmphasizedTypeScale *m_emphasizedTypeScale = nullptr;
    ShapeTokens m_shape;
    ElevationTokens m_elevation;
    StateTokens m_state;
    MotionTokens m_motion;
    PaletteTokens m_palette;
    ColorLightTokens m_light;
    ColorDarkTokens m_dark;
    AppBar m_appBar;
    Button m_button;
    CheckBox m_checkBox;
    Dialog m_dialog;
    Fab m_fab;
    FabMenu m_fabMenu;
    IconButton m_iconButton;
    ListItem m_listItem;
    Menu m_menu;
    ExposedDropdownMenu m_exposedDropdownMenu;
    Slider m_slider;
    Divider m_divider;
    Switch m_switch;
    Symbol m_symbol;
    ToolTip m_toolTip;
};

} // namespace Fluid
