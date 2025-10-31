# SPDX-FileCopyrightText: 2023 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
# SPDX-License-Identifier: BSD-3-Clause

#### Features

## Enable feature summary at the end of the configure run:
include(FeatureSummary)

# Documentation
option(FLUID_WITH_DOCUMENTATION "Build documentation" ON)
if(FLUID_WITH_DOCUMENTATION)
    find_package(Doxygen QUIET)
    if(NOT DOXYGEN_FOUND)
        message(WARNING "Doxygen not found, documentation will not be built")
        set(FLUID_WITH_DOCUMENTATION OFF)
    endif()
endif()
add_feature_info("Fluid::Documentation" FLUID_WITH_DOCUMENTATION "Build Fluid documentation")

# Demo
option(FLUID_WITH_DEMO "Build demo application" ON)
add_feature_info("Fluid::Demo" FLUID_WITH_DEMO "Build Fluid demo application")

# QML modules
option(FLUID_WITH_QML_MODULES "Build QML modules" ON)
add_feature_info("Fluid::QMLModules" FLUID_WITH_QML_MODULES "Build Fluid QML modules")

# Install Material Design icons
option(FLUID_INSTALL_ICONS "Install Material Design icons" ON)
add_feature_info("Fluid::Icons" FLUID_INSTALL_ICONS "Install Material Design icons")

## Summary:
if(NOT LIRI_SUPERBUILD)
    feature_summary(WHAT ENABLED_FEATURES DISABLED_FEATURES)
endif()

#### Dependencies

if(FLUID_WITH_QML_MODULES)
    ## Find Qt:
    find_package(Qt6 6.8
        REQUIRED
        COMPONENTS
            Core
            Gui
            GuiPrivate
            Svg
            Qml
            Quick
            QuickControls2
            QuickTest
    )
    
    ## Standard project setup:
    qt_standard_project_setup(REQUIRES 6.8)

    ## Qt policies:
    if(QT_KNOWN_POLICY_QTP0004)
        qt_policy(SET QTP0004 NEW)
    endif()
endif()