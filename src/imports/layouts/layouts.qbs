import qbs 1.0

LiriQmlPlugin {
    name: "fluidlayoutsplugin"
    pluginPath: "Fluid/Layouts"

    cpp.defines: base.concat(['FLUID_VERSION="' + project.version + '"'])

    files: ["*.cpp", "*.h", "qmldir", "*.qml", "*.qmltypes"]
}
