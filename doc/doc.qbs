import qbs 1.0

Product {
    name: "Documentation"

    property string versionTag: project.version.replace(/\.|-/g, "")

    builtByDefault: true
    type: "qch"

    Depends { name: "Qt.core" }

    Qt.core.qdocEnvironment: [
        "FLUID_VERSION=" + project.version,
        "FLUID_VERSION_TAG=" + versionTag,
        "SRCDIR=" + path,
        "QT_INSTALL_DOCS=" + Qt.core.docPath
    ]

    files: [
        "src/**/*",
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
        qbs.installDir: "share/doc/fluid/html"
        qbs.installSourceBase: Qt.core.qdocOutputDir
    }

    Group {
        fileTagsFilter: ["qch"]
        qbs.install: false
        qbs.installDir: "share/doc/fluid/html"
    }
}
