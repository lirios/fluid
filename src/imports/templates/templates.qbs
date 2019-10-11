import qbs 1.0

LiriQmlPlugin {
    name: "fluidtemplatesplugin"
    pluginPath: "Fluid/Templates"

    Properties {
        condition: qbs.targetOS.contains("osx")
        cpp.linkerFlags: ["-lstdc++"]
    }

    cpp.defines: base.concat(['FLUID_VERSION="' + project.version + '"'])

    Group {
        name: "QML"
        files: ["qmldir", "*.qml", "*.qmltypes"]
    }

    Group {
        name: "Sources"
        files: ["*.cpp", "*.h"]
    }
}
