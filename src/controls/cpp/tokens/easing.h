// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QEasingCurve>
#include <QQmlEngine>

namespace Fluid {

struct Easing
{
    Q_GADGET
    QML_ANONYMOUS
    Q_PROPERTY(QEasingCurve emphasized READ emphasized CONSTANT FINAL)
    Q_PROPERTY(QEasingCurve emphasizedAccelerate READ emphasizedAccelerate CONSTANT FINAL)
    Q_PROPERTY(QEasingCurve emphasizedDecelerate READ emphasizedDecelerate CONSTANT FINAL)
    Q_PROPERTY(QEasingCurve standard READ standard CONSTANT FINAL)
    Q_PROPERTY(QEasingCurve standardAccelerate READ standardAccelerate CONSTANT FINAL)
    Q_PROPERTY(QEasingCurve standardDecelerate READ standardDecelerate CONSTANT FINAL)
    Q_PROPERTY(QEasingCurve legacy READ legacy CONSTANT FINAL)
    Q_PROPERTY(QEasingCurve legacyAccelerate READ legacyAccelerate CONSTANT FINAL)
    Q_PROPERTY(QEasingCurve legacyDecelerate READ legacyDecelerate CONSTANT FINAL)
    Q_PROPERTY(QEasingCurve linear READ linear CONSTANT FINAL)
public:
    QEasingCurve emphasized() const;
    QEasingCurve emphasizedAccelerate() const;
    QEasingCurve emphasizedDecelerate() const;
    QEasingCurve standard() const;
    QEasingCurve standardAccelerate() const;
    QEasingCurve standardDecelerate() const;
    QEasingCurve legacy() const;
    QEasingCurve legacyAccelerate() const;
    QEasingCurve legacyDecelerate() const;
    QEasingCurve linear() const;
};

struct SpringValue
{
    Q_GADGET
    QML_ANONYMOUS
    Q_PROPERTY(QEasingCurve easing MEMBER easing CONSTANT FINAL)
    Q_PROPERTY(qreal duration MEMBER duration CONSTANT FINAL)
public:
    QEasingCurve easing;
    qreal duration = 100;
};

struct Spring
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(SpringValue standardFastSpatial READ standardFastSpatial CONSTANT FINAL)
    Q_PROPERTY(SpringValue standardDefaultSpatial READ standardDefaultSpatial CONSTANT FINAL)
    Q_PROPERTY(SpringValue standardSlowSpatial READ standardSlowSpatial CONSTANT FINAL)
    Q_PROPERTY(SpringValue standardFastEffects READ standardFastEffects CONSTANT FINAL)
    Q_PROPERTY(SpringValue standardDefaultEffects READ standardDefaultEffects CONSTANT FINAL)
    Q_PROPERTY(SpringValue standardSlowEffects READ standardSlowEffects CONSTANT FINAL)

    Q_PROPERTY(SpringValue expressiveFastSpatial READ expressiveFastSpatial CONSTANT FINAL)
    Q_PROPERTY(SpringValue expressiveDefaultSpatial READ expressiveDefaultSpatial CONSTANT FINAL)
    Q_PROPERTY(SpringValue expressiveSlowSpatial READ expressiveSlowSpatial CONSTANT FINAL)
    Q_PROPERTY(SpringValue expressiveFastEffects READ expressiveFastEffects CONSTANT FINAL)
    Q_PROPERTY(SpringValue expressiveDefaultEffects READ expressiveDefaultEffects CONSTANT FINAL)
    Q_PROPERTY(SpringValue expressiveSlowEffects READ expressiveSlowEffects CONSTANT FINAL)
public:
    SpringValue standardFastSpatial() const;
    SpringValue standardDefaultSpatial() const;
    SpringValue standardSlowSpatial() const;
    SpringValue standardFastEffects() const;
    SpringValue standardDefaultEffects() const;
    SpringValue standardSlowEffects() const;

    SpringValue expressiveFastSpatial() const;
    SpringValue expressiveDefaultSpatial() const;
    SpringValue expressiveSlowSpatial() const;
    SpringValue expressiveFastEffects() const;
    SpringValue expressiveDefaultEffects() const;
    SpringValue expressiveSlowEffects() const;
};

} // namespace Fluid
