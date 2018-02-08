import qbs 1.0
import qbs.FileInfo
import qbs.TextFile

Product {
    name: "fluid-qbs"
    type: ["qbs_module"]

    Depends { name: "lirideployment" }

    Rule {
        requiresInputs: false
        multiplex: true

        Artifact {
            filePath: "Fluid.qbs"
            fileTags: ["qbs_module"]
        }

        prepare: {
            var cmd = new JavaScriptCommand();
            cmd.description = "generate Fluid.qbs";
            cmd.highlight = "codegen";
            cmd.sourceCode = function() {
                var outputFile = new TextFile(output.filePath, TextFile.WriteOnly);
                outputFile.writeLine("import qbs");
                outputFile.writeLine("");
                outputFile.writeLine("Module {");
                outputFile.writeLine("    version: \"" + project.version + "\"");
                outputFile.writeLine("}");
                outputFile.close();
            };
            return [cmd];
        }
    }

    Group {
        qbs.install: true
        qbs.installDir: FileInfo.joinPaths(lirideployment.qbsModulesDir, "Fluid")
        fileTagsFilter: ["qbs_module"]
    }
}
