cmake_minimum_required(VERSION 3.25)

project("Fluid"
    VERSION "1.3.0"
    DESCRIPTION "Material Design for QtQuick and Qml"
    LANGUAGES CXX C
)

## Add some paths to check for CMake modules:
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

## Enable keywords such as emit:
# TODO: Replace keywords such as emit with Q_EMIT
remove_definitions(-DQT_NO_KEYWORDS)

## Features:
include(features.cmake)

## Disable use of C++ API deprecated in Qt 5.15
add_compile_definitions(QT_DISABLE_DEPRECATED_UP_TO=0x050F00)

## Enable C++23:
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

## Position independent code:
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

## Enable Qt features:
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOMOC_PATH_PREFIX ON)

## Treat warnings as errors:
add_compile_options(-Wall -Wextra -Werror)

set(QT_QML_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/qml_modules")
list(APPEND QML_DIRS "${QT_QML_OUTPUT_DIRECTORY}")

## Set QT_INSTALL_QML on UNIX systems:
if(UNIX)
  include(GNUInstallDirs)

  if("${QT_INSTALL_QML}" STREQUAL "")
    set(QT_INSTALL_QML "${CMAKE_INSTALL_LIBDIR}/qml")
  endif()
endif()

## Set QML install directory:
set(QML_INSTALL_DIR "${QT_INSTALL_QML}" CACHE STRING "")
message("QML_INSTALL_DIR: ${QML_INSTALL_DIR}")

## QML import path:
if(NOT QML_IMPORT_PATH)
    set(QML_IMPORT_PATH ${CMAKE_SOURCE_DIR}/bin CACHE STRING "" FORCE)
endif()

## Install function for QML modules:
include(cmake/QtInstallQmlModule.cmake)

## Add subdirectories:
if(FLUID_WITH_DOCUMENTATION)
    add_subdirectory(doc)
endif()
if(FLUID_WITH_QML_MODULES)
    add_subdirectory(src/controls)
    add_subdirectory(src/controls/private)
    if(FLUID_WITH_DEMO)
        add_subdirectory(src/demo)
    endif()
    if(BUILD_TESTING)
        add_subdirectory(tests/auto)
    endif()
endif()
