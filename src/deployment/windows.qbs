import qbs 1.0
import qbs.FileInfo
import qbs.ModUtils
import qbs.Process
import qbs.TextFile

Product {
    // List of windeployqt arguments
    property stringList windeployqtArgs: [
        "--qmldir", FileInfo.joinPaths(qbs.installRoot, qbs.installPrefix, lirideployment.qmlDir),
    ]

    // List of path prefixes to be excluded from the generated archive
    property stringList excludedPathPrefixes: []

    name: "fluid-windows"
    condition: qbs.targetOS.contains("windows")
    builtByDefault: project.deploymentEnabled
    type: ["archiver.archive"]
    targetName: "fluid-windows-" + qbs.architecture + "-" + project.version
    destinationDirectory: project.buildDirectory

    Depends { name: "lirideployment" }
    Depends { name: "archiver" }
    Depends { name: "Qt.core" }

    Depends { name: "fluid-demo" }
    Depends { name: "fluidcontrolsplugin" }
    Depends { name: "fluidcoreplugin" }
    Depends { name: "fluideffectsplugin" }
    Depends { name: "fluidlayoutsplugin" }

    archiver.type: "7zip"
    archiver.workingDirectory: qbs.installRoot

    Rule {
        multiplex: true
        inputsFromDependencies: ["installable"]

        Artifact {
            filePath: "windeployqt.json"
            fileTags: ["dependencies.json"]
        }

        prepare: {
            var cmd = new JavaScriptCommand();
            cmd.description = "windeployqt";
            cmd.outputFilePath = output.filePath;
            cmd.installRoot = product.moduleProperty("qbs", "installRoot");
            cmd.windeployqtArgs = product.windeployqtArgs;
            cmd.binaryFilePaths = inputs.installable.filter(function (artifact) {
                return artifact.fileTags.contains("application")
                        || artifact.fileTags.contains("dynamiclibrary");
            }).map(function(a) { return ModUtils.artifactInstalledFilePath(a); });
            cmd.extendedDescription = FileInfo.joinPaths(
                        product.moduleProperty("Qt.core", "binPath"), "windeployqt") + ".exe " +
                    ["--json"].concat(cmd.windeployqtArgs).concat(cmd.binaryFilePaths).join(" ");
            cmd.sourceCode = function () {
                var out;
                var process;
                try {
                    process = new Process();
                    process.exec(FileInfo.joinPaths(product.moduleProperty("Qt.core", "binPath"),
                                                    "windeployqt"), ["--json"]
                                 .concat(windeployqtArgs).concat(binaryFilePaths), true);
                    out = process.readStdOut();
                } finally {
                    if (process)
                        process.close();
                }

                var tf;
                try {
                    tf = new TextFile(outputFilePath, TextFile.WriteOnly);
                    tf.write(out);
                } finally {
                    if (tf)
                        tf.close();
                }
            };
            return [cmd];
        }
    }

    Rule {
        multiplex: true
        inputs: ["dependencies.json"]
        inputsFromDependencies: ["installable"]

        Artifact {
            filePath: "list.txt"
            fileTags: ["archiver.input-list"]
        }

        prepare: {
            var cmd = new JavaScriptCommand();
            cmd.silent = true;
            cmd.excludedPathPrefixes = product.excludedPathPrefixes;
            cmd.inputFilePaths = inputs.installable.map(function(a) {
                return ModUtils.artifactInstalledFilePath(a);
            });
            cmd.outputFilePath = output.filePath;
            cmd.baseDirectory = product.moduleProperty("archiver", "workingDirectory");
            cmd.sourceCode = function() {
                var tf;
                for (var i = 0; i < inputs["dependencies.json"].length; ++i) {
                    try {
                        tf = new TextFile(inputs["dependencies.json"][i].filePath,
                                          TextFile.ReadOnly);
                        inputFilePaths = inputFilePaths.concat(
                                    JSON.parse(tf.readAll())["files"].map(function (obj) {
                                        return FileInfo.joinPaths(
                                                    FileInfo.fromWindowsSeparators(obj.target),
                                                    FileInfo.fileName(
                                                        FileInfo.fromWindowsSeparators(
                                                            obj.source)));
                                    }));
                    } finally {
                        if (tf)
                            tf.close();
                    }
                }

                inputFilePaths.sort();

                try {
                    tf = new TextFile(outputFilePath, TextFile.ReadWrite);
                    for (var i = 0; i < inputFilePaths.length; ++i) {
                        var ignore = false;
                        var relativePath = FileInfo.relativePath(baseDirectory, inputFilePaths[i]);
                        for (var j = 0; j < excludedPathPrefixes.length; ++j) {
                            if (relativePath.startsWith(excludedPathPrefixes[j])) {
                                ignore = true;
                                break;
                            }
                        }

                        if (!ignore)
                            tf.writeLine(relativePath);
                    }
                } finally {
                    if (tf)
                        tf.close();
                }
            };

            return [cmd];
        }
    }
}
