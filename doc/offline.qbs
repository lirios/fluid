import qbs 1.0
import qbs.Utilities

Product {
    name: "fluid-offline-doc"
    builtByDefault: true
    type: "qch"

    Depends { name: "lirideployment" }
    Depends { name: "Qt.core"; versionAtLeast: project.minimumQtVersion }

    property string qtQuickControlName: {
        if (Utilities.versionCompare(Qt.core.version, "5.12.0") >= 0)
            return "qtquickcontrols";
        return "qtquickcontrols2";
    }
    Qt.core.qdocEnvironment: project.qdocEnvironment.concat([
        "SRCDIR=" + path,
        "QT_INSTALL_DOCS=" + Qt.core.docPath,
        "QT_VERSION=" + Qt.core.version,
        "QT_VER=" + Qt.core.version,
        "QTQUICKCONTROLS_NAME=" + qtQuickControlName
    ])

    files: [
        "config/fluid-project.qdocconf",
        "config/macros.qdocconf",
        "src/controls/Action.qdoc",
        "src/controls/AlertDialog.qdoc",
        "src/controls/AppBar.qdoc",
        "src/controls/AppToolBar.qdoc",
        "src/controls/ApplicationWindow.qdoc",
        "src/controls/BodyLabel.qdoc",
        "src/controls/BottomSheet.qdoc",
        "src/controls/BottomSheetGrid.qdoc",
        "src/controls/BottomSheetList.qodc",
        "src/controls/CaptionLabel.qdoc",
        "src/controls/Card.qdoc",
        "src/controls/Chip.qdoc",
        "src/controls/CircleImage.qdoc",
        "src/controls/DatePickerDialog.qdoc",
        "src/controls/DateTimePickerDialog.qdoc",
        "src/controls/DialogLabel.qdoc",
        "src/controls/DisplayLabel.qdoc",
        "src/controls/FloatingActionButton.qdoc",
        "src/controls/HeadlineLabel.qdoc",
        "src/controls/Icon.qdoc",
        "src/controls/InputDialog.qdoc",
        "src/controls/ListItem.qdoc",
        "src/controls/Loadable.qdoc",
        "src/controls/NavigationDrawer.qdoc",
        "src/controls/NavigationListView.qdoc",
        "src/controls/NoiseBackground.qdoc",
        "src/controls/OverlayView.qdoc",
        "src/controls/Page.qdoc",
        "src/controls/PageSidebar.qdoc",
        "src/controls/PageStack.qdoc",
        "src/controls/Placeholder.qdoc",
        "src/controls/Ripple.qdoc",
        "src/controls/SearchBar.qdoc",
        "src/controls/Showable.qdoc",
        "src/controls/Sidebar.qdoc",
        "src/controls/SmoothFadeImage.qdoc",
        "src/controls/SmoothFadeLoader.qdoc",
        "src/controls/SnackBar.qdoc",
        "src/controls/Subheader.qdoc",
        "src/controls/SubheadingLabel.qdoc",
        "src/controls/Tab.qdoc",
        "src/controls/TabbedPage.qdoc",
        "src/controls/ThinDivider.qdoc",
        "src/controls/TimePickerDialog.qdoc",
        "src/controls/TitleLabel.qdoc",
        "src/controls/ToolButton.qdoc",
        "src/controls/Units.qdoc",
        "src/controls/Wave.qdoc",
        "src/deployment.qdoc",
        "src/fluidcontrols-qmltypes.qdoc",
        "src/fluidcore-qmltypes.qdoc",
        "src/fluideffects-qmltypes.qdoc",
        "src/fluidlayouts-qmltypes.qdoc",
        "src/fluidtemplates-qmltypes.qdoc",
        "src/index.qdoc",
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
