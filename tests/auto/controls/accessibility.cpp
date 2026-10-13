// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#include <QAccessible>
#include <QAccessibleActionInterface>
#include <QAccessibleValueInterface>
#include <QGuiApplication>
#include <QMetaEnum>
#include <QQmlComponent>
#include <QQmlEngine>
#include <QQuickItem>
#include <QQuickWindow>
#include <QScopedPointer>
#include <QTest>

namespace {

QAccessibleInterface *findAccessible(QAccessibleInterface *interface, const QString &name)
{
    if (!interface || !interface->isValid())
        return nullptr;
    if (interface->text(QAccessible::Name) == name)
        return interface;
    for (int index = 0; index < interface->childCount(); ++index) {
        if (auto *match = findAccessible(interface->child(index), name))
            return match;
    }
    return nullptr;
}

int actionableButtonCount(QAccessibleInterface *interface, bool visibleOnly = false)
{
    if (!interface || !interface->isValid())
        return 0;
    auto *actions = interface->actionInterface();
    int count = (!visibleOnly || !interface->state().invisible)
                    && interface->role() == QAccessible::Button && actions
                    && actions->actionNames().contains(QAccessibleActionInterface::pressAction())
            ? 1
            : 0;
    for (int index = 0; index < interface->childCount(); ++index)
        count += actionableButtonCount(interface->child(index), visibleOnly);
    return count;
}

} // namespace

class FluidAccessibilityTest : public QObject
{
    Q_OBJECT

private slots:
    void badgeHostsExposeFullInformationWithoutDecorativeNodes();
    void labeledFabInheritsButtonAccessibility();
    void rangeSliderHandlesAreRealAccessibleNodes();
    void textFieldIsAnEditableAccessibleNode();
    void segmentedButtonsExposeSelectionAndActivation();
    void splitButtonExposesIndependentActionsAndManagedExpansion();
    void splitButtonCustomPopupExposesBoundExpansion();
    void splitButtonRestoresFocusAfterAccessibleMenuActivation_data();
    void splitButtonRestoresFocusAfterAccessibleMenuActivation();
};

