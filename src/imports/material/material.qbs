import qbs 1.0

LiriQmlPlugin {
    name: "fluidmaterialplugin"
    pluginPath: "Fluid/Material"

    cpp.defines: base.concat(['FLUID_VERSION="' + project.version + '"'])

    files: ["*.cpp", "*.h", "qmldir", "*.qml", "*.qmltypes"]
}
