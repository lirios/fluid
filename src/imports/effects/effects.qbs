import qbs 1.0
import qbs.FileInfo

Product {
    property string pluginPath: "Fluid/Effects"

    name: "fluideffectsplugin"

    Depends { name: "lirideployment" }

    files: ["qmldir", "*.qml", "*.qmltypes"]

    FileTagger {
        patterns: ["qmldir", "*.qml", "*.qmltypes"]
        fileTags: ["qml"]
    }

    Group {
        qbs.install: true
        qbs.installDir: FileInfo.joinPaths(lirideployment.qmlDir, pluginPath)
        fileTagsFilter: ["qml"]
    }
}
