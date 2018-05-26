import qbs 1.0

Project {
    name: "QML Plugins"
    condition: project.withQmlModules

    references: [
        "core/core.qbs",
        "controls/controls.qbs",
        "controls-private/controls-private.qbs",
        "effects/effects.qbs",
        "layouts/layouts.qbs",
        "templates/templates.qbs",
    ]
}
