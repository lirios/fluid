import qbs 1.0

DynamicLibrary {
    name: "Fluid.Controls"
    targetName: "fluidcontrols"

    Depends { name: "cpp" }
    Depends { name: "Qt"; submodules: ["gui", "qml", "quick"] }

    cpp.cxxLanguageVersion: "c++11"
    cpp.visibility: "minimal"
    cpp.defines: [
        "FLUID_VERSION=" + project.version,
        "QT_NO_CAST_FROM_ASCII",
        "QT_NO_CAST_TO_ASCII"
    ]

    Group {
        name: "Sources"
        files: [
            "iconthemeimageprovider.cpp",
            "controlsplugin.cpp"
        ]
        fileTags: ["cpp"]
        overrideTags: false
    }

    Group {
        name: "Headers"
        files: [
            "iconthemeimageprovider.h",
            "controlsplugin.h"
        ]
        fileTags: ["hpp"]
        overrideTags: false
    }

    Group {
        name: "QML Files"
        files: [
            "*.qml",
            "qmldir",
            "plugins.qmltypes"
        ]
        fileTags: ["qml"]
    }

    Group {
        qbs.install: true
        qbs.installDir: "qml/Fluid/Controls"
        fileTagsFilter: ["dynamiclibrary"]
    }

    Group {
        qbs.install: true
        qbs.installDir: "qml/Fluid/Controls"
        fileTagsFilter: ["qml"]
    }

    Group {
        qbs.install: true
        qbs.installDir: "qml/Fluid/Controls/icons"
        fileTagsFilter: ["icons"]
    }
}
