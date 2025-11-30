/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2025 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

#pragma once

#include <QObject>
#include <QQmlEngine>

namespace Fluid {

/*!
    \brief Material Design 3 design tokens.

    Provides access to Material Design 3 design tokens including
    typography, shape, spacing, elevation, and motion tokens that can be used from QML.

    \code{.qml}
    import QtQuick
    import Fluid as MD

    Rectangle {
        radius: MD.Tokens.cornerRadiusMedium

        Text {
            font.pixelSize: MD.Tokens.fontSizeTitleLarge
        }
    }
    \endcode

    For more information see the
    <a href="https://m3.material.io/styles">Material Design 3 guidelines</a>.
*/
class Tokens : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

    // Shape tokens - Corner radius
    Q_PROPERTY(qreal cornerRadiusNone READ cornerRadiusNone CONSTANT FINAL)
    Q_PROPERTY(qreal cornerRadiusExtraSmall READ cornerRadiusExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal cornerRadiusSmall READ cornerRadiusSmall CONSTANT FINAL)
    Q_PROPERTY(qreal cornerRadiusMedium READ cornerRadiusMedium CONSTANT FINAL)
    Q_PROPERTY(qreal cornerRadiusLarge READ cornerRadiusLarge CONSTANT FINAL)
    Q_PROPERTY(qreal cornerRadiusExtraLarge READ cornerRadiusExtraLarge CONSTANT FINAL)
    Q_PROPERTY(qreal cornerRadiusFull READ cornerRadiusFull CONSTANT FINAL)

    // Typography tokens - Font sizes
    Q_PROPERTY(int fontSizeDisplayLarge READ fontSizeDisplayLarge CONSTANT FINAL)
    Q_PROPERTY(int fontSizeDisplayMedium READ fontSizeDisplayMedium CONSTANT FINAL)
    Q_PROPERTY(int fontSizeDisplaySmall READ fontSizeDisplaySmall CONSTANT FINAL)
    Q_PROPERTY(int fontSizeHeadlineLarge READ fontSizeHeadlineLarge CONSTANT FINAL)
    Q_PROPERTY(int fontSizeHeadlineMedium READ fontSizeHeadlineMedium CONSTANT FINAL)
    Q_PROPERTY(int fontSizeHeadlineSmall READ fontSizeHeadlineSmall CONSTANT FINAL)
    Q_PROPERTY(int fontSizeTitleLarge READ fontSizeTitleLarge CONSTANT FINAL)
    Q_PROPERTY(int fontSizeTitleMedium READ fontSizeTitleMedium CONSTANT FINAL)
    Q_PROPERTY(int fontSizeTitleSmall READ fontSizeTitleSmall CONSTANT FINAL)
    Q_PROPERTY(int fontSizeBodyLarge READ fontSizeBodyLarge CONSTANT FINAL)
    Q_PROPERTY(int fontSizeBodyMedium READ fontSizeBodyMedium CONSTANT FINAL)
    Q_PROPERTY(int fontSizeBodySmall READ fontSizeBodySmall CONSTANT FINAL)
    Q_PROPERTY(int fontSizeLabelLarge READ fontSizeLabelLarge CONSTANT FINAL)
    Q_PROPERTY(int fontSizeLabelMedium READ fontSizeLabelMedium CONSTANT FINAL)
    Q_PROPERTY(int fontSizeLabelSmall READ fontSizeLabelSmall CONSTANT FINAL)

    // Spacing tokens
    Q_PROPERTY(int spacingExtraSmall READ spacingExtraSmall CONSTANT FINAL)
    Q_PROPERTY(int spacingSmall READ spacingSmall CONSTANT FINAL)
    Q_PROPERTY(int spacingMedium READ spacingMedium CONSTANT FINAL)
    Q_PROPERTY(int spacingLarge READ spacingLarge CONSTANT FINAL)
    Q_PROPERTY(int spacingExtraLarge READ spacingExtraLarge CONSTANT FINAL)

