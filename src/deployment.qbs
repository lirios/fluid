import qbs 1.0

Project {
    name: "Deployment"

    references: [
        "windeployment.qbs",
    ]

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
    }
}