void FluidAccessibilityTest::badgeHostsExposeFullInformationWithoutDecorativeNodes()
{
    QAccessible::setActive(true);
    QQmlEngine engine;
    engine.addImportPath(QStringLiteral(FLUID_QML_IMPORT_PATH));
    QQmlComponent component(&engine);
    component.setData(R"(
        import QtQuick
        import Fluid as MD
        Window {
            width: 800; height: 600; visible: true
            property int activations: 0
            MD.IconButton {
                objectName: "inbox"
                text: "Inbox"; icon.name: MD.Symbols.mail
                badgeContent: "Updated"; x: 20; y: 100
                onClicked: ++activations
            }
            MD.NavigationRail {
                objectName: "rail"
                y: 160; height: 400
                MD.NavigationRailItem {
                    objectName: "home"
                    text: "Home"; icon.name: MD.Symbols.home
                }
                MD.NavigationRailItem {
                    objectName: "destination"
                    text: "Messages"; icon.name: MD.Symbols.mail
                    badgeContent: 1000; badgeAccessibleDescription: "1000 unread messages"
                    onClicked: ++activations
                }
            }
            MD.AppBarAction {
                id: notifications
                objectName: "notifications"
                text: "Notifications"; icon.name: MD.Symbols.notifications
                badgeContent: "Updated"; badgeAccessibleDescription: "New account updates"
                overflowPolicy: MD.AppBarAction.NeverOverflow
                onTriggered: ++activations
            }
            MD.AppBar { width: parent.width; title: "Example"; actions: [notifications] }
            MD.Badge { x: 400; y: 200; text: "Standalone status" }
        }
    )", QUrl(QStringLiteral("inline:badge-accessibility.qml")));
    QTRY_VERIFY_WITH_TIMEOUT(!component.isLoading(), 5000);
    QVERIFY2(component.isReady(), qPrintable(component.errorString()));
    QScopedPointer<QObject> root(component.create());
    QVERIFY2(root, qPrintable(component.errorString()));
    auto *window = qobject_cast<QQuickWindow *>(root.get());
    QVERIFY(window);
    QCoreApplication::processEvents();
    auto *tree = QAccessible::queryAccessibleInterface(window);
    QVERIFY(tree);
    auto *inbox = findAccessible(tree, QStringLiteral("Inbox, Updated"));
    auto *destination = findAccessible(tree, QStringLiteral("Messages, 1000 unread messages"));
    auto *notifications = findAccessible(tree, QStringLiteral("Notifications, New account updates"));
    auto *home = findAccessible(tree, QStringLiteral("Home"));
    auto *railObject = root->findChild<QObject *>(QStringLiteral("rail"));
    QVERIFY(inbox);
    QVERIFY(destination);
    QVERIFY(notifications);
    QVERIFY(home && railObject);
    QCOMPARE(inbox->role(), QAccessible::Button);
    QCOMPARE(destination->role(), QAccessible::PageTab);
    QCOMPARE(notifications->role(), QAccessible::Button);
    QCOMPARE(inbox->childCount(), 0);
    QCOMPARE(destination->childCount(), 0);
    QCOMPARE(notifications->childCount(), 0);
    QVERIFY(!findAccessible(tree, QStringLiteral("Upd…")));
    QVERIFY(!findAccessible(tree, QStringLiteral("Updated")));
    QVERIFY(!findAccessible(tree, QStringLiteral("999+")));
    QVERIFY(!findAccessible(tree, QStringLiteral("Standalone status")));
    // AppBar also owns hidden navigation/overflow buttons. Count visible hosts,
    // while the empty child lists above reject decorative or duplicate nodes.
    QCOMPARE(actionableButtonCount(tree, true), 2);
    QCOMPARE(railObject->property("currentIndex").toInt(), 0);
    QVERIFY(home->state().selected);
    QVERIFY(!destination->state().selected);
    for (auto *host : {inbox, destination, notifications}) {
        QVERIFY(host->state().focusable);
        auto *actions = host->actionInterface();
        QVERIFY(actions);
        QVERIFY(actions->actionNames().contains(QAccessibleActionInterface::pressAction()));
        actions->doAction(QAccessibleActionInterface::pressAction());
    }
    QTRY_COMPARE(root->property("activations").toInt(), 3);
    QTRY_COMPARE(railObject->property("currentIndex").toInt(), 1);
    QVERIFY(destination->state().selected);
    QVERIFY(!home->state().selected);
    auto *inboxObject = root->findChild<QObject *>(QStringLiteral("inbox"));
    auto *destinationObject = root->findChild<QObject *>(QStringLiteral("destination"));
    auto *notificationAction = root->findChild<QObject *>(QStringLiteral("notifications"));
    QVERIFY(inboxObject && destinationObject && notificationAction);
    QVERIFY(inboxObject->setProperty("badgeContent", QStringLiteral("A full status value")));
    QTRY_COMPARE(inbox->text(QAccessible::Name), QStringLiteral("Inbox, A full status value"));
    QVERIFY(inboxObject->setProperty("badgeVisible", false));
    QTRY_COMPARE(inbox->text(QAccessible::Name), QStringLiteral("Inbox"));
    QVERIFY(destinationObject->setProperty("badgeVisible", false));
    QTRY_COMPARE(destination->text(QAccessible::Name), QStringLiteral("Messages"));
    QVERIFY(notificationAction->setProperty("badgeVisible", false));
    QTRY_COMPARE(notifications->text(QAccessible::Name), QStringLiteral("Notifications"));
    destination->actionInterface()->doAction(QAccessibleActionInterface::pressAction());
    QTRY_COMPARE(root->property("activations").toInt(), 4);
    QVERIFY(destination->state().selected);
    QVERIFY(inboxObject->setProperty("badgeVisible", true));
    QVERIFY(inboxObject->setProperty("badgeContent", QString()));
    QTRY_COMPARE(inbox->text(QAccessible::Name), QStringLiteral("Inbox"));
    QVERIFY(inboxObject->setProperty("enabled", false));
    QVERIFY(inbox->state().disabled);
    inbox->actionInterface()->doAction(QAccessibleActionInterface::pressAction());
    QCOMPARE(root->property("activations").toInt(), 4);
    QVERIFY(destinationObject->setProperty("enabled", false));
    QVERIFY(destination->state().disabled);
    destination->actionInterface()->doAction(QAccessibleActionInterface::pressAction());
    QCOMPARE(root->property("activations").toInt(), 4);
    QVERIFY(destination->state().selected);
    QCOMPARE(inbox->childCount(), 0);
    QCOMPARE(destination->childCount(), 0);
    QCOMPARE(notifications->childCount(), 0);
}

