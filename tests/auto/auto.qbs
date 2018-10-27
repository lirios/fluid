import qbs 1.0
import qbs.FileInfo

Project {
    name: "Autotests"
    condition: project.autotestEnabled && project.withQmlModules

    references: [
        "controls/controls.qbs",
        "core/core.qbs",
    ]

    AutotestRunner {
        Depends { name: "lirideployment" }
        Depends { name: "fluidcontrolsplugin" }
        Depends { name: "fluidcoreplugin" }
        Depends { name: "fluideffectsplugin" }
        Depends { name: "fluidlayoutsplugin" }

        condition: !qbs.targetOS.contains("android")
        builtByDefault: project.autotestEnabled
        name: "fluid-autotest"
        arguments: project.autotestArguments
        wrapper: project.autotestWrapper
        environment: {
            var env = base;
            env.push("QML2_IMPORT_PATH=" + FileInfo.joinPaths(qbs.installRoot, qbs.installPrefix, lirideployment.qmlDir));
            env.push("QT_QUICK_CONTROLS_STYLE=material");
            return env;
        }
    }
}
