import qbs 1.0
import qbs.FileInfo

LiriQmlPlugin {
    name: "fluidcontrolsplugin"
    pluginPath: "Fluid/Controls"

    Depends { name: "Qt"; submodules: ["quickcontrols2", "svg"]; versionAtLeast: project.minimumQtVersion }

    Properties {
        condition: qbs.targetOS.contains("osx")
        cpp.linkerFlags: ["-lstdc++"]
    }

    cpp.defines: [
        'FLUID_VERSION="' + project.version + '"',
        'FLUID_INSTALL_ICONS=' + (project.installIcons ? '1' : '0'),
    ]

    Group {
        name: "QML"
        files: ["qmldir", "*.qml", "*.qmltypes"]
        qbs.install: true
        qbs.installDir: FileInfo.joinPaths(lirideployment.qmlDir, pluginPath)
    }

    Group {
        name: "Sources"
        files: {
            var sources = ["*.cpp", "*.h"];
            if (!project.installIcons)
                sources.concat(["*.qrc"]);
            return sources;
        }
    }

    Group {
        condition: project.installIcons
        name: "Icons"
        prefix: "icons/"
        files: ["**/*.svg"]
        qbs.install: true
        qbs.installSourceBase: prefix
        qbs.installDir: FileInfo.joinPaths(lirideployment.qmlDir, pluginPath, "icons")
    }
}
