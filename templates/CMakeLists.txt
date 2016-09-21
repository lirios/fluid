set(SOURCES
    tagpage.cpp
)

add_library(FluidTemplates SHARED ${SOURCES})
add_library(Fluid::Templates ALIAS FluidTemplates)
target_link_libraries(FluidTemplates Qt5::Gui Qt5::QuickControls2)

install(TARGETS FluidTemplates LIBRARY
        DESTINATION ${QML_INSTALL_DIR}/Fluid/Core)
install(FILES ${FILES}
        DESTINATION ${QML_INSTALL_DIR}/Fluid/Core)