void FluidAccessibilityTest::splitButtonExposesIndependentActionsAndManagedExpansion()
{
    QAccessible::setActive(true);
    QQmlEngine engine;
    engine.addImportPath(QStringLiteral(FLUID_QML_IMPORT_PATH));
    QQmlComponent component(&engine);
    component.setData(R"(
        import QtQuick
        import Fluid as MD

        Window {
            width: 640
            height: 480
            visible: true
            property int primaryCount: 0
            property int secondaryCount: 0
            property int actionCount: 0
            function replaceMenu() { split.menu = replacement }
            function iconOnly() {
                split.text = ""
                split.icon.name = MD.Symbols.save
                split.leadingButton.Accessible.name = "Save document"
            }
            MD.Action { id: save; text: "Save"; onTriggered: ++actionCount }
            MD.SplitButton {
                id: split
                objectName: "split"
                x: 100; y: 100
                action: save
                secondaryText: "More save options"
                onClicked: ++primaryCount
                onSecondaryClicked: ++secondaryCount
                menu: MD.Menu {
                    objectName: "managedMenu"
                    MD.Action { text: "Save as" }
                }
            }
            MD.Menu {
                id: replacement
                objectName: "replacementMenu"
                MD.Action { text: "Export" }
            }
        }
    )",
                      QUrl(QStringLiteral("inline:split-button-accessibility.qml")));
    QTRY_VERIFY_WITH_TIMEOUT(!component.isLoading(), 5000);
    QVERIFY2(component.isReady(), qPrintable(component.errorString()));
    QScopedPointer<QObject> root(component.create());
    QVERIFY2(root, qPrintable(component.errorString()));
    auto *window = qobject_cast<QQuickWindow *>(root.get());
    QVERIFY(window);
    QCoreApplication::processEvents();
    auto *split = root->findChild<QObject *>(QStringLiteral("split"));
    auto *menu = root->findChild<QObject *>(QStringLiteral("managedMenu"));
    auto *replacement = root->findChild<QObject *>(QStringLiteral("replacementMenu"));
    QVERIFY(split);
    QVERIFY(menu);
    QVERIFY(replacement);
    auto *windowInterface = QAccessible::queryAccessibleInterface(window);
    QVERIFY(windowInterface);
    auto *primary = findAccessible(windowInterface, QStringLiteral("Save"));
    auto *secondary = findAccessible(windowInterface, QStringLiteral("More save options"));
    QVERIFY(primary);
    QVERIFY(secondary);
    QVERIFY(primary != secondary);
    QCOMPARE(primary->role(), QAccessible::Button);
    QCOMPARE(secondary->role(), QAccessible::Button);
    QCOMPARE(primary->childCount(), 0);
    QCOMPARE(secondary->childCount(), 0);
    QCOMPARE(actionableButtonCount(windowInterface), 2);
    QVERIFY(primary->state().focusable);
    QVERIFY(secondary->state().focusable);
    QVERIFY(secondary->state().expandable);
    // Qt Quick exposes expandable/expanded; it does not populate the collapsed bit.
    QVERIFY(!secondary->state().expanded);
    QVERIFY(!secondary->state().checkable);
    QVERIFY(!secondary->state().checked);
    if (auto *container = QAccessible::queryAccessibleInterface(split)) {
        QVERIFY(container->role() != QAccessible::Button);
        QVERIFY(!container->actionInterface()
                || !container->actionInterface()->actionNames().contains(
                        QAccessibleActionInterface::pressAction()));
    }
    auto *primaryActions = primary->actionInterface();
    auto *secondaryActions = secondary->actionInterface();
    QVERIFY(primaryActions);
    QVERIFY(secondaryActions);
    QVERIFY(primaryActions->actionNames().contains(QAccessibleActionInterface::pressAction()));
    QVERIFY(secondaryActions->actionNames().contains(QAccessibleActionInterface::pressAction()));
    primaryActions->doAction(QAccessibleActionInterface::pressAction());
    QTRY_COMPARE(root->property("primaryCount").toInt(), 1);
    QCOMPARE(root->property("actionCount").toInt(), 1);
    QCOMPARE(root->property("secondaryCount").toInt(), 0);
    secondaryActions->doAction(QAccessibleActionInterface::pressAction());
    QTRY_VERIFY(menu->property("opened").toBool());
    QCOMPARE(root->property("secondaryCount").toInt(), 1);
    QCOMPARE(root->property("primaryCount").toInt(), 1);
    QCOMPARE(root->property("actionCount").toInt(), 1);
    QVERIFY(secondary->state().expanded);
    QVERIFY(!secondary->state().checked);
    QVERIFY(QMetaObject::invokeMethod(menu, "close"));
    QTRY_VERIFY(!secondary->state().expanded);
    QVERIFY(!secondary->state().expanded);
    secondaryActions->doAction(QAccessibleActionInterface::pressAction());
    QTRY_VERIFY(menu->property("opened").toBool());
    QTest::keyClick(window, Qt::Key_Escape);
    QTRY_VERIFY(!secondary->state().expanded);
    QCOMPARE(root->property("secondaryCount").toInt(), 2);
    secondaryActions->doAction(QAccessibleActionInterface::pressAction());
    QTRY_VERIFY(menu->property("opened").toBool());
    QVERIFY(QMetaObject::invokeMethod(root.get(), "replaceMenu"));
    QTRY_VERIFY(!menu->property("visible").toBool());
    QTRY_VERIFY(!secondary->state().expanded);
    QVERIFY(!secondary->state().expanded);
    secondaryActions->doAction(QAccessibleActionInterface::pressAction());
    QTRY_VERIFY(replacement->property("opened").toBool());
    QTRY_VERIFY(secondary->state().expanded);
    QVERIFY(split->setProperty("secondaryEnabled", false));
    QTRY_VERIFY(!replacement->property("visible").toBool());
    QTRY_VERIFY(!secondary->state().expanded);
    QVERIFY(secondary->state().disabled);
    secondaryActions->doAction(QAccessibleActionInterface::pressAction());
    QVERIFY(!replacement->property("visible").toBool());
    QCOMPARE(root->property("secondaryCount").toInt(), 4);
    QVERIFY(split->setProperty("primaryEnabled", false));
    QVERIFY(primary->state().disabled);
    primaryActions->doAction(QAccessibleActionInterface::pressAction());
    QCOMPARE(root->property("primaryCount").toInt(), 1);
    QCOMPARE(root->property("actionCount").toInt(), 1);
    QVERIFY(QMetaObject::invokeMethod(root.get(), "iconOnly"));
    QCOMPARE(primary->text(QAccessible::Name), QStringLiteral("Save document"));
}

