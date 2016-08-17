add_definitions(-DQT_NO_KEYWORDS)

set(SOURCES
    actionbutton.cpp
)

add_library(FluidTemplates SHARED ${SOURCES})
add_library(Fluid::Templates ALIAS FluidTemplates)

target_link_libraries(FluidTemplates
    PUBLIC
        Qt5::Quick
)

##############################################################################

ecm_setup_version(${PROJECT_VERSION} VARIABLE_PREFIX FLUIDTEMPLATES
                  VERSION_HEADER "${CMAKE_CURRENT_BINARY_DIR}/FluidTemplates/fluidtemplates/fluidtemplatesversion.h"
                  PACKAGE_VERSION_FILE "${CMAKE_CURRENT_BINARY_DIR}/FluidTemplatesConfigVersion.cmake"
                  SOVERSION ${PROJECT_SOVERSION})

set(FLUIDTEMPLATES_INCLUDEDIR "${CMAKE_INSTALL_INCLUDEDIR}/FluidTemplates")

set(CMAKECONFIG_INSTALL_DIR "${CMAKECONFIG_INSTALL_PREFIX}/FluidTemplates")

configure_package_config_file("${CMAKE_CURRENT_SOURCE_DIR}/FluidTemplatesConfig.cmake.in"
                              "${CMAKE_CURRENT_BINARY_DIR}/FluidTemplatesConfig.cmake"
                              INSTALL_DESTINATION ${CMAKECONFIG_INSTALL_DIR})

generate_export_header(FluidTemplates EXPORT_FILE_NAME ${CMAKE_CURRENT_BINARY_DIR}/FluidTemplates/fluidtemplates/fluidtemplatesexport.h)

target_include_directories(FluidTemplates INTERFACE "$<INSTALL_INTERFACE:${FLUIDTEMPLATES_INCLUDEDIR}>")

set_target_properties(FluidTemplates PROPERTIES
                      VERSION ${PROJECT_VERSION}
                      SOVERSION ${PROJECT_SOVERSION}
                      EXPORT_NAME Templates)

ecm_generate_headers(FluidTemplates_CamelCase_HEADERS
  HEADER_NAMES
    ActionButton
  PREFIX
    Templates
  REQUIRED_HEADERS
    FluidTemplates_HEADERS
  OUTPUT_DIR
    ${CMAKE_CURRENT_BINARY_DIR}/FluidTemplates/FluidTemplates
)

install(FILES "${CMAKE_CURRENT_BINARY_DIR}/FluidTemplatesConfig.cmake"
              "${CMAKE_CURRENT_BINARY_DIR}/FluidTemplatesConfigVersion.cmake"
        DESTINATION "${CMAKECONFIG_INSTALL_DIR}"
        COMPONENT Devel)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/FluidTemplates/fluidtemplates/fluidtemplatesversion.h
        DESTINATION ${FLUIDTEMPLATES_INCLUDEDIR}/fluidtemplates COMPONENT Devel)
install(FILES ${FluidTemplates_CamelCase_HEADERS}
        DESTINATION ${FLUIDTEMPLATES_INCLUDEDIR}/FluidTemplates
        COMPONENT Devel)
install(
    FILES
      ${CMAKE_CURRENT_BINARY_DIR}/FluidTemplates/fluidtemplates/fluidtemplatesexport.h
      ${FluidTemplates_HEADERS}
    DESTINATION
      ${FLUIDTEMPLATES_INCLUDEDIR}/fluidtemplates
    COMPONENT
      Devel
)
install(TARGETS FluidTemplates
        EXPORT FluidTemplateTargets ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})
install(EXPORT FluidTemplatesTargets
        DESTINATION "${CMAKECONFIG_INSTALL_DIR}"
        FILE FluidTemplatesTargets.cmake NAMESPACE Fluid::)
