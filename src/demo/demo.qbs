import qbs 1.0
import qbs.FileInfo

Project {
    name: "Demo"

    QtGuiApplication {
        Depends { name: "bundle" }
        readonly property bool isBundle: qbs.targetOS.contains("darwin") && bundle.isBundle
        readonly property stringList qmlImportPaths: [FileInfo.joinPaths(qbs.installRoot, qbs.installPrefix, lirideployment.qmlDir)]

        name: "fluid-demo"
        targetName: {
            if (qbs.targetOS.contains("windows"))
                return "FluidDemo";
            return name;
        }
        condition: project.withDemo
        consoleApplication: false

        bundle.identifierPrefix: "io.liri"
        bundle.identifier: "io.liri.Fluid.Demo"
        bundle.infoPlist: ({"CFBundleName": "Fluid Demo"})

        Depends { name: "lirideployment" }
        Depends { name: "Qt"; submodules: ["gui", "qml", "quick", "quickcontrols2"]; versionAtLeast: project.minimumQtVersion }
        Depends { name: "ib"; condition: qbs.targetOS.contains("macos") }

        Properties {
            condition: qbs.targetOS.contains("osx")
            cpp.linkerFlags: ["-lstdc++"]
        }

        cpp.defines: [
            "FLUID_VERSION=" + project.version,
            "QT_NO_CAST_FROM_ASCII",
            "QT_NO_CAST_TO_ASCII"
        ]

        Qt.core.resourcePrefix: "/"
        Qt.core.resourceSourceBase: sourceDirectory

        files: [
            "iconcategorymodel.cpp",
            "iconcategorymodel.h",
            "iconnamemodel.cpp",
            "iconnamemodel.h",
            "main.cpp",
        ]

        Group {
            name: "Resource Data"
            files: [
                "images/balloon.jpg",
                "images/materialbg.png",
                "qml/Pages/Controls/NavigationListViewPage.qml",
                "qml/icons.txt",
                "qml/main.qml",
                "qml/StyledPage.qml",
                "qml/StyledPageTwoColumns.qml",
                "qml/StyledRectangle.qml",
                "qml/Pages/Basic/BusyIndicatorPage.qml",
                "qml/Pages/Basic/ButtonPage.qml",
                "qml/Pages/Basic/CheckBoxPage.qml",
                "qml/Pages/Basic/ProgressBarPage.qml",
                "qml/Pages/Basic/RadioButtonPage.qml",
                "qml/Pages/Basic/SliderPage.qml",
                "qml/Pages/Basic/SwitchPage.qml",
                "qml/Pages/Controls/ActionButtonPage.qml",
                "qml/Pages/Controls/BottomSheetPage.qml",
                "qml/Pages/Controls/CardPage.qml",
                "qml/Pages/Controls/ChipPage.qml",
                "qml/Pages/Controls/DatePickerPage.qml",
                "qml/Pages/Controls/DateTimePickerPage.qml",
                "qml/Pages/Controls/DialogsPage.qml",
                "qml/Pages/Controls/ListItemPage.qml",
                "qml/Pages/Controls/NavDrawerPage.qml",
                "qml/Pages/Controls/OverlayPage.qml",
                "qml/Pages/Controls/PlaceholderPage.qml",
                "qml/Pages/Controls/SearchPage.qml",
                "qml/Pages/Controls/SnackBarPage.qml",
                "qml/Pages/Controls/SubPage.qml",
                "qml/Pages/Controls/TimePickerPage.qml",
                "qml/Pages/Controls/WavePage.qml",
                "qml/Pages/Layouts/AutomaticGridPage.qml",
                "qml/Pages/Layouts/ColumnFlowPage.qml",
                "qml/Pages/Style/IconsPage.qml",
                "qml/Pages/Style/PalettePage.qml",
                "qml/Pages/Style/PaletteSwatch.qml",
                "qml/Pages/Style/SystemIconsPage.qml",
                "qml/Pages/Style/TypographyPage.qml",
            ]
            fileTags: ["qt.core.resource_data"]
        }

        Group {
            name: "Android sources"
            prefix: "android/"
            files: ["**"]
        }

        Group {
            qbs.install: true
            qbs.installDir: {
                if (qbs.targetOS.contains("linux"))
                    return lirideployment.binDir;
                else
                    return "";
            }
            qbs.installSourceBase: destinationDirectory
            fileTagsFilter: isBundle ? ["bundle.content"] : product.type
        }

        Group {
            condition: qbs.targetOS.contains("unix") && !qbs.targetOS.contains("darwin")
            name: "Desktop File"
            files: ["io.liri.Fluid.Demo.desktop"]
            qbs.install: true
            qbs.installDir: lirideployment.applicationsDir
        }

        Group {
            condition: qbs.targetOS.contains("unix") && !qbs.targetOS.contains("darwin")
            name: "AppStream Metadata"
            files: ["io.liri.Fluid.Demo.appdata.xml"]
            qbs.install: true
            qbs.installDir: lirideployment.appDataDir
        }

        Group {
            condition: qbs.targetOS.contains("unix") && !qbs.targetOS.contains("darwin")
            name: "Icons"
            prefix: "icons/"
            files: ["**/*.png", "**/*.svg"]
            qbs.install: true
            qbs.installSourceBase: prefix
            qbs.installDir: lirideployment.dataDir + "/icons/hicolor"
        }
    }

    /*
    AndroidApk {
        condition: qbs.targetOS.contains("android")
        name: "io.liri.Fluid.Demo"
        packageName: name
        manifestFile: sourceDirectory + "/android/AndroidManifest.xml"
        resourcesDir: sourceDirectory + "/android/res"

        Depends {
            productTypes: ["android.nativelibrary"]
            limitToSubProject: true
        }

        Group {
            qbs.install: true
            qbs.installDir: ""
            qbs.installSourceBase: product.buildDirectory
            fileTagsFilter: product.type
        }
    }
    */
}

