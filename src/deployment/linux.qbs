import qbs 1.0

InstallPackage {
    name: "fluid-artifacts"
    targetName: name
    builtByDefault: false

    archiver.type: "tar"
    archiver.outputDirectory: project.buildDirectory

    Depends { name: "fluid-demo" }
    Depends { name: "fluidcontrolsplugin" }
    Depends { name: "fluidcoreplugin" }
    Depends { name: "fluideffectsplugin" }
    Depends { name: "fluidlayoutsplugin" }
    Depends { name: "fluidtemplatesplugin" }
}
