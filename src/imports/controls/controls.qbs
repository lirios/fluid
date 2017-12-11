import qbs 1.0
import qbs.FileInfo

LiriQmlPlugin {
    name: "fluidcontrolsplugin"
    pluginPath: "Fluid/Controls"

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

    files: ["*.cpp", "*.h", "qmldir", "*.qml", "*.qmltypes"]

    Group {
        name: "Icons"
        files: "**/*.svg"
        prefix: qbs.installSourceBase
        qbs.install: true
        qbs.installSourceBase: "../../../icons/"
        qbs.installDir: FileInfo.joinPaths(lirideployment.qmlDir, pluginPath, "icons")
    }
}