void FluidAccessibilityTest::splitButtonCustomPopupExposesBoundExpansion()
{
    QAccessible::setActive(true);
    QQmlEngine engine;
    engine.addImportPath(QStringLiteral(FLUID_QML_IMPORT_PATH));
    QQmlComponent component(&engine);
    component.setData(R"(
        import QtQuick
        import QtQuick.Controls as QQC
        import Fluid as MD
        Window {
            width: 640; height: 480; visible: true
            property int secondaryCount: 0
            function openPopup() { popup.open() }
            function closePopup() { popup.close() }
            MD.SplitButton {
                id: split
                objectName: "customSplit"
                text: "Save"
                secondaryText: "Custom save options"
                expanded: popup.visible
                onSecondaryClicked: {
                    ++secondaryCount
                    popup.visible ? popup.close() : popup.open()
                }
            }
            QQC.Popup { id: popup; x: 200; y: 200; width: 100; height: 100 }
        }
    )",
                      QUrl(QStringLiteral("inline:split-button-custom-accessibility.qml")));
    QTRY_VERIFY_WITH_TIMEOUT(!component.isLoading(), 5000);
    QVERIFY2(component.isReady(), qPrintable(component.errorString()));
    QScopedPointer<QObject> root(component.create());
    QVERIFY2(root, qPrintable(component.errorString()));
    QCoreApplication::processEvents();
    auto *split = root->findChild<QObject *>(QStringLiteral("customSplit"));
    auto *secondary = findAccessible(QAccessible::queryAccessibleInterface(root.get()),
                                     QStringLiteral("Custom save options"));
    QVERIFY(split);
    QVERIFY(secondary);
    QVERIFY(secondary->state().expandable);
    QVERIFY(!secondary->state().expanded);
    auto *actions = secondary->actionInterface();
    QVERIFY(actions);
    actions->doAction(QAccessibleActionInterface::pressAction());
    QTRY_VERIFY(secondary->state().expanded);
    QCOMPARE(root->property("secondaryCount").toInt(), 1);
    QVERIFY(QMetaObject::invokeMethod(root.get(), "closePopup"));
    QTRY_VERIFY(!secondary->state().expanded);
    QVERIFY(QMetaObject::invokeMethod(root.get(), "openPopup"));
    QTRY_VERIFY(secondary->state().expanded);
    QVERIFY(QMetaObject::invokeMethod(root.get(), "closePopup"));
    QTRY_VERIFY(!secondary->state().expanded);
    actions->doAction(QAccessibleActionInterface::pressAction());
    QTRY_VERIFY(secondary->state().expanded);
    QCOMPARE(root->property("secondaryCount").toInt(), 2);
    QVERIFY(!secondary->state().checkable);
    QVERIFY(split->setProperty("secondaryEnabled", false));
    QVERIFY(secondary->state().disabled);
    actions->doAction(QAccessibleActionInterface::pressAction());
    QCOMPARE(root->property("secondaryCount").toInt(), 2);
}

