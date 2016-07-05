project(Fluid)

cmake_minimum_required(VERSION 2.8.12)

# Set version
set(PROJECT_VERSION "0.7.90")
set(PROJECT_VERSION_MAJOR 0)
set(PROJECT_SOVERSION 0)

# Set up packaging
set(CPACK_PACKAGE_NAME "fluid")
set(CPACK_PACKAGE_VERSION "${PROJECT_VERSION}")
set(CPACK_GENERATOR "TGZ")
set(CPACK_SET_DESTDIR FALSE)
set(CPACK_SOURCE_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}")
set(CPACK_SOURCE_IGNORE_FILES "/build/;/.git;/.tx/;~$;${CPACK_SOURCE_IGNORE_FILES}")
include(CPack)
add_custom_target(dist COMMAND ${CMAKE_MAKE_PROGRAM} package_source)

# ECM
find_package(ECM 1.4.0 REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake" ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR})

# Macros
include(FeatureSummary)
include(KDEInstallDirs)
include(KDECompilerSettings)
include(KDECMakeSettings)

# Build flags
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fvisibility=hidden -fvisibility-inlines-hidden -Wall -Wextra -Wno-unused-parameter -std=c++11")

# Add custom uninstall target
if ("${ECM_VERSION}" VERSION_LESS "1.7.0")
    # ECM 1.7.0 provides this target, so we can't roll our own (see issue #172)
    configure_file(
        "${CMAKE_CURRENT_SOURCE_DIR}/cmake_uninstall.cmake.in"
        "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake"
        IMMEDIATE @ONLY)
    add_custom_target(uninstall "${CMAKE_COMMAND}" -P "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake")
endif()

# Assume release build by default
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "RelWithDebInfo" CACHE STRING "" FORCE)
endif()

# Find Qt5
set(REQUIRED_QT_VERSION 5.6.0)
find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED COMPONENTS Gui Qml Quick QuickTest)

# Subdirectories
add_subdirectory(controls)
add_subdirectory(core)
add_subdirectory(effects)
add_subdirectory(tests)
add_subdirectory(ui)

# Display featute summary
feature_summary(WHAT ALL FATAL_ON_MISSING_REQUIRED_PACKAGES)
