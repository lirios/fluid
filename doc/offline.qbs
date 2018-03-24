import qbs 1.0

Product {
    name: "fluid-offline-doc"
    builtByDefault: true
    type: "qch"

    Depends { name: "lirideployment" }
    Depends { name: "Qt.core"; versionAtLeast: project.minimumQtVersion }

    Qt.core.qdocEnvironment: project.qdocEnvironment.concat([
        "SRCDIR=" + path,
        "QT_INSTALL_DOCS=" + Qt.core.docPath,
        "QT_VERSION=" + Qt.core.version
    ])

    files: [
        "config/*.qdocconf",
        "src/*.qdoc",
    ]

    Group {
        name: "Offline qdocconf file"
        files: "fluid.qdocconf"
        fileTags: "qdocconf-main"
    }

    Group {
        name: "Style"
        prefix: "template/style/"
        files: "**"
    }

    Group {
        fileTagsFilter: ["qdoc-output"]
        qbs.install: true
        qbs.installDir: qbs.targetOS.contains("linux") ? lirideployment.docDir + "/fluid/html" : "Docs"
        qbs.installSourceBase: Qt.core.qdocOutputDir
    }

    Group {
        fileTagsFilter: ["qch"]
        qbs.install: true
        qbs.installDir: qbs.targetOS.contains("linux") ? lirideployment.docDir + "/fluid" : "Docs"
    }
}