void FluidAccessibilityTest::splitButtonRestoresFocusAfterAccessibleMenuActivation_data()
{
    QTest::addColumn<bool>("animated");
    QTest::newRow("animated") << true;
    QTest::newRow("no-exit") << false;
}

void FluidAccessibilityTest::splitButtonRestoresFocusAfterAccessibleMenuActivation()
{
    QFETCH(bool, animated);
    QAccessible::setActive(true);
    QQmlEngine engine;
    engine.addImportPath(QStringLiteral(FLUID_QML_IMPORT_PATH));
    QQmlComponent component(&engine);
    component.setData(R"(
        import QtQuick
        import Fluid as MD
        Window {
            width: 640; height: 480; visible: true
            function disableExit() { menu.exit = null }
            function focusFirst() { menu.itemAt(0).forceActiveFocus(Qt.PopupFocusReason) }
            MD.Button { objectName: "before"; text: "Before"; x: 20; y: 20 }
            MD.SplitButton {
                objectName: "split"; text: "Save"; x: 100; y: 100
                secondaryText: "More save options"
                menu: MD.Menu {
                    id: menu
                    objectName: "menu"
                    MD.Action { text: "Save as" }
                }
            }
            MD.Button { objectName: "after"; text: "After"; x: 500; y: 20 }
        }
    )",
                      QUrl(QStringLiteral("inline:split-button-accessible-focus.qml")));
    QTRY_VERIFY_WITH_TIMEOUT(!component.isLoading(), 5000);
    QVERIFY2(component.isReady(), qPrintable(component.errorString()));
    QScopedPointer<QObject> root(component.create());
    QVERIFY2(root, qPrintable(component.errorString()));
    auto *window = qobject_cast<QQuickWindow *>(root.get());
    auto *before = root->findChild<QQuickItem *>(QStringLiteral("before"));
    auto *after = root->findChild<QQuickItem *>(QStringLiteral("after"));
    auto *split = root->findChild<QObject *>(QStringLiteral("split"));
    auto *menu = root->findChild<QObject *>(QStringLiteral("menu"));
    QVERIFY(window);
    QVERIFY(before);
    QVERIFY(after);
    QVERIFY(split);
    QVERIFY(menu);
    auto *trailing =
            qobject_cast<QQuickItem *>(split->property("trailingButton").value<QObject *>());
    QVERIFY(trailing);
    QCoreApplication::processEvents();
    if (!animated)
        QVERIFY(QMetaObject::invokeMethod(root.get(), "disableExit"));
    auto *secondary = findAccessible(QAccessible::queryAccessibleInterface(window),
                                     QStringLiteral("More save options"));
    QVERIFY(secondary);
    auto *actions = secondary->actionInterface();
    QVERIFY(actions);
    for (const bool moveFocusOutside : { false, true }) {
        before->forceActiveFocus(Qt::TabFocusReason);
        QTRY_VERIFY(before->hasActiveFocus());
        actions->doAction(QAccessibleActionInterface::pressAction());
        QTRY_VERIFY(menu->property("opened").toBool());
        QVERIFY(QMetaObject::invokeMethod(root.get(), "focusFirst"));
        QVERIFY(window->activeFocusItem() != before);
        QVERIFY(window->activeFocusItem() != trailing);
        if (moveFocusOutside) {
            after->forceActiveFocus(Qt::TabFocusReason);
            QTRY_VERIFY(after->hasActiveFocus());
        }
        if (moveFocusOutside)
            QVERIFY(QMetaObject::invokeMethod(menu, "close"));
        else
            actions->doAction(QAccessibleActionInterface::pressAction());
        QTRY_VERIFY(!menu->property("visible").toBool());
        if (moveFocusOutside)
            QTRY_VERIFY(after->hasActiveFocus());
        else
            QTRY_VERIFY(trailing->hasActiveFocus());
    }
}

