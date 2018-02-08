import qbs 1.0

Project {
    name: "Deployment"
    condition: project.deploymentEnabled

    references: [
        "windows.qbs",
        "linux.qbs",
        "module.qbs",
    ]
}
