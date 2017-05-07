import qbs 1.0

LiriDynamicLibrary {
    name: "Fluid.Layouts"
    targetName: "fluidlayoutsplugin"

    Depends { name: "lirideployment" }
    Depends { name: "cpp" }
    Depends { name: "Qt"; submodules: ["gui", "qml", "quick"] }

    cpp.defines: base.concat(['FLUID_VERSION="' + project.version + '"'])

    files: ["*.cpp", "*.h"]

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
        qbs.installDir: lirideployment.qmlDir + "/Fluid/Layouts"
        fileTagsFilter: ["dynamiclibrary", "qml"]
    }
}
