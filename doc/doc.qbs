import qbs 1.0

Product {
    property string versionTag: project.version.replace(/\.|-/g, "")

    name: "fluid-doc"
    condition: project.withDocumentation && !qbs.targetOS.contains("android")
    builtByDefault: true
    type: "qch"

    Depends { name: "lirideployment" }
    Depends { name: "Qt.core"; versionAtLeast: project.minimumQtVersion }

    Qt.core.qdocEnvironment: [
        "FLUID_VERSION=" + project.version,
        "FLUID_VERSION_TAG=" + versionTag,
        "SRCDIR=" + path,
        "QT_INSTALL_DOCS=" + Qt.core.docPath,
        "QT_VERSION=" + Qt.core.version
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
        qbs.install: false
        qbs.installDir: qbs.targetOS.contains("linux") ? lirideployment.docDir + "/fluid/html" : "Docs"
    }
}
