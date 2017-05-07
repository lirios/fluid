import qbs 1.0

QtApplication {
    name: "tst_fluid_material"
    type: base.concat(["autotest"])

    Depends { name: "Qt"; submodules: ["gui", "testlib", "qmltest"] }

    files: ["*.cpp"]
}
