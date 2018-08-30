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
        "config/fluid-project.qdocconf",
        "config/macros.qdocconf",
        "src/deployment.qdoc",
        "src/fluidcontrols-qmltypes.qdoc",
        "src/fluidcore-qmltypes.qdoc",
        "src/fluideffects-qmltypes.qdoc",
        "src/fluidlayouts-qmltypes.qdoc",
        "src/fluidtemplates-qmltypes.qdoc",
        "src/index.qdoc",
        "src/controls/AppBar.qdoc",
        "src/controls/ApplicationWindow.qdoc",
        "src/controls/AppToolBar.qdoc",
        "src/controls/Chip.qdoc",
        "src/controls/Page.qdoc",
        "src/controls/PageSidebar.qdoc",
        "src/controls/SearchBar.qdoc",
    ]

    Group {
        name: "Offline qdocconf file"
        files: "fluid.qdocconf"
        fileTags: "qdocconf-main"
    }

    Group {
        name: "Style"
        prefix: "template/style/"
        files: [
            "base.css",
            "liri.css",
            "liri.eot",
            "liri.svg",
            "liri.ttf",
            "liri.woff",
        ]
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
