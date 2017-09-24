import qbs 1.0

Project {
    name: "Deployment"

    references: [
        "android.qbs",
        "windows.qbs",
        "linux.qbs",
    ]
}
