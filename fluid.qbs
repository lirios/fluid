import qbs 1.0

Project {
    name: "Fluid"

    readonly property string version: "0.10.0"

    property bool autotestEnabled: false
    property stringList autotestArguments: []
    property stringList autotestWrapper: []

    minimumQbsVersion: "1.6"

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
        "tests/auto/controls/controls.qbs",
        "tests/auto/core/core.qbs",
        "tests/auto/material/material.qbs",
    ]

    AutotestRunner {
        builtByDefault: autotestEnabled
        name: "fluid-autotest"
        arguments: project.autotestArguments
        wrapper: project.autotestWrapper
    }
}
