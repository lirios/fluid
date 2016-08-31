if(NOT USE_SUPERBUILD)
    add_custom_target(check COMMAND ${CMAKE_CTEST_COMMAND} -VV)
endif()

add_subdirectory(controls)
add_subdirectory(core)
add_subdirectory(material)
