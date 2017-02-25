import qbs 1.0
import qbs.File
import qbs.FileInfo
import qbs.TextFile

DynamicLibrary {
    name: "libFluid"
    targetName: "Fluid"

    property string generatedHeadersDir: FileInfo.joinPaths(product.buildDirectory, "include")

    Depends { name: "cpp" }
    Depends { name: "Qt"; submodules: "core"; versionAtLeast: "5.8" }

    cpp.cxxLanguageVersion: "c++11"
    cpp.visibility: "minimal"
    cpp.defines: [
        "FLUID_VERSION=" + project.version,
        "QT_BUILD_FLUID_LIB",
        "QT_NO_CAST_FROM_ASCII",
        "QT_NO_CAST_TO_ASCII"
    ]
    cpp.includePaths: [
        product.sourceDirectory,
        product.generatedHeadersDir
    ]

    files: [
        "dateutils.cpp"
    ]

    Group {
        name: "Headers"
        files: [
            "fluidglobal.h",
            "dateutils.h"
        ]
        fileTags: ["public_hpp"]
    }

    Rule {
        inputs: ["public_hpp"]

        Artifact {
            filePath: FileInfo.joinPaths(product.generatedHeadersDir, "Fluid", input.fileName)
            fileTags: ["hpp"]
        }

        prepare: {
            var cmd = new JavaScriptCommand();
            cmd.description = "Copying " + output.fileName + " to build directory";
            cmd.extendedDescription = "Copying " + output.fileName + " to " + output.filePath;
            cmd.highlight = "filegen";
            cmd.sourceCode = function() {
                File.makePath(FileInfo.path(output.filePath));
                File.copy(input.filePath, output.filePath);
            };
            return [cmd];
        }
    }

    Rule {
        inputs: ["public_hpp"]
        outputArtifacts: {
            var map = {
                "dateutils.h": "DateUtils"
            };
            var artifacts = [];

            if (map.hasOwnProperty(input.fileName)) {
                var artifact = {
                    filePath: FileInfo.joinPaths(product.generatedHeadersDir, "Fluid", map[input.fileName]),
                    fileTags: ["hpp"]
                };
                artifacts.push(artifact);
            }

            return artifacts;
        }
        outputFileTags: ["hpp"]
        prepare: {
            var cmd = new JavaScriptCommand();
            cmd.description = "Copying " + output.fileName + " to build directory";
            cmd.sourceCode = function() {
                var file = new TextFile(output.filePath, TextFile.WriteOnly);
                file.write('#include "' + input.fileName + '"');
                file.close();
            };
            return [cmd];
        }
    }

    Group {
        qbs.install: true
        qbs.installDir: "include/Fluid"
        fileTagsFilter: "hpp"
    }

    Group {
        qbs.install: true
        qbs.installDir: bundle.isBundle ? "Library/Frameworks" : (qbs.targetOS.contains("windows") ? "" : "lib")
        qbs.installSourceBase: product.buildDirectory
        fileTagsFilter: [
            "dynamiclibrary",
            "dynamiclibrary_symlink",
            "dynamiclibrary_import"
        ]
    }

    Export {
        Depends { name: "cpp" }
        Depends { name: "Qt"; submodules: "core"; versionAtLeast: "5.8" }

        cpp.includePaths: product.generatedHeadersDir
    }
}
