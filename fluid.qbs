import qbs 1.0

Project {
    name: "Fluid"

    readonly property string version: "0.10.0"

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

    minimumQbsVersion: "1.7"

    Product {
        name: "qmake project files for fluid"
        files: ["**/*.pr[io]"]
    }
}
