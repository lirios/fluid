import qbs 1.0

InstallPackage {
    name: "fluid-artifacts"
    targetName: name
    builtByDefault: false

    archiver.type: "tar"
    archiver.outputDirectory: project.buildDirectory

    Depends { name: "fluid-demo" }
}