void FluidAccessibilityTest::segmentedButtonsExposeSelectionAndActivation()
{
    QAccessible::setActive(true);

    QQmlEngine engine;
    engine.addImportPath(QStringLiteral(FLUID_QML_IMPORT_PATH));
    QQmlComponent component(&engine);
    component.setData(R"(
        import QtQuick
        import Fluid as MD

        Window {
            width: 480
            height: 160
            visible: true

            MD.SegmentedButtonGroup {
                objectName: "segments"
                MD.SegmentedButton {
                    objectName: "day"
                    text: "Day"
                }
                MD.SegmentedButton {
                    objectName: "week"
                    icon.name: MD.Symbols.calendarMonth
                    Accessible.name: "Week view"
                }
            }
        }
    )",
                      QUrl(QStringLiteral("inline:segmented-buttons-accessibility.qml")));

    QTRY_VERIFY_WITH_TIMEOUT(!component.isLoading(), 5000);
    QVERIFY2(component.isReady(), qPrintable(component.errorString()));
    QScopedPointer<QObject> root(component.create());
    QVERIFY2(root, qPrintable(component.errorString()));
    QCoreApplication::processEvents();

    auto *group = root->findChild<QObject *>(QStringLiteral("segments"));
    auto *day = root->findChild<QObject *>(QStringLiteral("day"));
    auto *week = root->findChild<QObject *>(QStringLiteral("week"));
    QVERIFY(group);
    QVERIFY(day);
    QVERIFY(week);
    auto *dayInterface = QAccessible::queryAccessibleInterface(day);
    auto *weekInterface = QAccessible::queryAccessibleInterface(week);
    QVERIFY(dayInterface);
    QVERIFY(weekInterface);
    QCOMPARE(dayInterface->role(), QAccessible::RadioButton);
    QCOMPARE(weekInterface->role(), QAccessible::RadioButton);
    QCOMPARE(weekInterface->text(QAccessible::Name), QStringLiteral("Week view"));
    QVERIFY(dayInterface->state().checkable);
    QVERIFY(dayInterface->state().checked);
    QVERIFY(!weekInterface->state().checked);
    QCOMPARE(dayInterface->childCount(), 0);
    QCOMPARE(weekInterface->childCount(), 0);

    auto *actions = weekInterface->actionInterface();
    QVERIFY(actions);
    QVERIFY(actions->actionNames().contains(QAccessibleActionInterface::pressAction()));
    actions->doAction(QAccessibleActionInterface::pressAction());
    QTRY_VERIFY(weekInterface->state().checked);
    QVERIFY(!dayInterface->state().checked);
    actions->doAction(QAccessibleActionInterface::pressAction());
    QVERIFY(weekInterface->state().checked);

    // Resolve the public enum rather than duplicating its integer value.
    const QMetaObject *metaObject = group->metaObject();
    const int enumIndex = metaObject->indexOfEnumerator("SelectionMode");
    QVERIFY(enumIndex >= 0);
    const int multiSelection = metaObject->enumerator(enumIndex).keyToValue("MultiSelection");
    QVERIFY(multiSelection >= 0);
    QVERIFY(group->setProperty("selectionMode", multiSelection));
    QCOMPARE(dayInterface->role(), QAccessible::CheckBox);
    QCOMPARE(weekInterface->role(), QAccessible::CheckBox);
    dayInterface->actionInterface()->doAction(QAccessibleActionInterface::pressAction());
    QVERIFY(dayInterface->state().checked);
    QVERIFY(weekInterface->state().checked);

    QVERIFY(week->setProperty("enabled", false));
    QVERIFY(weekInterface->state().disabled);
    actions->doAction(QAccessibleActionInterface::pressAction());
    QVERIFY(weekInterface->state().checked);
}

