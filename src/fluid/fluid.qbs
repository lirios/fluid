import qbs 1.0

LiriModule {
    name: "Fluid"
    targetName: "Fluid"
    version: "0.0.0"

    Depends { name: "Qt"; submodules: "core"; versionAtLeast: "5.8" }

    cpp.defines: base.concat([
        "FLUID_VERSION=" + project.version,
        "QT_BUILD_FLUID_LIB"
    ])

    create_headers.headersMap: ({
        "dateutils.h": "DateUtils",
    })

    create_pkgconfig.description: "Collection of QtQuick components"
    create_pkgconfig.version: project.version
    create_pkgconfig.dependencies: ["Qt5Core"]

    create_cmake.version: project.version

    files: ["*.cpp"]

    Group {
        name: "Headers"
        files: ["*.h"]
        excludeFiles: ["*_p.h"]
        fileTags: ["public_headers"]
    }

    Group {
        name: "Private Headers"
        files: ["*_p.h"]
        fileTags: ["private_headers"]
    }

    Export {
        property bool found: true

        Depends { name: "cpp" }
        Depends { name: "Qt"; submodules: "core"; versionAtLeast: "5.8" }

        cpp.includePaths: product.generatedHeadersDir
    }
}
