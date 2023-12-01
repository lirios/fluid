cmake_minimum_required(VERSION 3.19)

project("Fluid"
    VERSION "1.3.0"
    DESCRIPTION "Material Design implementation with QtQuick Controls 2"
    LANGUAGES CXX C
)

## ECM:
find_package(ECM 5.245.0 REQUIRED NO_MODULE)
list(APPEND CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

## Installation directories:
include(KDEInstallDirs)

## Compiler settings:
set(KDE_SKIP_NULLPTR_WARNINGS_SETTINGS TRUE)
include(KDECompilerSettings NO_POLICY_SCOPE)

## Enable keywords such as emit:
# TODO: Replace keywords such as emit with Q_EMIT
remove_definitions(-DQT_NO_KEYWORDS)

## CMake settings:
include(KDECMakeSettings)

## QML module:
include(ECMQmlModule)

## Features:
include(features.cmake)

## Project setup:
qt6_standard_project_setup(REQUIRES 6.6)

## Disable use of C++ API deprecated in Qt 5.15
add_compile_definitions(QT_DISABLE_DEPRECATED_UP_TO=0x050F00)

## QML import path:
if(NOT QML_IMPORT_PATH)
    set(QML_IMPORT_PATH ${CMAKE_SOURCE_DIR}/bin CACHE STRING "" FORCE)
endif()

## Add subdirectories:
if(FLUID_WITH_DOCUMENTATION)
    #add_subdirectory(doc)
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
    add_subdirectory(tests/auto)
endif()
