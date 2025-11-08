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

# Gallery
option(FLUID_WITH_GALLERY "Build demo application" ON)
add_feature_info("Fluid::Gallery" FLUID_WITH_GALLERY "Build Fluid demo application")

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
            Core5Compat
            Gui
            Svg
            Qml
            Quick
            QuickControls2
            ShaderTools
    )

    if(NOT TARGET Qt6::GuiPrivate)
        # GuiPrivate is supposed to be automatically found when finding Gui per
        # https://doc.qt.io/qt-6/qtguiprivate-module.html#details, but on Arch
        # Linux it is packaged differently.
        find_package(Qt6 6.8 REQUIRED COMPONENTS GuiPrivate)
    endif()

    if(BUILD_TESTING)
        find_package(Qt6 6.8 OPTIONAL_COMPONENTS QuickTest)
    endif()
    
    ## Standard project setup:
    qt_standard_project_setup(REQUIRES 6.8)

    ## Qt policies:
    if(QT_KNOWN_POLICY_QTP0004)
        qt_policy(SET QTP0004 NEW)
    endif()
endif()
