import qbs 1.0

Project {
    name: "Deployment"

    references: [
        "windows.qbs",
        "tarball.qbs",
        "module.qbs",
    ]
}
