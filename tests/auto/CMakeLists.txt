add_custom_target(check COMMAND ${CMAKE_CTEST_COMMAND} -VV)

add_subdirectory(controls)
add_subdirectory(core)
add_subdirectory(material)
