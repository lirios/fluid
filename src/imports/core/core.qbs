import qbs 1.0

LiriDynamicLibrary {
    name: "Fluid.Core"
    targetName: "fluidcoreplugin"

    Depends { name: "lirideployment" }
    Depends { name: "cpp" }
    Depends { name: "Qt"; submodules: ["svg", "gui", "qml", "quick"] }
    Depends { name: "Fluid" }

    cpp.defines: base.concat(['FLUID_VERSION="' + project.version + '"'])

    files: ["*.cpp", "*.h"]
    excludeFiles: ["registerplugins.cpp"]

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
        qbs.installDir: lirideployment.qmlDir + "/Fluid/Core"
        fileTagsFilter: ["dynamiclibrary", "qml"]
    }
}
