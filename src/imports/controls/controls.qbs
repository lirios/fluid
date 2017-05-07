import qbs 1.0

LiriDynamicLibrary {
    name: "Fluid.Controls"
    targetName: "fluidcontrolsplugin"

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
        name: "QML Files (Material)"
        files: ["+material/*.qml"]
        fileTags: ["qml.material"]
    }

    Group {
        qbs.install: true
        qbs.installDir: lirideployment.qmlDir + "/Fluid/Controls"
        fileTagsFilter: ["dynamiclibrary", "qml"]
    }

    Group {
        qbs.install: true
        qbs.installDir: lirideployment.qmlDir + "/Fluid/Controls/+material"
        fileTagsFilter: ["qml.material"]
    }
}
