# SPDX-FileCopyrightText: 2023 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
# SPDX-License-Identifier: BSD-3-Clause

## Enable feature summary at the end of the configure run:
include(FeatureSummary)

## Find Qt:
find_package(Qt6
    REQUIRED
    COMPONENTS
        Core
        Gui
        Svg
        Qml
        Quick
        QuickControls2
        QuickTest
)

#### Features

option(FLUID_WITH_DOCUMENTATION "Build documentation" ON)
add_feature_info("Fluid::Documentation" FLUID_WITH_DOCUMENTATION "Build Fluid documentation")
option(FLUID_WITH_DEMO "Build demo application" ON)
add_feature_info("Fluid::Demo" FLUID_WITH_DEMO "Build Fluid demo application")
option(FLUID_WITH_QML_MODULES "Build QML modules" ON)
add_feature_info("Fluid::QMLModules" FLUID_WITH_QML_MODULES "Build Fluid QML modules")
option(FLUID_INSTALL_ICONS "Install Material Design icons" ON)
add_feature_info("Fluid::Icons" FLUID_INSTALL_ICONS "Install Material Design icons")

## Features summary:
if(NOT LIRI_SUPERBUILD)
    feature_summary(WHAT ENABLED_FEATURES DISABLED_FEATURES)
endif()
