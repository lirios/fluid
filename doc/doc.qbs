import qbs 1.0

Product {
    property string versionTag: project.version.replace(/\.|-/g, "")

    name: "Documentation"
    condition: qbsbuildconfig.withDocumentation
    builtByDefault: true
    type: "qch"

    Depends { name: "qbsbuildconfig" }
    Depends { name: "lirideployment" }
    Depends { name: "Qt.core" }

    Qt.core.qdocEnvironment: [
        "FLUID_VERSION=" + project.version,
        "FLUID_VERSION_TAG=" + versionTag,
        "SRCDIR=" + path,
        "QT_INSTALL_DOCS=" + Qt.core.docPath
    ]

    files: [
        "config/*.qdocconf",
        "src/*.qdoc",
    ]

    Group {
        name: "Main qdocconf file"
        files: "fluid.qdocconf"
        fileTags: "qdocconf-main"
    }

    Group {
        name: "Online qdocconf file"
        files: "fluid-online.qdocconf"
        fileTags: "qdocconf-online"
    }

    Group {
        fileTagsFilter: ["qdoc-output"]
        qbs.install: true
        qbs.installDir: lirideployment.docDir + "/fluid/html"
        qbs.installSourceBase: Qt.core.qdocOutputDir
    }

    Group {
        fileTagsFilter: ["qch"]
        qbs.install: false
        qbs.installDir: lirideployment.docDir + "/fluid/html"
    }
}
