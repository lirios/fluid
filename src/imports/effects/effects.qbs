import qbs 1.0

LiriQmlPlugin {
    name: "fluideffectsplugin"
    pluginPath: "Fluid/Effects"

    cpp.defines: base.concat(['FLUID_VERSION="' + project.version + '"'])

    files: ["*.cpp", "*.h", "qmldir", "*.qml", "*.qmltypes"]
}
