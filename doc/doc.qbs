import qbs 1.0

Project {
    readonly property string versionTag: project.version.replace(/\./g, "_")
    readonly property stringList qdocEnvironment: [
        "FLUID_VERSION=" + project.version,
        "FLUID_VERSION_TAG=" + versionTag,
    ]

    name: "Documentation"
    condition: project.withDocumentation && !qbs.targetOS.contains("android")

    references: [
        "offline.qbs",
    ]
}
