import qbs 1.0
import qbs.FileInfo

Project {
    name: "Demo"

    QtGuiApplication {
        readonly property bool isBundle: qbs.targetOS.contains("darwin") && bundle.isBundle
        readonly property stringList qmlImportPaths: [FileInfo.joinPaths(qbs.installRoot, qbs.installPrefix, lirideployment.qmlDir)]

        name: "fluid-demo"
        targetName: "fluid-demo"
        condition: project.withDemo
        consoleApplication: false

        Depends { name: "lirideployment" }
        Depends { name: "Qt"; submodules: ["gui", "qml", "quick", "quickcontrols2"]; versionAtLeast: project.minimumQtVersion }
        Depends { name: "Android.ndk"; condition: qbs.targetOS.contains("android") }

        Properties {
            condition: qbs.targetOS.contains("android")
            architectures: !qbs.architecture ? ["x86", "armv7a"] : undefined
            Android.ndk.appStl: "gnustl_shared"
        }

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

        files: ["*.cpp", "*.h"]

        Group {
            name: "Resource Data"
            files: ["images/**", "qml/**"]
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

