import qbs 1.0
import qbs.FileInfo

Project {
    name: "Fluid"

    readonly property string version: "0.10.0"

    property bool autotestEnabled: false
    property stringList autotestArguments: []
    property stringList autotestWrapper: []

    property bool withDocumentation: true
    property bool withDemo: true

    property bool deploymentEnabled: false

    minimumQbsVersion: "1.6"

    qbsSearchPaths: ["qbs/shared"]

    references: [
        "dist/win.qbs",
        "doc/doc.qbs",
        "icons/icons.qbs",
        "src/demo/demo.qbs",
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

    AutotestRunner {
        Depends { name: "lirideployment" }
        Depends { name: "fluidcontrolsplugin" }
        Depends { name: "fluidcoreplugin" }
        Depends { name: "fluideffectsplugin" }
        Depends { name: "fluidlayoutsplugin" }
        Depends { name: "fluidmaterialplugin" }

        builtByDefault: autotestEnabled
        name: "fluid-autotest"
        arguments: project.autotestArguments
        wrapper: project.autotestWrapper
        environment: {
            var env = base;
            env.push("QML2_IMPORT_PATH=" + FileInfo.joinPaths(qbs.installRoot, qbs.installPrefix, lirideployment.qmlDir));
            return env;
        }
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
