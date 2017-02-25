import qbs 1.0

Product {
    name: "Icons"

    Group {
        files: ["action/*.svg"]
        fileTags: ["icons"]
        qbs.install: true
        qbs.installDir: "qml/Fluid/Controls/icons/action"
    }

    Group {
        files: ["alert/*.svg"]
        fileTags: ["icons"]
        qbs.install: true
        qbs.installDir: "qml/Fluid/Controls/icons/alert"
    }

    Group {
        files: ["av/*.svg"]
        fileTags: ["icons"]
        qbs.install: true
        qbs.installDir: "qml/Fluid/Controls/icons/av"
    }

    Group {
        files: ["communication/*.svg"]
        fileTags: ["icons"]
        qbs.install: true
        qbs.installDir: "qml/Fluid/Controls/icons/communication"
    }

    Group {
        files: ["content/*.svg"]
        fileTags: ["icons"]
        qbs.install: true
        qbs.installDir: "qml/Fluid/Controls/icons/content"
    }

    Group {
        files: ["device/*.svg"]
        fileTags: ["icons"]
        qbs.install: true
        qbs.installDir: "qml/Fluid/Controls/icons/device"
    }

    Group {
        files: ["editor/*.svg"]
        fileTags: ["icons"]
        qbs.install: true
        qbs.installDir: "qml/Fluid/Controls/icons/editor"
    }

    Group {
        files: ["file/*.svg"]
        fileTags: ["icons"]
        qbs.install: true
        qbs.installDir: "qml/Fluid/Controls/icons/file"
    }

    Group {
        files: ["hardware/*.svg"]
        fileTags: ["icons"]
        qbs.install: true
        qbs.installDir: "qml/Fluid/Controls/icons/hardware"
    }

    Group {
        files: ["image/*.svg"]
        fileTags: ["icons"]
        qbs.install: true
        qbs.installDir: "qml/Fluid/Controls/icons/image"
    }

    Group {
        files: ["maps/*.svg"]
        fileTags: ["icons"]
        qbs.install: true
        qbs.installDir: "qml/Fluid/Controls/icons/maps"
    }

    Group {
        files: ["navigation/*.svg"]
        fileTags: ["icons"]
        qbs.install: true
        qbs.installDir: "qml/Fluid/Controls/icons/navigation"
    }

    Group {
        files: ["notification/*.svg"]
        fileTags: ["icons"]
        qbs.install: true
        qbs.installDir: "qml/Fluid/Controls/icons/notification"
    }

    Group {
        files: ["social/*.svg"]
        fileTags: ["icons"]
        qbs.install: true
        qbs.installDir: "qml/Fluid/Controls/icons/social"
    }

    Group {
        files: ["toggle/*.svg"]
        fileTags: ["icons"]
        qbs.install: true
        qbs.installDir: "qml/Fluid/Controls/icons/toggle"
    }
}
