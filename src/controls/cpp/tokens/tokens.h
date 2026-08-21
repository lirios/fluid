// SPDX-FileCopyrightText: 2025 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QObject>
#include <QQmlEngine>

#include "appbar.h"
#include "button.h"
#include "checkbox.h"
#include "dialog.h"
#include "divider.h"
#include "easing.h"
#include "fab.h"
#include "iconbutton.h"
#include "listitem.h"
#include "menu.h"
#include "typescale.h"
#include "slider.h"
#include "switch.h"
#include "symbol.h"

namespace Fluid {

/*!
    \brief Material Design 3 design tokens.

    Provides access to Material Design 3 design tokens including
    typography, shape, spacing, elevation, and motion tokens that can be used from QML.

    \code{.qml}
    import QtQuick
    import Fluid as MD

    Rectangle {
        radius: MD.Tokens.cornerRadiusMedium

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

    // Shape tokens - Corner radius
    Q_PROPERTY(qreal cornerRadiusNone READ cornerRadiusNone CONSTANT FINAL)
    Q_PROPERTY(qreal cornerRadiusExtraSmall READ cornerRadiusExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal cornerRadiusSmall READ cornerRadiusSmall CONSTANT FINAL)
    Q_PROPERTY(qreal cornerRadiusMedium READ cornerRadiusMedium CONSTANT FINAL)
    Q_PROPERTY(qreal cornerRadiusLarge READ cornerRadiusLarge CONSTANT FINAL)
    Q_PROPERTY(qreal cornerRadiusLargeIncreased READ cornerRadiusLargeIncreased CONSTANT FINAL)
    Q_PROPERTY(qreal cornerRadiusExtraLarge READ cornerRadiusExtraLarge CONSTANT FINAL)
    Q_PROPERTY(qreal cornerRadiusFull READ cornerRadiusFull CONSTANT FINAL)

    // Typography tokens
    Q_PROPERTY(TypeScale *typescale READ typescale CONSTANT FINAL)
    Q_PROPERTY(EmphasizedTypeScale *emphasizedTypeScale READ emphasizedTypeScale CONSTANT FINAL)

    // Spacing tokens
    Q_PROPERTY(int spacingExtraSmall READ spacingExtraSmall CONSTANT FINAL)
    Q_PROPERTY(int spacingSmall READ spacingSmall CONSTANT FINAL)
    Q_PROPERTY(int spacingMedium READ spacingMedium CONSTANT FINAL)
    Q_PROPERTY(int spacingLarge READ spacingLarge CONSTANT FINAL)
    Q_PROPERTY(int spacingExtraLarge READ spacingExtraLarge CONSTANT FINAL)

    // Elevation tokens
    Q_PROPERTY(int elevationLevel0 READ elevationLevel0 CONSTANT FINAL)
    Q_PROPERTY(int elevationLevel1 READ elevationLevel1 CONSTANT FINAL)
    Q_PROPERTY(int elevationLevel2 READ elevationLevel2 CONSTANT FINAL)
    Q_PROPERTY(int elevationLevel3 READ elevationLevel3 CONSTANT FINAL)
    Q_PROPERTY(int elevationLevel4 READ elevationLevel4 CONSTANT FINAL)
    Q_PROPERTY(int elevationLevel5 READ elevationLevel5 CONSTANT FINAL)

    // Motion tokens - Duration
    Q_PROPERTY(int durationShort1 READ durationShort1 CONSTANT FINAL)
    Q_PROPERTY(int durationShort2 READ durationShort2 CONSTANT FINAL)
    Q_PROPERTY(int durationShort3 READ durationShort3 CONSTANT FINAL)
    Q_PROPERTY(int durationShort4 READ durationShort4 CONSTANT FINAL)
    Q_PROPERTY(int durationMedium1 READ durationMedium1 CONSTANT FINAL)
    Q_PROPERTY(int durationMedium2 READ durationMedium2 CONSTANT FINAL)
    Q_PROPERTY(int durationMedium3 READ durationMedium3 CONSTANT FINAL)
    Q_PROPERTY(int durationMedium4 READ durationMedium4 CONSTANT FINAL)
    Q_PROPERTY(int durationLong1 READ durationLong1 CONSTANT FINAL)
    Q_PROPERTY(int durationLong2 READ durationLong2 CONSTANT FINAL)
    Q_PROPERTY(int durationLong3 READ durationLong3 CONSTANT FINAL)
    Q_PROPERTY(int durationLong4 READ durationLong4 CONSTANT FINAL)
    Q_PROPERTY(int durationExtraLong1 READ durationExtraLong1 CONSTANT FINAL)
    Q_PROPERTY(int durationExtraLong2 READ durationExtraLong2 CONSTANT FINAL)
    Q_PROPERTY(int durationExtraLong3 READ durationExtraLong3 CONSTANT FINAL)
    Q_PROPERTY(int durationExtraLong4 READ durationExtraLong4 CONSTANT FINAL)

    // Motion tokens - Easing and Spring
    Q_PROPERTY(Fluid::Easing easing READ easing CONSTANT FINAL)
    Q_PROPERTY(Fluid::Spring spring READ spring CONSTANT FINAL)

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

    // Component tokens - Icon button
    Q_PROPERTY(Fluid::IconButton iconButton READ iconButton CONSTANT FINAL)

    // Component tokens - List item
    Q_PROPERTY(Fluid::ListItem listItem READ listItem CONSTANT FINAL)

    // Component tokens - Menu
    Q_PROPERTY(Fluid::Menu menu READ menu CONSTANT FINAL)

    // Component tokens - Slider
    Q_PROPERTY(Fluid::Slider slider READ slider CONSTANT FINAL)

    // Component tokens - Divider
    Q_PROPERTY(Fluid::Divider divider READ divider CONSTANT FINAL)

    // Component tokens - Switch
    Q_PROPERTY(Fluid::Switch switch READ switchControl CONSTANT FINAL)

    // Component tokens - Symbol
    Q_PROPERTY(Fluid::Symbol symbol READ symbol CONSTANT FINAL)

public:
    explicit Tokens(QObject *parent = nullptr);

    // Shape tokens - Corner radius
    qreal cornerRadiusNone() const;
    qreal cornerRadiusExtraSmall() const;
    qreal cornerRadiusSmall() const;
    qreal cornerRadiusMedium() const;
    qreal cornerRadiusLarge() const;
    qreal cornerRadiusLargeIncreased() const;
    qreal cornerRadiusExtraLarge() const;
    qreal cornerRadiusFull() const;

    // Typography tokens
    TypeScale *typescale() const;
    EmphasizedTypeScale *emphasizedTypeScale() const;

    // Spacing tokens
    int spacingExtraSmall() const;
    int spacingSmall() const;
    int spacingMedium() const;
    int spacingLarge() const;
    int spacingExtraLarge() const;

    // Elevation tokens
    int elevationLevel0() const;
    int elevationLevel1() const;
    int elevationLevel2() const;
    int elevationLevel3() const;
    int elevationLevel4() const;
    int elevationLevel5() const;

    // Motion tokens - Duration
    int durationShort1() const;
    int durationShort2() const;
    int durationShort3() const;
    int durationShort4() const;
    int durationMedium1() const;
    int durationMedium2() const;
    int durationMedium3() const;
    int durationMedium4() const;
    int durationLong1() const;
    int durationLong2() const;
    int durationLong3() const;
    int durationLong4() const;
    int durationExtraLong1() const;
    int durationExtraLong2() const;
    int durationExtraLong3() const;
    int durationExtraLong4() const;

    // Motion tokens - Easing and Spring
    Easing easing() const;
    Spring spring() const;

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

    // Component tokens - Icon button
    IconButton iconButton() const;

    // Component tokens - List item
    ListItem listItem() const;

    // Component tokens - Menu
    Menu menu() const;

    // Component tokens - Slider
    Slider slider() const;

    // Component tokens - Divider
    Divider divider() const;

    // Component tokens - Switch
    Switch switchControl() const;

    // Component tokens - Symbol
    Symbol symbol() const;

    static Tokens *create(QQmlEngine *engine, QJSEngine *jsEngine);

private:
    TypeScale *m_typescale = nullptr;
    EmphasizedTypeScale *m_emphasizedTypeScale = nullptr;
    Easing m_easing;
    Spring m_spring;
    AppBar m_appBar;
    Button m_button;
    CheckBox m_checkBox;
    Dialog m_dialog;
    Fab m_fab;
    IconButton m_iconButton;
    ListItem m_listItem;
    Menu m_menu;
    Slider m_slider;
    Divider m_divider;
    Switch m_switch;
    Symbol m_symbol;
};

} // namespace Fluid
