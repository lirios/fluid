import qbs 1.0
import "../../qbs/shared/imports/LiriUtils.js" as LiriUtils

LiriModuleProject {
    id: root

    name: "Fluid"
    moduleName: "Fluid"
    description: "Collection of QtQuick components"

    resolvedProperties: ({
        Depends: [{ name: LiriUtils.quote("Qt.core") }]
    })

    pkgConfigDependencies: ["Qt5Core"]

    cmakeDependencies: ({ "Qt5Core": "5.8.0" })
    cmakeLinkLibraries: ["Qt5::Core"]

    LiriHeaders {
        name: root.headersName
        sync.module: root.moduleName

        Group {
            name: "Headers"
            files: "**/*.h"
            fileTags: ["hpp_syncable"]
        }
    }

    LiriModule {
        name: root.moduleName
        targetName: root.targetName
        version: "0.0.0"

        Depends { name: root.headersName }
        Depends { name: "Qt"; submodules: "core"; versionAtLeast: "5.8" }

        cpp.defines: base.concat([
            "FLUID_VERSION=" + project.version,
            "QT_BUILD_FLUID_LIB"
        ])

        files: ["*.cpp", "*.h"]

        Export {
            Depends { name: "cpp" }
            Depends { name: root.headersName }
            Depends { name: "Qt"; submodules: "core"; versionAtLeast: "5.8" }
        }
    }
}
