import qbs 1.0

Project {
    name: "Deployment"

    references: [
        "windows.qbs",
        "linux.qbs",
        "module.qbs",
    ]
}
