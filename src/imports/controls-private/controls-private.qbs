import qbs 1.0
import qbs.FileInfo

LiriQmlPlugin {
    name: "fluidcontrolsprivateplugin"
    pluginPath: "Fluid/Controls/Private"

    Depends { name: "Qt.quickcontrols2"; versionAtLeast: project.minimumQtVersion }
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

    cpp.defines: base.concat(['FLUID_VERSION="' + project.version + '"'])

    Group {
        name: "QML"
        files: ["qmldir", "*.qml", "*.qmltypes"]
    }

    Group {
        name: "Sources"
        files: ["*.cpp", "*.h", "*.qrc"]
    }
}
