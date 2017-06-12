import qbs 1.0
import qbs.FileInfo

LiriQmlPlugin {
    name: "fluidcontrolsplugin"
    pluginPath: "Fluid/Controls"

    Depends { name: "fluidcoreplugin" }
    Depends { name: "fluidmaterialplugin" }

    cpp.defines: base.concat(['FLUID_VERSION="' + project.version + '"'])

    files: ["*.cpp", "*.h", "qmldir", "*.qml", "*.qmltypes"]

    Group {
        name: "QML Files (Material)"
        files: ["+material/*.qml"]
        fileTags: ["qml.material"]
    }

    Group {
        name: "Icons"
        files: "**/*.svg"
        prefix: qbs.installSourceBase
        qbs.install: true
        qbs.installSourceBase: "../../../icons/"
        qbs.installDir: FileInfo.joinPaths(lirideployment.qmlDir, pluginPath, "icons")
    }

    Group {
        qbs.install: true
        qbs.installDir: FileInfo.joinPaths(lirideployment.qmlDir, pluginPath, "+material")
        fileTagsFilter: ["qml.material"]
    }
}
