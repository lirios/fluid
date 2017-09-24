import qbs 1.0

LiriQmlPlugin {
    name: "fluidcoreplugin"
    pluginPath: "Fluid/Core"

    Depends { name: "Qt"; submodules: ["svg", "gui"]; versionAtLeast: project.minimumQtVersion }

    cpp.defines: base.concat(['FLUID_VERSION="' + project.version + '"'])

    files: ["*.cpp", "*.h", "qmldir", "*.qml", "*.qmltypes"]
    excludeFiles: ["registerplugins.cpp"]
}
