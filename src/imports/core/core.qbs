import qbs 1.0

LiriQmlPlugin {
    name: "fluidcoreplugin"
    pluginPath: "Fluid/Core"

    Depends { name: "Qt"; submodules: ["svg", "gui"]; versionAtLeast: project.minimumQtVersion }
    Depends {
        condition: qbs.targetOS.contains("linux")
        name: "Qt"
        submodules: ["waylandclient", "waylandclient-private"]
        versionAtLeast: project.minimumQtVersion
        required: false
    }

    bundle.isBundle: false

    cpp.defines: base.concat(['FLUID_VERSION="' + project.version + '"'])

    files: ["*.cpp", "*.h", "qmldir", "*.qml", "*.qmltypes"]
}
