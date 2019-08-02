cmake_minimum_required(VERSION 3.10.0)

project("Fluid"
    VERSION "1.2.0"
    DESCRIPTION "Material Design implementation with QtQuick Controls 2"
    LANGUAGES CXX C
)

## Shared macros and functions:
if(NOT FLUID_USE_SYSTEM_LCS AND EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/cmake/shared/CMakeLists.txt")
    set(LIRI_LOCAL_ECM TRUE)
    list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake/shared/modules")
else()
    if(NOT LIRI_LOCAL_ECM)
        find_package(LiriCMakeShared "1.0.0" REQUIRED NO_MODULE)
        list(APPEND CMAKE_MODULE_PATH "${LCS_MODULE_PATH}")
    endif()
endif()

## Set minimum versions required:
set(QT_MIN_VERSION "5.10.0")

## Liri specific setup common for all modules:
include(LiriSetup)

## Features:
option(FLUID_USE_SYSTEM_LCS "Use system-wide LiriCMakeShared" OFF)
add_feature_info("Fluid::LiriCMakeShared" FLUID_USE_SYSTEM_LCS "Use system-wide LiriCMakeShared")
option(FLUID_WITH_DOCUMENTATION "Build documentation" ON)
add_feature_info("Fluid::Documentation" FLUID_WITH_DOCUMENTATION "Build Fluid documentation")
option(FLUID_WITH_DEMO "Build demo application" ON)
add_feature_info("Fluid::Demo" FLUID_WITH_DEMO "Build Fluid demo application")
option(FLUID_WITH_QML_MODULES "Build QML modules" ON)
add_feature_info("Fluid::QMLModules" FLUID_WITH_QML_MODULES "Build Fluid QML modules")
option(FLUID_INSTALL_ICONS "Install Material Design icons" ON)
add_feature_info("Fluid::Icons" FLUID_INSTALL_ICONS "Install Material Design icons")
option(FLUID_ENABLE_QTQUICK_COMPILER "Build with QtQuick compiler (resulting binaries may not be compatible with future Qt releases without rebuilding them)" OFF)
add_feature_info("Fluid::QtQuickCompiler" FLUID_ENABLE_QTQUICK_COMPILER "Build with QtQuick compiler")

## Find Qt 5:
find_package(Qt5 "${QT_MIN_VERSION}"
    CONFIG REQUIRED
    COMPONENTS
        Core
        Gui
        Svg
        Qml
        Quick
        QuickControls2
        QuickTest
)

## Add subdirectories:
if(FLUID_WITH_DOCUMENTATION)
    add_subdirectory(doc)
endif()
if(FLUID_WITH_QML_MODULES)
    add_subdirectory(src/imports/controls)
    add_subdirectory(src/imports/controls-private)
    add_subdirectory(src/imports/core)
    add_subdirectory(src/imports/effects)
    add_subdirectory(src/imports/layouts)
    add_subdirectory(src/imports/templates)
endif()
if(FLUID_WITH_DEMO)
    add_subdirectory(src/demo)
endif()
if(BUILD_TESTING)
    if(TARGET fluidcontrolsplugin)
        add_subdirectory(tests/auto/controls)
    endif()
    if(TARGET fluidcoreplugin)
        add_subdirectory(tests/auto/core)
    endif()
endif()
