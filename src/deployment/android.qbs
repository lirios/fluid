import qbs 1.0

AndroidApk {
    name: "fluid-apk"
    packageName: "io.liri.Fluid.Demo"

    condition: qbs.targetOS.contains("android")
    builtByDefault: false
    sourceSetDir: "../demo/android"

    Depends { name: "fluid-demo" }
}
