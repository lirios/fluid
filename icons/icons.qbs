import qbs 1.0

Product {
    name: "Icons"

    Depends { name: "lirideployment" }

    Group {
        name: "action"
        files: ["action/*.svg"]
        fileTags: ["icons"]
        qbs.install: true
        qbs.installDir: lirideployment.qmlDir + "/Fluid/Controls/icons/" + name
    }

    Group {
        name: "alert"
        files: ["alert/*.svg"]
        fileTags: ["icons"]
        qbs.install: true
        qbs.installDir: lirideployment.qmlDir + "/Fluid/Controls/icons/" + name
    }

    Group {
        name: "av"
        files: ["av/*.svg"]
        fileTags: ["icons"]
        qbs.install: true
        qbs.installDir: lirideployment.qmlDir + "/Fluid/Controls/icons/" + name
    }

    Group {
        name: "communication"
        files: ["communication/*.svg"]
        fileTags: ["icons"]
        qbs.install: true
        qbs.installDir: lirideployment.qmlDir + "/Fluid/Controls/icons/" + name
    }

    Group {
        name: "content"
        files: ["content/*.svg"]
        fileTags: ["icons"]
        qbs.install: true
        qbs.installDir: lirideployment.qmlDir + "/Fluid/Controls/icons/" + name
    }

    Group {
        name: "device"
        files: ["device/*.svg"]
        fileTags: ["icons"]
        qbs.install: true
        qbs.installDir: lirideployment.qmlDir + "/Fluid/Controls/icons/" + name
    }

    Group {
        name: "editor"
        files: ["editor/*.svg"]
        fileTags: ["icons"]
        qbs.install: true
        qbs.installDir: lirideployment.qmlDir + "/Fluid/Controls/icons/" + name
    }

    Group {
        name: "file"
        files: ["file/*.svg"]
        fileTags: ["icons"]
        qbs.install: true
        qbs.installDir: lirideployment.qmlDir + "/Fluid/Controls/icons/" + name
    }

    Group {
        name: "hardware"
        files: ["hardware/*.svg"]
        fileTags: ["icons"]
        qbs.install: true
        qbs.installDir: lirideployment.qmlDir + "/Fluid/Controls/icons/" + name
    }

    Group {
        name: "image"
        files: ["image/*.svg"]
        fileTags: ["icons"]
        qbs.install: true
        qbs.installDir: lirideployment.qmlDir + "/Fluid/Controls/icons/" + name
    }

    Group {
        name: "maps"
        files: ["maps/*.svg"]
        fileTags: ["icons"]
        qbs.install: true
        qbs.installDir: lirideployment.qmlDir + "/Fluid/Controls/icons/" + name
    }

    Group {
        name: "navigation"
        files: ["navigation/*.svg"]
        fileTags: ["icons"]
        qbs.install: true
        qbs.installDir: lirideployment.qmlDir + "/Fluid/Controls/icons/" + name
    }

    Group {
        name: "notification"
        files: ["notification/*.svg"]
        fileTags: ["icons"]
        qbs.install: true
        qbs.installDir: lirideployment.qmlDir + "/Fluid/Controls/icons/" + name
    }

    Group {
        name: "social"
        files: ["social/*.svg"]
        fileTags: ["icons"]
        qbs.install: true
        qbs.installDir: lirideployment.qmlDir + "/Fluid/Controls/icons/" + name
    }

    Group {
        name: "toggle"
        files: ["toggle/*.svg"]
        fileTags: ["icons"]
        qbs.install: true
        qbs.installDir: lirideployment.qmlDir + "/Fluid/Controls/icons/" + name
    }
}
