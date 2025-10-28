function(qt_install_qml_module target_)
    get_target_property(QML_TARGET_PATH ${target_} QT_QML_MODULE_TARGET_PATH)
    get_target_property(QML_TYEPINFO ${target_} QT_QML_MODULE_TYPEINFO)
    get_target_property(QML_PLUGIN_TARGET ${target_}
                        QT_QML_MODULE_PLUGIN_TARGET)
    set(QML_TARGET_INSTALL_DIR "${QML_INSTALL_DIR}/${QML_TARGET_PATH}")

    install(TARGETS ${QML_PLUGIN_TARGET}
            LIBRARY DESTINATION ${QML_TARGET_INSTALL_DIR})

    install(
      DIRECTORY qml
      DESTINATION ${QML_TARGET_INSTALL_DIR}
      FILES_MATCHING
      PATTERN "*.qml"
      PATTERN "*.mjs")

    install(
      FILES "${QT_QML_OUTPUT_DIRECTORY}/${QML_TARGET_PATH}/qmldir"
            "${QT_QML_OUTPUT_DIRECTORY}/${QML_TARGET_PATH}/${QML_TYEPINFO}"
      DESTINATION ${QML_TARGET_INSTALL_DIR})
endfunction()
