project(Fluid)

cmake_minimum_required(VERSION 2.8.9)

# Enable automoc and include current directory
set(CMAKE_AUTOMOC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

# Set version
set(FLUID_VERSION_MAJOR 0)
set(FLUID_VERSION_MINOR 0)
set(FLUID_VERSION_PATCH 0)
set(FLUID_VERSION_STRING "${FLUID_VERSION_MAJOR}.${FLUID_VERSION_MINOR}.${FLUID_VERSION_PATCH}")

# Installation directories
include(HawaiiInstallDirs)

# Add custom uninstall target
configure_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake_uninstall.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake"
    IMMEDIATE @ONLY)
add_custom_target(uninstall "${CMAKE_COMMAND}" -P "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake")

# Set up packaging
set(CPACK_PACKAGE_NAME hawaii-fluid)
set(CPACK_PACKAGE_VERSION ${FLUID_VERSION_STRING})
set(CPACK_SYSTEM_NAME "generic")
set(CPACK_GENERATOR "TGZ")
set(CPACK_SET_DESTDIR FALSE)
include(CPack)

# Build flags
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fvisibility=hidden -fvisibility-inlines-hidden -Wall -std=c++0x")

# Assume release build by default
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "RelWithDebInfo" CACHE STRING "" FORCE)
endif()

# Disable debug output for release builds
if(CMAKE_BUILD_TYPE MATCHES "^[Rr]elease$")
    add_definitions(-DQT_NO_DEBUG_OUTPUT)
endif()

# Find Qt
set(QT_MIN_VERSION "5.0.0")
find_package(Qt5Core REQUIRED)
if(NOT Qt5Core_FOUND)
    message(FATAL_ERROR "Qt5Core module is required!")
endif()
find_package(Qt5Xml REQUIRED)
if(NOT Qt5Xml_FOUND)
    message(FATAL_ERROR "Qt5Xml module is required!")
endif()
find_package(Qt5Gui REQUIRED)
if(NOT Qt5Gui_FOUND)
    message(FATAL_ERROR "Qt5Gui module is required!")
endif()
find_package(Qt5Qml REQUIRED)
if(NOT Qt5Qml_FOUND)
    message(FATAL_ERROR "Qt5Qml module is required!")
endif()
find_package(Qt5Quick REQUIRED)
if(NOT Qt5Quick_FOUND)
    message(FATAL_ERROR "Qt5Quick module is required!")
endif()
find_package(Qt5Svg REQUIRED)
if(NOT Qt5Svg_FOUND)
    message(FATAL_ERROR "Qt5Svg module is required!")
endif()

# Find Vibe libraries
find_package(VibeCore REQUIRED)
if(NOT VibeCore_FOUND)
    message(FATAL_ERROR "VibeCore module is required!")
endif()

# Subdirectories
add_subdirectory(data)
add_subdirectory(headers)
add_subdirectory(src)
add_subdirectory(examples)
