import qbs 1.0

Project {
    name: "Fluid"

    readonly property string version: "0.10.0"
    readonly property var versionParts: version.split('.').map(function(part) { return parseInt(part); })

    property bool autotestEnabled: false
    property stringList autotestArguments: []
    property stringList autotestWrapper: []

    property bool withDocumentation: true
    property bool withDemo: true

    property bool deploymentEnabled: false

    minimumQbsVersion: "1.6"

    qbsSearchPaths: ["qbs/shared"]

    references: [
        "doc/doc.qbs",
        "src/deployment.qbs",
        "src/demo/demo.qbs",
        "src/fluid/fluid.qbs",
        "src/imports/imports.qbs",
        "tests/auto/auto.qbs",
    ]
}
