include(LiriQDoc)

if(Qt5Core_VERSION VERSION_GREATER_EQUAL "5.12.0")
    set(_qtquickcontrols_name "qtquickcontrols")
else()
    set(_qtquickcontrols_name "qtquickcontrols2")
endif()

liri_install_doc(
    "${CMAKE_CURRENT_SOURCE_DIR}/fluid.qdocconf"
    OUTPUT_DIRECTORY_VARIABLE
        _doc_output_dir
    ENVIRONMENT
        QTQUICKCONTROLS_NAME="${_qtquickcontrols_name}"
        FLUID_VERSION="${PROJECT_VERSION}"
        FLUID_VERSION_TAG="${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}"
        FLUID_BUILD_DIR="${CMAKE_CURRENT_BINARY_DIR}"
)
if(_doc_output_dir)
    install(DIRECTORY "${_doc_output_dir}/" DESTINATION "${INSTALL_DOCDIR}/fluid/html")
endif()