void FluidAccessibilityTest::labeledFabInheritsButtonAccessibility()
{
    QAccessible::setActive(true);

    QQmlEngine engine;
    engine.addImportPath(QStringLiteral(FLUID_QML_IMPORT_PATH));
    QQmlComponent component(&engine);
    component.setData(R"(
        import QtQuick
        import Fluid as MD

        Window {
            width: 320
            height: 160
            visible: true

            MD.FAB {
                objectName: "labeledFab"
                text: "Create"
                icon.name: MD.Symbols.add
            }
        }
    )",
                      QUrl(QStringLiteral("inline:labeled-fab-accessibility.qml")));

    QTRY_VERIFY_WITH_TIMEOUT(!component.isLoading(), 5000);
    QVERIFY2(component.isReady(), qPrintable(component.errorString()));

    QScopedPointer<QObject> root(component.create());
    QVERIFY2(root, qPrintable(component.errorString()));
    auto *labeledFab = root->findChild<QObject *>(QStringLiteral("labeledFab"));
    QVERIFY(labeledFab);

    auto *interface = QAccessible::queryAccessibleInterface(labeledFab);
    QVERIFY(interface);
    QCOMPARE(interface->role(), QAccessible::Button);
    QCOMPARE(interface->text(QAccessible::Name), QStringLiteral("Create"));
}

void FluidAccessibilityTest::textFieldIsAnEditableAccessibleNode()
{
    QAccessible::setActive(true);

    QQmlEngine engine;
    engine.addImportPath(QStringLiteral(FLUID_QML_IMPORT_PATH));
    QQmlComponent component(&engine);
    component.setData(R"(
        import QtQuick
        import Fluid as MD

        Window {
            width: 480
            height: 240
            visible: true

            MD.TextField {
                id: passwordField
                objectName: "passwordField"
                width: 320
                label: "Password"
                text: "secret"
                supportingText: "At least eight characters"
                echoMode: TextInput.Password

                trailing: MD.IconButton {
                    objectName: "revealPasswordButton"
                    text: "Reveal password"
                    type: MD.IconButton.Standard
                    icon.name: MD.Symbols.visibility
                }
            }
        }
    )",
                      QUrl(QStringLiteral("inline:textfield-accessibility.qml")));

    QTRY_VERIFY_WITH_TIMEOUT(!component.isLoading(), 5000);
    QVERIFY2(component.isReady(), qPrintable(component.errorString()));

    QScopedPointer<QObject> root(component.create());
    QVERIFY2(root, qPrintable(component.errorString()));
    auto *window = qobject_cast<QQuickWindow *>(root.get());
    QVERIFY(window);
    QCoreApplication::processEvents();

    auto *field = root->findChild<QObject *>(QStringLiteral("passwordField"));
    auto *revealButton = root->findChild<QObject *>(QStringLiteral("revealPasswordButton"));
    QVERIFY(field);
    QVERIFY(revealButton);
    auto *fieldInterface = QAccessible::queryAccessibleInterface(field);
    auto *revealInterface = QAccessible::queryAccessibleInterface(revealButton);
    QVERIFY(fieldInterface);
    QVERIFY(revealInterface);
    QCOMPARE(fieldInterface->role(), QAccessible::EditableText);
    QCOMPARE(fieldInterface->text(QAccessible::Description),
             QStringLiteral("At least eight characters"));
    QVERIFY(fieldInterface->state().focusable);
    QVERIFY(fieldInterface->state().passwordEdit);
    QVERIFY(!fieldInterface->state().readOnly);
    QVERIFY(fieldInterface->textInterface());
    QCOMPARE(fieldInterface->textInterface()->characterCount(), 6);
    QCOMPARE(revealInterface->role(), QAccessible::Button);

    field->setProperty("errorText", QStringLiteral("Enter a longer password"));
    field->setProperty("error", true);
    field->setProperty("readOnly", true);
    QCoreApplication::processEvents();
    QCOMPARE(fieldInterface->text(QAccessible::Description),
             QStringLiteral("Enter a longer password"));
    QVERIFY(fieldInterface->state().readOnly);
}

