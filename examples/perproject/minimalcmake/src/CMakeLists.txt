liri_add_executable("example"
    SOURCES
        main.cpp
    RESOURCES
        qml.qrc
    LIBRARIES
        Qt5::Core
        Qt5::Gui
        Qt5::QuickControls2
)

liri_finalize_executable("example")
