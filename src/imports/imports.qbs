import qbs 1.0

Project {
    name: "QML Plugins"

    references: [
        "core/core.qbs",
        "controls/controls.qbs",
        "effects/effects.qbs",
        "layouts/layouts.qbs",
        "templates/templates.qbs",
    ]
}
