project(HawaiiFramework)

cmake_minimum_required(VERSION 2.8.9)

# Find includes in corresponding build directories
set(CMAKE_INCLUDE_CURRENT_DIR ON)

# Instruct CMake to run moc automatically when needed
set(CMAKE_AUTOMOC ON)

# Set version
set(HAWAII_FRAMEWORK_VERSION_MAJOR 0)
set(HAWAII_FRAMEWORK_VERSION_MINOR 4)
set(HAWAII_FRAMEWORK_VERSION_PATCH 0)
set(HAWAII_FRAMEWORK_VERSION_STRING "${HAWAII_FRAMEWORK_VERSION_MAJOR}.${HAWAII_FRAMEWORK_VERSION_MINOR}.${HAWAII_FRAMEWORK_VERSION_PATCH}")

# ECM
find_package(ECM 0.0.11 REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake" ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR})

# Installation directories
include(KDEInstallDirs)

# Macro to print feature summary
include(FeatureSummary)

# Add custom uninstall target
configure_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake_uninstall.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake"
    IMMEDIATE @ONLY)
add_custom_target(uninstall "${CMAKE_COMMAND}" -P "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake")

# Set up packaging
set(CPACK_PACKAGE_NAME "hawaii-framework")
set(CPACK_PACKAGE_VERSION "${HAWAII_FRAMEWORK_VERSION_STRING}")
set(CPACK_GENERATOR "TGZ")
set(CPACK_SET_DESTDIR FALSE)
set(CPACK_SOURCE_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}")
set(CPACK_SOURCE_IGNORE_FILES "/build/;/.git;/.tx/;~$;${CPACK_SOURCE_IGNORE_FILES}")
include(CPack)
add_custom_target(dist COMMAND ${CMAKE_MAKE_PROGRAM} package_source)

# Build flags
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fvisibility=hidden -fvisibility-inlines-hidden -Wall -Wextra -Wno-unused-parameter -std=c++11")

# Assume release build by default
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "RelWithDebInfo" CACHE STRING "" FORCE)
endif()

# Disable debug output for release builds
if(CMAKE_BUILD_TYPE MATCHES "^[Rr]elease$")
    add_definitions(-DQT_NO_DEBUG_OUTPUT)
endif()

# Minimum version requirements
set(QT_MIN_VERSION "5.3.0")
set(KF5_MIN_VERSION "5.0.0")

# Find Qt5
find_package(Qt5 ${QT_MIN_VERSION} CONFIG REQUIRED COMPONENTS Qml Quick)

# Find KF5
find_package(KF5 ${KF5_MIN_VERSION} REQUIRED COMPONENTS Plasma)

# Subdirectories
add_subdirectory(headers)
add_subdirectory(src)

# Display featute summary
feature_summary(WHAT ALL FATAL_ON_MISSING_REQUIRED_PACKAGES)
