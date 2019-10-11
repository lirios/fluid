import qbs 1.0
import qbs.Probes

Project {
    name: "Fluid"

    readonly property string version: "1.2.0"
    readonly property var versionParts: version.split('.').map(function(part) { return parseInt(part); })

    readonly property string minimumQtVersion: "5.10.0"

    property bool useSystemQbsShared: false

    property bool useStaticAnalyzer: false

    property bool autotestEnabled: false
    property stringList autotestArguments: []
    property stringList autotestWrapper: []

    property bool withDocumentation: true
    property bool withDemo: true
    property bool withQmlModules: true

    property bool installIcons: true

    property bool deploymentEnabled: false

    minimumQbsVersion: "1.14.0"

    qbsSearchPaths: useSystemQbsShared ? [] : ["qbs/shared"]

    references: [
        "doc/doc.qbs",
        "src/imports/imports.qbs",
        "src/demo/demo.qbs",
        "src/deployment/deployment.qbs",
        "tests/auto/auto.qbs",
    ]
}
