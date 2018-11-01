include(LiriQDoc)

liri_install_doc(
    "${CMAKE_CURRENT_SOURCE_DIR}/fluid.qdocconf"
    OUTPUT_DIRECTORY_VARIABLE
        _doc_output_dir
    ENVIRONMENT
        FLUID_VERSION="${PROJECT_VERSION}"
        FLUID_VERSION_TAG="${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}"
        FLUID_BUILD_DIR="${CMAKE_CURRENT_BINARY_DIR}"
)
if(_doc_output_dir)
    install(DIRECTORY "${_doc_output_dir}/" DESTINATION "${INSTALL_DOCDIR}/fluid/html")
endif()
