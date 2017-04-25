project(Fluid)

cmake_minimum_required(VERSION 3.0.0 FATAL_ERROR)
cmake_policy(VERSION 3.4.1)

# Instruct CMake to run moc and rrc automatically when needed
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

# Apple-specific configuration
set(APPLE_SUPPRESS_X11_WARNING ON)

# Set version
set(PROJECT_VERSION "0.10.0")
set(PROJECT_VERSION_MAJOR 0)
set(PROJECT_SOVERSION 0)

# Set up packaging
if(NOT USE_SUPERBUILD)
    set(CPACK_PACKAGE_NAME "fluid")
    set(CPACK_PACKAGE_VERSION "${PROJECT_VERSION}")
    set(CPACK_GENERATOR "TGZ")
    set(CPACK_SET_DESTDIR FALSE)
    set(CPACK_SOURCE_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}")
    set(CPACK_SOURCE_IGNORE_FILES "/build/;/.git;/.tx/;~$;${CPACK_SOURCE_IGNORE_FILES}")
    include(CPack)
    add_custom_target(dist COMMAND ${CMAKE_MAKE_PROGRAM} package_source)
endif()

# ECM
find_package(ECM 1.7.0 REQUIRED NO_MODULE)
list(APPEND CMAKE_MODULE_PATH
    "${ECM_MODULE_PATH}"
    "${ECM_KDE_MODULE_DIR}"
)

# Macros
include(FeatureSummary)
include(KDEInstallDirs)
include(KDECompilerSettings)
include(KDECMakeSettings)

# Build flags
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fvisibility=hidden -fvisibility-inlines-hidden -Werror -Wall -Wextra -Wformat -Wswitch-default -Wunused-parameter -pedantic -std=c++11")

# Assume release build by default
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "RelWithDebInfo" CACHE STRING "" FORCE)
endif()

# Find Qt5
set(REQUIRED_QT_VERSION "5.8.0")
find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED COMPONENTS
             Svg Gui Qml Quick QuickTest QuickControls2)

# Find QT_INSTALL_DOCS
get_target_property(QMAKE_EXECUTABLE Qt5::qmake LOCATION)
if(NOT QT_INSTALL_DOCS)
    exec_program(${QMAKE_EXECUTABLE} ARGS "-query QT_INSTALL_DOCS" RETURN_VALUE return_code OUTPUT_VARIABLE QT_INSTALL_DOCS)
endif()
if(NOT QT_HOST_DATA)
    exec_program(${QMAKE_EXECUTABLE} ARGS "-query QT_HOST_DATA" RETURN_VALUE return_code OUTPUT_VARIABLE QT_HOST_DATA)
endif()

# Documentation target
find_program(QDOC_EXECUTABLE qdoc-qt5 qdoc)
add_custom_target(docs
                  COMMAND QT_INSTALL_DOCS=${QT_INSTALL_DOCS} QT_VERSION_TAG=5.7 FLUID_VERSION=${PROJECT_VERSION} FLUID_VERSION_TAG=1.0 FLUID_BUILD_DIR=${CMAKE_CURRENT_BINARY_DIR} ${QDOC_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/doc/fluid.qdocconf)

# Subdirectories
add_subdirectory(src)
add_subdirectory(tests)

# Install icons
if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/icons")
    install(DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/icons"
            DESTINATION ${QML_INSTALL_DIR}/Fluid/Controls
            PATTERN "icons/icons.qrc" EXCLUDE)
endif()

# Install qmake features
# We do not install features anymore, just rely on submodules
# to avoid a Fluid dependency on modules where it doesn't make sense
#set(features_SOURCES
#    features/liri_create_cmake.prf
#    features/liri_deployment.prf
#    features/liri_qml_module.prf
#    features/liri_qml_plugin.prf
#    features/liri_qt_app.prf
#    features/liri_qt_module.prf
#    features/liri_qt_module_pris.prf
#    features/liri_qt_plugin.prf
#)
#install(FILES ${features_SOURCES} DESTINATION ${QT_HOST_DATA}/mkspecs/features)
#set(features_cmake_SOURCES
#    features/data/cmake/liri_ExtraSourceIncludes.cmake.in
#    features/data/cmake/liri_Qt5BasicConfig.cmake.in
#    features/data/cmake/liri_Qt5ConfigVersion.cmake.in
#    features/data/cmake/liri_Qt5PluginTarget.cmake.in
#)
#install(FILES ${features_cmake_SOURCES} DESTINATION ${QT_HOST_DATA}/mkspecs/features/data/cmake)

# Display feature summary
feature_summary(WHAT ALL FATAL_ON_MISSING_REQUIRED_PACKAGES)
