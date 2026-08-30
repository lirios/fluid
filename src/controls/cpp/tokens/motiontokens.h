// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtQml/qqmlregistration.h>

namespace Fluid {

struct MotionEasingValue
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal x1 MEMBER x1 CONSTANT FINAL)
    Q_PROPERTY(qreal y1 MEMBER y1 CONSTANT FINAL)
    Q_PROPERTY(qreal x2 MEMBER x2 CONSTANT FINAL)
    Q_PROPERTY(qreal y2 MEMBER y2 CONSTANT FINAL)

public:
    constexpr MotionEasingValue(qreal x1 = 0.0, qreal y1 = 0.0, qreal x2 = 1.0, qreal y2 = 1.0)
        : x1(x1)
        , y1(y1)
        , x2(x2)
        , y2(y2)
    {
    }

    qreal x1;
    qreal y1;
    qreal x2;
    qreal y2;
};

/*!
    \brief Material Design 3 duration tokens.

    For more information see the
    <a
    href="https://m3.material.io/styles/motion/easing-and-duration/tokens-specs#2c0659e2-a2c8-4d7b-8964-5b8dce012f7c">Material
    Design 3 motion guidelines</a>.
*/
struct MotionDurationTokens
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal extraLong1 READ extraLong1 CONSTANT FINAL)
    Q_PROPERTY(qreal extraLong2 READ extraLong2 CONSTANT FINAL)
    Q_PROPERTY(qreal extraLong3 READ extraLong3 CONSTANT FINAL)
    Q_PROPERTY(qreal extraLong4 READ extraLong4 CONSTANT FINAL)
    Q_PROPERTY(qreal long1 READ long1 CONSTANT FINAL)
    Q_PROPERTY(qreal long2 READ long2 CONSTANT FINAL)
    Q_PROPERTY(qreal long3 READ long3 CONSTANT FINAL)
    Q_PROPERTY(qreal long4 READ long4 CONSTANT FINAL)
    Q_PROPERTY(qreal medium1 READ medium1 CONSTANT FINAL)
    Q_PROPERTY(qreal medium2 READ medium2 CONSTANT FINAL)
    Q_PROPERTY(qreal medium3 READ medium3 CONSTANT FINAL)
    Q_PROPERTY(qreal medium4 READ medium4 CONSTANT FINAL)
    Q_PROPERTY(qreal short1 READ short1 CONSTANT FINAL)
    Q_PROPERTY(qreal short2 READ short2 CONSTANT FINAL)
    Q_PROPERTY(qreal short3 READ short3 CONSTANT FINAL)
    Q_PROPERTY(qreal short4 READ short4 CONSTANT FINAL)

public:
    constexpr qreal extraLong1() const
    {
        return 700.0;
    }
    constexpr qreal extraLong2() const
    {
        return 800.0;
    }
    constexpr qreal extraLong3() const
    {
        return 900.0;
    }
    constexpr qreal extraLong4() const
    {
        return 1000.0;
    }
    constexpr qreal long1() const
    {
        return 450.0;
    }
    constexpr qreal long2() const
    {
        return 500.0;
    }
    constexpr qreal long3() const
    {
        return 550.0;
    }
    constexpr qreal long4() const
    {
        return 600.0;
    }
    constexpr qreal medium1() const
    {
        return 250.0;
    }
    constexpr qreal medium2() const
    {
        return 300.0;
    }
    constexpr qreal medium3() const
    {
        return 350.0;
    }
    constexpr qreal medium4() const
    {
        return 400.0;
    }
    constexpr qreal short1() const
    {
        return 50.0;
    }
    constexpr qreal short2() const
    {
        return 100.0;
    }
    constexpr qreal short3() const
    {
        return 150.0;
    }
    constexpr qreal short4() const
    {
        return 200.0;
    }
};

/*!
    \brief Material Design 3 cubic Bezier easing tokens.

    For more information see the
    <a
    href="https://m3.material.io/styles/motion/easing-and-duration/tokens-specs#2c0659e2-a2c8-4d7b-8964-5b8dce012f7c">Material
    Design 3 motion guidelines</a>.
*/
struct MotionEasingTokens
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(MotionEasingValue emphasized READ emphasized CONSTANT FINAL)
    Q_PROPERTY(MotionEasingValue emphasizedAccelerate READ emphasizedAccelerate CONSTANT FINAL)
    Q_PROPERTY(MotionEasingValue emphasizedDecelerate READ emphasizedDecelerate CONSTANT FINAL)
    Q_PROPERTY(MotionEasingValue legacy READ legacy CONSTANT FINAL)
    Q_PROPERTY(MotionEasingValue legacyAccelerate READ legacyAccelerate CONSTANT FINAL)
    Q_PROPERTY(MotionEasingValue legacyDecelerate READ legacyDecelerate CONSTANT FINAL)
    Q_PROPERTY(MotionEasingValue linear READ linear CONSTANT FINAL)
    Q_PROPERTY(MotionEasingValue standard READ standard CONSTANT FINAL)
    Q_PROPERTY(MotionEasingValue standardAccelerate READ standardAccelerate CONSTANT FINAL)
    Q_PROPERTY(MotionEasingValue standardDecelerate READ standardDecelerate CONSTANT FINAL)

