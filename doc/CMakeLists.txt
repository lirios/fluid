if(DOXYGEN_FOUND)
    # Set the output directory for Doxygen documentation
    set(DOXYGEN_OUTPUT_DIR ${CMAKE_CURRENT_BINARY_DIR}/output)

    # Configure Doxyfile
    configure_file(
        ${CMAKE_CURRENT_SOURCE_DIR}/Doxyfile.in
        ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile
        @ONLY
    )

    # Doxygen custom targets
    add_custom_target(doc_doxygen ALL
        COMMAND ${CMAKE_COMMAND} -E make_directory ${DOXYGEN_OUTPUT_DIR}
        COMMAND ${DOXYGEN_EXECUTABLE} ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        COMMENT "Generating Doxygen documentation" VERBATIM
    )

    install(DIRECTORY ${DOXYGEN_OUTPUT_DIR}/
            DESTINATION ${KDE_INSTALL_DATADIR}/doc/${PROJECT_NAME})
endif()
