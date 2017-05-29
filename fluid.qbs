import qbs 1.0

Project {
    name: "Fluid"

    readonly property string version: "0.10.0"

    property bool documentationEnabled: true
    property bool demoEnabled: true
    property bool autotestEnabled: false
    property stringList autotestArguments: []
    property stringList autotestWrapper: []

    minimumQbsVersion: "1.6"

    qbsSearchPaths: ["qbs/shared", "qbs/local"]

    references: [
        "icons/icons.qbs",
        "src/fluid/fluid.qbs",
        "src/imports/core/core.qbs",
        "src/imports/controls/controls.qbs",
        "src/imports/effects/effects.qbs",
        "src/imports/layouts/layouts.qbs",
        "src/imports/material/material.qbs",
        "tests/auto/controls/controls.qbs",
        "tests/auto/core/core.qbs",
        "tests/auto/material/material.qbs",
    ]

    SubProject {
        filePath: "doc/doc.qbs"

        Properties {
            condition: documentationEnabled
        }
    }

    SubProject {
        filePath: "src/demo/demo.qbs"

        Properties {
            condition: demoEnabled
        }
    }

    AutotestRunner {
        builtByDefault: autotestEnabled
        name: "fluid-autotest"
        arguments: project.autotestArguments
        wrapper: project.autotestWrapper
    }

    InstallPackage {
        name: "fluid-artifacts"
        targetName: name
        builtByDefault: false

        archiver.type: "tar"
        archiver.outputDirectory: project.buildDirectory

        Depends { name: "Fluid" }
        Depends { name: "fluidcontrolsplugin" }
        Depends { name: "fluidcoreplugin" }
        Depends { name: "fluideffectsplugin" }
        Depends { name: "fluidlayoutsplugin" }
        Depends { name: "fluidmaterialplugin" }
        Depends { name: "Icons" }
    }
}
