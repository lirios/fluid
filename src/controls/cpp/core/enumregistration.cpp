// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#include <QtCore/qcoreapplication.h>
#include <QtCore/qstring.h>
#include <QtCore/qurl.h>
#include <QtQml/qqml.h>

namespace Fluid {
namespace {

void registerEnumOwners()
{
    // Qualified lookups through qmldir reject the current QML file as recursive.
    // Register enum owners in the module's type table so self-enums resolve there
    // before Qt falls back to looking up the source file through qmldir.
    const struct
    {
        const char *name;
        const char *directory;
    } owners[] = {
        { "AppBar", "components" },      { "AppBarAction", "components" },
        { "BaseAppBar", "internal" },    { "FAB", "components" },
        { "FabMenu", "components" },     { "FabMenuButton", "components" },
        { "IconButton", "components" },  { "IconLabel", "components" },
        { "Menu", "components" },        { "MenuItem", "components" },
        { "RangeSlider", "components" }, { "SearchAppBar", "components" },
        { "Slider", "components" },      { "Switch", "components" },
        { "Symbol", "components" },
    };

    for (const auto &owner : owners) {
        const auto url = QUrl(
                QStringLiteral("qrc:/qt/qml/Fluid/qml/%1/%2.qml")
                        .arg(QLatin1StringView(owner.directory), QLatin1StringView(owner.name)));
        qmlRegisterType(url, "Fluid", 2, 0, owner.name);
    }
}

Q_COREAPP_STARTUP_FUNCTION(registerEnumOwners)

} // namespace
} // namespace Fluid
