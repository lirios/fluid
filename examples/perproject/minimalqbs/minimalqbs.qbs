import qbs 1.0

Project {
    // Project name
    name: "Per-project Qbs"

    // Your sub-projects go here
    references: [
        "src/src.qbs"
    ]

    // Add Fluid search paths here
    qbsSearchPaths: ["fluid/qbs/shared", "fluid/qbs/local"]

    // Minimum Qbs version required (don't go below 1.6)
    minimumQbsVersion: "1.6"

    // Include Fluid project
    SubProject {
        filePath: "fluid/fluid.qbs"

        Properties {
            withDocumentation: false
            withDemo: false
            autotestEnabled: false
        }
    }
}
