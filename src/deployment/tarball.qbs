import qbs 1.0

InstallPackage {
    name: "fluid-artifacts"
    targetName: name
    condition: project.deploymentEnabled

    archiver.type: "tar"
    archiver.outputDirectory: project.buildDirectory

    Depends { name: "fluid-demo"; required: project.withDemo }
    Depends { name: "fluidcontrolsplugin"; required: project.withQmlModules }
    Depends { name: "fluidcoreplugin"; required: project.withQmlModules }
    Depends { name: "fluideffectsplugin"; required: project.withQmlModules }
    Depends { name: "fluidlayoutsplugin"; required: project.withQmlModules }
    Depends { name: "fluidtemplatesplugin"; required: project.withQmlModules }
}