    // Elevation tokens
    Q_PROPERTY(int elevationLevel0 READ elevationLevel0 CONSTANT FINAL)
    Q_PROPERTY(int elevationLevel1 READ elevationLevel1 CONSTANT FINAL)
    Q_PROPERTY(int elevationLevel2 READ elevationLevel2 CONSTANT FINAL)
    Q_PROPERTY(int elevationLevel3 READ elevationLevel3 CONSTANT FINAL)
    Q_PROPERTY(int elevationLevel4 READ elevationLevel4 CONSTANT FINAL)
    Q_PROPERTY(int elevationLevel5 READ elevationLevel5 CONSTANT FINAL)

    // Motion tokens - Duration
    Q_PROPERTY(int durationShort1 READ durationShort1 CONSTANT FINAL)
    Q_PROPERTY(int durationShort2 READ durationShort2 CONSTANT FINAL)
    Q_PROPERTY(int durationShort3 READ durationShort3 CONSTANT FINAL)
    Q_PROPERTY(int durationShort4 READ durationShort4 CONSTANT FINAL)
    Q_PROPERTY(int durationMedium1 READ durationMedium1 CONSTANT FINAL)
    Q_PROPERTY(int durationMedium2 READ durationMedium2 CONSTANT FINAL)
    Q_PROPERTY(int durationMedium3 READ durationMedium3 CONSTANT FINAL)
    Q_PROPERTY(int durationMedium4 READ durationMedium4 CONSTANT FINAL)
    Q_PROPERTY(int durationLong1 READ durationLong1 CONSTANT FINAL)
    Q_PROPERTY(int durationLong2 READ durationLong2 CONSTANT FINAL)
    Q_PROPERTY(int durationLong3 READ durationLong3 CONSTANT FINAL)
    Q_PROPERTY(int durationLong4 READ durationLong4 CONSTANT FINAL)

public:
    explicit Tokens(QObject *parent = nullptr);

    // Shape tokens - Corner radius
    qreal cornerRadiusNone() const;
    qreal cornerRadiusExtraSmall() const;
    qreal cornerRadiusSmall() const;
    qreal cornerRadiusMedium() const;
    qreal cornerRadiusLarge() const;
    qreal cornerRadiusExtraLarge() const;
    qreal cornerRadiusFull() const;

    // Typography tokens - Font sizes
    int fontSizeDisplayLarge() const;
    int fontSizeDisplayMedium() const;
    int fontSizeDisplaySmall() const;
    int fontSizeHeadlineLarge() const;
    int fontSizeHeadlineMedium() const;
    int fontSizeHeadlineSmall() const;
    int fontSizeTitleLarge() const;
    int fontSizeTitleMedium() const;
    int fontSizeTitleSmall() const;
    int fontSizeBodyLarge() const;
    int fontSizeBodyMedium() const;
    int fontSizeBodySmall() const;
    int fontSizeLabelLarge() const;
    int fontSizeLabelMedium() const;
    int fontSizeLabelSmall() const;

    // Spacing tokens
    int spacingExtraSmall() const;
    int spacingSmall() const;
    int spacingMedium() const;
    int spacingLarge() const;
    int spacingExtraLarge() const;

    // Elevation tokens
    int elevationLevel0() const;
    int elevationLevel1() const;
    int elevationLevel2() const;
    int elevationLevel3() const;
    int elevationLevel4() const;
    int elevationLevel5() const;

    // Motion tokens - Duration
    int durationShort1() const;
    int durationShort2() const;
    int durationShort3() const;
    int durationShort4() const;
    int durationMedium1() const;
    int durationMedium2() const;
    int durationMedium3() const;
    int durationMedium4() const;
    int durationLong1() const;
    int durationLong2() const;
    int durationLong3() const;
    int durationLong4() const;

    static Tokens *create(QQmlEngine *engine, QJSEngine *jsEngine);
};

} // namespace Fluid