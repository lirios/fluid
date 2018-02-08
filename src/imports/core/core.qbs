import qbs 1.0

LiriQmlPlugin {
    name: "fluidcoreplugin"
    pluginPath: "Fluid/Core"

    Depends { name: "Qt"; submodules: ["svg", "gui"]; versionAtLeast: project.minimumQtVersion }
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
}
