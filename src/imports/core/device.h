/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Michael Spencer <sonrisesoftware@gmail.com>
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

#include <cmath>
#include <QQmlEngine>
#include <QGuiApplication>
#include <QScreen>
#include <QTouchDevice>

class Device : public QObject
{
    Q_OBJECT

    Q_PROPERTY(FormFactor formFactor READ formFactor NOTIFY geometryChanged)
    Q_PROPERTY(QString name READ name NOTIFY geometryChanged)
    Q_PROPERTY(QString iconName READ iconName NOTIFY geometryChanged)

    Q_PROPERTY(bool isPortrait READ isPortrait NOTIFY geometryChanged)
    Q_PROPERTY(bool isMobile READ isMobile CONSTANT)
    Q_PROPERTY(bool hasTouchScreen READ hasTouchScreen CONSTANT)
    Q_PROPERTY(bool hoverEnabled READ hoverEnabled CONSTANT)

    Q_PROPERTY(int gridUnit READ gridUnit NOTIFY geometryChanged)

public:
    enum FormFactor { Phone, Phablet, Tablet, Computer, TV, Unknown };
    Q_ENUM(FormFactor)

    Device(QObject *parent = nullptr);

    FormFactor formFactor() const;
    QString name() const;
    QString iconName() const;

    bool isPortrait() const;
    bool hasTouchScreen() const;
    bool isMobile() const;
    bool hoverEnabled() const;

    int gridUnit() const;

Q_SIGNALS:
    void geometryChanged();

private Q_SLOTS:
    void screenChanged();

private:
    float calculateDiagonal() const;

    QScreen *m_screen;
};
