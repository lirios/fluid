import qbs 1.0

QtGuiApplication {
    name: "Demo"
    targetName: "fluid-demo"

    readonly property stringList qmlImportPaths: [project.buildDirectory + "/install-root/qml/"]

    Depends { name: "cpp" }
    Depends { name: "Qt"; submodules: ["gui", "qml", "quick", "quickcontrols2"]; versionAtLeast: "5.8" }

    cpp.cxxLanguageVersion: "c++11"
    cpp.visibility: "minimal"
    cpp.defines: [
        "FLUID_VERSION=" + project.version,
        "QT_NO_CAST_FROM_ASCII",
        "QT_NO_CAST_TO_ASCII"
    ]

    files: [
        "main.cpp",
        "demo.qrc"
    ]

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
        qbs.installDir: "bin"
        fileTagsFilter: product.type
    }
}
