import qbs 1.0

QtApplication {
    name: "tst_fluid_controls"
    type: base.concat(["autotest"])

    Depends { name: "Qt"; submodules: ["gui", "testlib", "qmltest"] }

    files: ["*.cpp"]
}
