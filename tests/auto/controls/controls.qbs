import qbs 1.0

QtApplication {
    name: "tst_fluid_controls"
    type: ["application", "autotest"]

    Depends { name: "Qt"; submodules: ["gui", "testlib", "qmltest"] }

    files: [ "controls.cpp" ]
}
