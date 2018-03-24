import qbs 1.0

Product {
    name: "fluid-online-doc"
    builtByDefault: false
    type: "qdoc-output"

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
        name: "Online qdocconf file"
        files: "fluid-online.qdocconf"
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
        qbs.installDir: qbs.targetOS.contains("linux") ? lirideployment.docDir + "/fluid/online-html" : "Docs"
        qbs.installSourceBase: Qt.core.qdocOutputDir
    }
}
