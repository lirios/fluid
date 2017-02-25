import qbs 1.0

DynamicLibrary {
    name: "Fluid.Layouts"
    targetName: "fluidlayouts"

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
            "layoutsplugin.cpp"
        ]
        fileTags: ["cpp"]
        overrideTags: false
    }

    Group {
        name: "Headers"
        files: [
            "layoutsplugin.h"
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
        qbs.installDir: "qml/Fluid/Layouts"
        fileTagsFilter: ["dynamiclibrary"]
    }

    Group {
        qbs.install: true
        qbs.installDir: "qml/Fluid/Layouts"
        fileTagsFilter: ["qml"]
    }
}
