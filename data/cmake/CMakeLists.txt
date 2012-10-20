include(CMakePackageConfigHelpers)

#produce_cmake_script("Fluid" "Qt5Gui;Qt5Svg;VibeCore")
set(INSTALL_CMAKEDIR ${CMAKE_INSTALL_LIBDIR}/cmake/Fluid)

configure_package_config_file(FluidConfig.cmake.in ${CMAKE_CURRENT_BINARY_DIR}/FluidConfig.cmake
                              INSTALL_DESTINATION ${INSTALL_CMAKEDIR}
                              PATH_VARS INSTALL_CMAKEDIR)
write_basic_package_version_file(${CMAKE_CURRENT_BINARY_DIR}/FluidConfigVersion.cmake
                                 VERSION ${Fluid_VERSION_STRING}
                                 COMPATIBILITY AnyNewerVersion)

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/FluidConfig.cmake
              ${CMAKE_CURRENT_BINARY_DIR}/FluidConfigVersion.cmake
        DESTINATION ${INSTALL_CMAKEDIR})
