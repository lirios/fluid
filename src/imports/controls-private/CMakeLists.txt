if(LINUX AND NOT ANDROID)
    set(SOURCES
        extensions/liridecoration.cpp
        extensions/liridecoration.h
    )

    find_package(QtWaylandScanner REQUIRED)
    find_package(Qt5WaylandClient REQUIRED)
    ecm_add_qtwayland_client_protocol(SOURCES
        PROTOCOL "${CMAKE_CURRENT_SOURCE_DIR}/extensions/liri-decoration.xml"
        BASENAME "liri-decoration")
    set(DEFINES FLUID_ENABLE_WAYLAND=1)
    set(LIBRARIES Qt5::GuiPrivate Qt5::WaylandClient)
endif()

liri_add_qml_plugin(fluidcontrolsprivate
    MODULE_PATH
        "Fluid/Controls/Private"
    SOURCES
        controlsprivateplugin.cpp
        windowdecoration.cpp
        windowdecoration.h
        ${SOURCES}
    QML_FILES
        DateSelector.qml
        TimeSelector.qml
        YearSelector.qml
        qmldir
        plugins.qmltypes
    DEFINES
        QT_NO_CAST_FROM_ASCII
        QT_NO_FOREACH
        ${DEFINES}
    PUBLIC_LIBRARIES
        Qt5::QuickControls2
        ${LIBRARIES}
)
