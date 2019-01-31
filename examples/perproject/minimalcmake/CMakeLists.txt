cmake_minimum_required(VERSION 3.10.0)

project("MinimalCMake"
    VERSION "1.0.0"
    DESCRIPTION "Sample project using Fluid with CMake"
    LANGUAGES CXX C
)

## Shared macros and functions:
set(LIRI_LOCAL_ECM TRUE)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/fluid/cmake/shared/modules")

## Configure Fluid:
option(FLUID_WITH_DOCUMENTATION "" OFF)
option(FLUID_WITH_DEMO "" OFF)

## Set minimum versions required:
set(QT_MIN_VERSION "5.10.0")

## Liri specific setup common for all modules:
include(LiriSetup)

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
)

## Add subdirectories:
add_subdirectory(fluid)
add_subdirectory(src)
