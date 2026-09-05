// SPDX-FileCopyrightText: 2025 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#include "tokens.h"

namespace Fluid {

Tokens::Tokens(QObject *parent)
    : QObject(parent)
    , m_typescale(new TypeScale(this))
    , m_emphasizedTypeScale(new EmphasizedTypeScale(this))
{
}

ShapeTokens Tokens::shape() const
{
    return m_shape;
}

ElevationTokens Tokens::elevation() const
{
    return m_elevation;
}

StateTokens Tokens::state() const
{
    return m_state;
}

MotionTokens Tokens::motion() const
{
    return m_motion;
}

MeasurementTokens Tokens::measurement() const
{
    return m_measurement;
}

PaletteTokens Tokens::palette() const
{
    return m_palette;
}

ColorLightTokens Tokens::light() const
{
    return m_light;
}

ColorDarkTokens Tokens::dark() const
{
    return m_dark;
}

// Typography tokens
TypeScale *Tokens::typescale() const
{
    return m_typescale;
}

EmphasizedTypeScale *Tokens::emphasizedTypeScale() const
{
    return m_emphasizedTypeScale;
}

// Component tokens - App bar
AppBar Tokens::appBar() const
{
    return m_appBar;
}

// Component tokens - Button
Button Tokens::button() const
{
    return m_button;
}

ButtonGroup Tokens::buttonGroup() const
{
    return m_buttonGroup;
}

// Component tokens - Check box
CheckBox Tokens::checkBox() const
{
    return m_checkBox;
}

// Component tokens - Radio button
RadioButton Tokens::radioButton() const
{
    return m_radioButton;
}

// Component tokens - Segmented button
SegmentedButton Tokens::segmentedButton() const
{
    return m_segmentedButton;
}

// Component tokens - Dialog
Dialog Tokens::dialog() const
{
    return m_dialog;
}

// Component tokens - Floating action button
Fab Tokens::fab() const
{
    return m_fab;
}

// Component tokens - FAB menu
FabMenu Tokens::fabMenu() const
{
    return m_fabMenu;
}

// Component tokens - Icon button
IconButton Tokens::iconButton() const
{
    return m_iconButton;
}

// Component tokens - List item
ListItem Tokens::listItem() const
{
    return m_listItem;
}

// Component tokens - Menu
Menu Tokens::menu() const
{
    return m_menu;
}

// Component tokens - Navigation rail
NavigationRail Tokens::navigationRail() const
{
    return m_navigationRail;
}

// Component tokens - Exposed dropdown menu
ExposedDropdownMenu Tokens::exposedDropdownMenu() const
{
    return m_exposedDropdownMenu;
}

// Component tokens - Slider
Slider Tokens::slider() const
{
    return m_slider;
}

// Component tokens - Divider
Divider Tokens::divider() const
{
    return m_divider;
}

// Component tokens - Switch
Switch Tokens::switchControl() const
{
    return m_switch;
}

// Component tokens - Symbol
Symbol Tokens::symbol() const
{
    return m_symbol;
}

// Component tokens - Text field
TextField Tokens::textField() const
{
    return m_textField;
}

// Component tokens - Tool tip
ToolTip Tokens::toolTip() const
{
    return m_toolTip;
}

Tokens *Tokens::create(QQmlEngine *engine, QJSEngine *jsEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(jsEngine)

    return new Tokens();
}

} // namespace Fluid
