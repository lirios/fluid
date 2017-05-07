import qbs 1.0

QtApplication {
    name: "tst_fluid_material"
    type: base.concat(["autotest"])

    Depends { name: "Qt"; submodules: ["gui", "testlib", "qmltest"] }

    cpp.defines: base.concat(['QUICK_TEST_SOURCE_DIR="' + product.sourceDirectory + '"'])

    files: ["*.cpp"]
}
