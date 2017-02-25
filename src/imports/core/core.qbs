import qbs 1.0

DynamicLibrary {
    name: "Fluid.Core"
    targetName: "fluidcore"

    Depends { name: "cpp" }
    Depends { name: "Qt"; submodules: ["svg", "gui", "qml", "quick"] }
    Depends { name: "libFluid" }

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
            "clipboard.cpp",
            "device.cpp",
            "iconsimageprovider.cpp",
            "qmldateutils.cpp",
            "qqmlsortfilterproxymodel.cpp",
            "standardpaths.cpp",
            "coreplugin.cpp"
        ]
        fileTags: ["cpp"]
        overrideTags: false
    }

    Group {
        name: "Headers"
        files: [
            "clipboard.h",
            "device.h",
            "iconsimageprovider.h",
            "qmldateutils.h",
            "qqmlsortfilterproxymodel.h",
            "standardpaths.h",
            "coreplugin.h"
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
        qbs.installDir: "qml/Fluid/Core"
        fileTagsFilter: ["dynamiclibrary"]
    }

    Group {
        qbs.install: true
        qbs.installDir: "qml/Fluid/Core"
        fileTagsFilter: ["qml"]
    }
}
