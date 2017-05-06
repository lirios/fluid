import qbs 1.0

Project {
    name: "Fluid"

    readonly property string version: "0.10.0"

    property stringList autotestArguments: []
    property stringList autotestWrapper: []

    minimumQbsVersion: "1.7"

    qbsSearchPaths: "qbs-shared"

    references: [
        "doc/doc.qbs",
        "icons/icons.qbs",
        "src/fluid/fluid.qbs",
        "src/imports/core/core.qbs",
        "src/imports/controls/controls.qbs",
        "src/imports/effects/effects.qbs",
        "src/imports/layouts/layouts.qbs",
        "src/imports/material/material.qbs",
        "src/demo/demo.qbs",
        "tests/auto/auto.qbs"
    ]

    AutotestRunner {
        name: "fluid-autotest"
        arguments: project.autotestArguments
        wrapper: project.autotestWrapper
    }
}