public:
    constexpr MotionEasingValue emphasized() const
    {
        return { 0.2, 0.0, 0.0, 1.0 };
    }
    constexpr MotionEasingValue emphasizedAccelerate() const
    {
        return { 0.3, 0.0, 0.8, 0.15 };
    }
    constexpr MotionEasingValue emphasizedDecelerate() const
    {
        return { 0.05, 0.7, 0.1, 1.0 };
    }
    constexpr MotionEasingValue legacy() const
    {
        return { 0.4, 0.0, 0.2, 1.0 };
    }
    constexpr MotionEasingValue legacyAccelerate() const
    {
        return { 0.4, 0.0, 1.0, 1.0 };
    }
    constexpr MotionEasingValue legacyDecelerate() const
    {
        return { 0.0, 0.0, 0.2, 1.0 };
    }
    constexpr MotionEasingValue linear() const
    {
        return { 0.0, 0.0, 1.0, 1.0 };
    }
    constexpr MotionEasingValue standard() const
    {
        return { 0.2, 0.0, 0.0, 1.0 };
    }
    constexpr MotionEasingValue standardAccelerate() const
    {
        return { 0.3, 0.0, 1.0, 1.0 };
    }
    constexpr MotionEasingValue standardDecelerate() const
    {
        return { 0.0, 0.0, 0.0, 1.0 };
    }
};

struct MotionSpringValue
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal damping MEMBER damping CONSTANT FINAL)
    Q_PROPERTY(qreal stiffness MEMBER stiffness CONSTANT FINAL)

public:
    constexpr MotionSpringValue(qreal damping = 1.0, qreal stiffness = 0.0)
        : damping(damping)
        , stiffness(stiffness)
    {
    }

    qreal damping;
    qreal stiffness;
};

/*!
    \brief Material Design 3 standard and expressive spring tokens.

    For more information see the
    <a
    href="https://m3.material.io/styles/motion/easing-and-duration/tokens-specs#2c0659e2-a2c8-4d7b-8964-5b8dce012f7c">Material
    Design 3 motion guidelines</a>.
*/
struct MotionSpringTokens
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(MotionSpringValue standardDefaultSpatial READ standardDefaultSpatial CONSTANT FINAL)
    Q_PROPERTY(MotionSpringValue standardFastSpatial READ standardFastSpatial CONSTANT FINAL)
    Q_PROPERTY(MotionSpringValue standardSlowSpatial READ standardSlowSpatial CONSTANT FINAL)
    Q_PROPERTY(MotionSpringValue standardDefaultEffects READ standardDefaultEffects CONSTANT FINAL)
    Q_PROPERTY(MotionSpringValue standardFastEffects READ standardFastEffects CONSTANT FINAL)
    Q_PROPERTY(MotionSpringValue standardSlowEffects READ standardSlowEffects CONSTANT FINAL)
    Q_PROPERTY(
            MotionSpringValue expressiveDefaultSpatial READ expressiveDefaultSpatial CONSTANT FINAL)
    Q_PROPERTY(MotionSpringValue expressiveFastSpatial READ expressiveFastSpatial CONSTANT FINAL)
    Q_PROPERTY(MotionSpringValue expressiveSlowSpatial READ expressiveSlowSpatial CONSTANT FINAL)
    Q_PROPERTY(
            MotionSpringValue expressiveDefaultEffects READ expressiveDefaultEffects CONSTANT FINAL)
    Q_PROPERTY(MotionSpringValue expressiveFastEffects READ expressiveFastEffects CONSTANT FINAL)
    Q_PROPERTY(MotionSpringValue expressiveSlowEffects READ expressiveSlowEffects CONSTANT FINAL)

public:
    constexpr MotionSpringValue standardDefaultSpatial() const
    {
        return { 0.9, 700.0 };
    }
    constexpr MotionSpringValue standardFastSpatial() const
    {
        return { 0.9, 1400.0 };
    }
    constexpr MotionSpringValue standardSlowSpatial() const
    {
        return { 0.9, 300.0 };
    }
    constexpr MotionSpringValue standardDefaultEffects() const
    {
        return { 1.0, 1600.0 };
    }
    constexpr MotionSpringValue standardFastEffects() const
    {
        return { 1.0, 3800.0 };
    }
    constexpr MotionSpringValue standardSlowEffects() const
    {
        return { 1.0, 800.0 };
    }
    constexpr MotionSpringValue expressiveDefaultSpatial() const
    {
        return { 0.8, 380.0 };
    }
    constexpr MotionSpringValue expressiveFastSpatial() const
    {
        return { 0.6, 800.0 };
    }
    constexpr MotionSpringValue expressiveSlowSpatial() const
    {
        return { 0.8, 200.0 };
    }
    constexpr MotionSpringValue expressiveDefaultEffects() const
    {
        return { 1.0, 1600.0 };
    }
    constexpr MotionSpringValue expressiveFastEffects() const
    {
        return { 1.0, 3800.0 };
    }
    constexpr MotionSpringValue expressiveSlowEffects() const
    {
        return { 1.0, 800.0 };
    }
};

/*!
    \brief Material Design 3 system motion tokens.

    For more information see the
    <a
    href="https://m3.material.io/styles/motion/easing-and-duration/tokens-specs#2c0659e2-a2c8-4d7b-8964-5b8dce012f7c">Material
    Design 3 motion guidelines</a>.
*/
struct MotionTokens
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(MotionDurationTokens duration READ duration CONSTANT FINAL)
    Q_PROPERTY(MotionEasingTokens easing READ easing CONSTANT FINAL)
    Q_PROPERTY(MotionSpringTokens spring READ spring CONSTANT FINAL)

public:
    constexpr MotionDurationTokens duration() const
    {
        return { };
    }
    constexpr MotionEasingTokens easing() const
    {
        return { };
    }
    constexpr MotionSpringTokens spring() const
    {
        return { };
    }
};

} // namespace Fluid
