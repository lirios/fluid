include(CMakePackageConfigHelpers)
include(ECMSetupVersion)
include(ECMGenerateHeaders)

ecm_setup_version(${PROJECT_VERSION} VARIABLE_PREFIX FLUID
                  VERSION_HEADER "${CMAKE_CURRENT_BINARY_DIR}/Fluid/fluid/fluidversion.h"
                  PACKAGE_VERSION_FILE "${CMAKE_CURRENT_BINARY_DIR}/FluidConfigVersion.cmake"
                  SOVERSION ${PROJECT_SOVERSION})

set(FLUID_INCLUDEDIR "${CMAKE_INSTALL_INCLUDEDIR}/Fluid")

set(CMAKECONFIG_INSTALL_DIR "${CMAKECONFIG_INSTALL_PREFIX}/Fluid")

configure_package_config_file("${CMAKE_CURRENT_SOURCE_DIR}/FluidConfig.cmake.in"
                              "${CMAKE_CURRENT_BINARY_DIR}/FluidConfig.cmake"
                              INSTALL_DESTINATION ${CMAKECONFIG_INSTALL_DIR})

install(FILES "${CMAKE_CURRENT_BINARY_DIR}/FluidConfig.cmake"
              "${CMAKE_CURRENT_BINARY_DIR}/FluidConfigVersion.cmake"
        DESTINATION "${CMAKECONFIG_INSTALL_DIR}"
        COMPONENT Devel)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/Fluid/fluid/fluidversion.h
        DESTINATION ${FLUID_INCLUDEDIR}/fluid COMPONENT Devel)
