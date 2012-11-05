# Install QML and JavaScript code
file(GLOB MODULE_FILES "*.qml")
file(GLOB JAVASCRIPT_FILES "*.js")
install(FILES ${MODULE_FILES} ${JAVASCRIPT_FILES}
    DESTINATION ${CMAKE_INSTALL_IMPORTSDIR}/FluidUi)

# Install images
file(GLOB IMAGES_FILES "images/*")
install(FILES ${IMAGES_FILES}
     DESTINATION ${CMAKE_INSTALL_IMPORTSDIR}/FluidUi/images)

# Install private code
file(GLOB PRIVATE_FILES "private/*")
install(FILES ${PRIVATE_FILES}
     DESTINATION ${CMAKE_INSTALL_IMPORTSDIR}/FluidUi/private)
