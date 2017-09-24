import qbs 1.0
import qbs.FileInfo

QtGuiApplication {
    readonly property stringList qmlImportPaths: [FileInfo.joinPaths(qbs.installRoot, qbs.installPrefix, lirideployment.qmlDir)]

    name: "fluid-demo"
    targetName: "fluid-demo"
    condition: project.withDemo
    consoleApplication: false

    Depends { name: "lirideployment" }
    Depends { name: "Qt"; submodules: ["gui", "qml", "quick", "quickcontrols2"]; versionAtLeast: project.minimumQtVersion }
    Depends { name: "bundle"; condition: qbs.targetOS.contains("macos"); required: false }

    cpp.defines: [
        "FLUID_VERSION=" + project.version,
        "QT_NO_CAST_FROM_ASCII",
        "QT_NO_CAST_TO_ASCII"
    ]

    files: ["*.cpp", "*.qrc"]

    Group {
        name: "QML Files"
        files: [
            "qml/*.qml",
            "qml/+material/*.qml",
            "qml/+universal/*.qml",
            "qml/Pages/Basic/*.qml",
            "qml/Pages/Compound/*.qml",
            "qml/Pages/Style/*.qml",
            "qml/Pages/Layouts/*.qml",
            "qml/Pages/Material/*.qml",
            "qml/Pages/Navigation/*.qml"
        ]
        fileTags: ["qml"]
    }

    Group {
        qbs.install: true
        qbs.installDir: bundle.isBundle ? "Applications" : lirideployment.binDir
        fileTagsFilter: bundle.isBundle ? ["bundle.content"] : ["application"]
    }
}