void FluidAccessibilityTest::rangeSliderHandlesAreRealAccessibleNodes()
{
    QAccessible::setActive(true);

    QQmlEngine engine;
    engine.addImportPath(QStringLiteral(FLUID_QML_IMPORT_PATH));
    QQmlComponent component(&engine);
    component.setData(R"(
        import QtQuick
        import Fluid as MD

        Window {
            width: 640
            height: 360
            visible: true

            MD.AppBar {
                objectName: "appBar"
                width: parent.width
                title: "Library"
                subtitle: "Recently added"
                navigationAction: MD.AppBarAction {
                    text: "Back"
                    icon.name: MD.Symbols.arrowBack
                }
            }

            MD.RangeSlider {
                objectName: "rangeSlider"
                x: 80
                y: 160
                width: 480
                from: 0
                to: 100
                stepSize: 10
                first.value: 20
                second.value: 80
                Accessible.name: "Price range"
            }
        }
    )",
                      QUrl(QStringLiteral("inline:accessibility.qml")));

    QTRY_VERIFY_WITH_TIMEOUT(!component.isLoading(), 5000);
    QVERIFY2(component.isReady(), qPrintable(component.errorString()));

    QScopedPointer<QObject> root(component.create());
    QVERIFY2(root, qPrintable(component.errorString()));
    auto *window = qobject_cast<QQuickWindow *>(root.get());
    QVERIFY(window);
    QCoreApplication::processEvents();

    auto *rangeSlider = root->findChild<QObject *>(QStringLiteral("rangeSlider"));
    auto *firstHandle = root->findChild<QObject *>(QStringLiteral("rangeSliderFirstHandle"));
    auto *secondHandle = root->findChild<QObject *>(QStringLiteral("rangeSliderSecondHandle"));
    QVERIFY(rangeSlider);
    QVERIFY(firstHandle);
    QVERIFY(secondHandle);

    auto *windowInterface = QAccessible::queryAccessibleInterface(window);
    QVERIFY(windowInterface);
    auto *appBarInterface = findAccessible(windowInterface, QStringLiteral("Library"));
    auto *backInterface = findAccessible(windowInterface, QStringLiteral("Back"));
    auto *firstInterface = findAccessible(windowInterface, QStringLiteral("Price range minimum"));
    auto *secondInterface = findAccessible(windowInterface, QStringLiteral("Price range maximum"));
    QVERIFY(appBarInterface);
    QVERIFY(backInterface);
    QVERIFY(firstInterface);
    QVERIFY(secondInterface);
    QCOMPARE(appBarInterface->role(), QAccessible::ToolBar);
    QCOMPARE(backInterface->role(), QAccessible::Button);
    QCOMPARE(firstInterface->role(), QAccessible::Slider);
    QCOMPARE(secondInterface->role(), QAccessible::Slider);
    QVERIFY(!findAccessible(windowInterface, QStringLiteral("Recently added")));

    auto *firstValue = firstInterface->valueInterface();
    auto *secondValue = secondInterface->valueInterface();
    QVERIFY(firstValue);
    QVERIFY(secondValue);
    QCOMPARE(firstValue->currentValue().toDouble(), 20.0);
    QCOMPARE(firstValue->minimumValue().toDouble(), 0.0);
    QCOMPARE(firstValue->maximumValue().toDouble(), 80.0);
    QCOMPARE(secondValue->currentValue().toDouble(), 80.0);
    QCOMPARE(secondValue->minimumValue().toDouble(), 20.0);
    QCOMPARE(secondValue->maximumValue().toDouble(), 100.0);

    auto *firstActions = firstInterface->actionInterface();
    auto *secondActions = secondInterface->actionInterface();
    QVERIFY(firstActions);
    QVERIFY(secondActions);
    QVERIFY(firstActions->actionNames().contains(QAccessibleActionInterface::increaseAction()));
    QVERIFY(secondActions->actionNames().contains(QAccessibleActionInterface::decreaseAction()));

    firstActions->doAction(QAccessibleActionInterface::increaseAction());
    secondActions->doAction(QAccessibleActionInterface::decreaseAction());
    QTRY_COMPARE(firstHandle->property("value").toDouble(), 30.0);
    QTRY_COMPARE(secondHandle->property("value").toDouble(), 70.0);
}

QTEST_MAIN(FluidAccessibilityTest)

#include "accessibility.moc"
