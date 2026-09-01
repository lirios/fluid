// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#include <QAccessible>
#include <QAccessibleActionInterface>
#include <QAccessibleValueInterface>
#include <QGuiApplication>
#include <QQmlComponent>
#include <QQmlEngine>
#include <QQuickWindow>
#include <QScopedPointer>
#include <QTest>

namespace {

QAccessibleInterface *findAccessible(QAccessibleInterface *interface,
                                     const QString &name)
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

} // namespace

class FluidAccessibilityTest : public QObject
{
    Q_OBJECT

private slots:
    void rangeSliderHandlesAreRealAccessibleNodes();
};

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
                    icon.name: "arrow_back"
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
    )", QUrl(QStringLiteral("inline:accessibility.qml")));

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
