/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

#ifndef PICKER_H
#define PICKER_H

#include <QLocale>
#include <QQuickItem>

class Picker : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QLocale locale READ locale WRITE setLocale NOTIFY localeChanged FINAL)
    Q_PROPERTY(Orientation orientation READ orientation WRITE setOrientation RESET resetOrientation NOTIFY orientationChanged FINAL)
    Q_PROPERTY(QQuickItem *background READ background WRITE setBackground NOTIFY backgroundChanged FINAL)
    Q_DISABLE_COPY(Picker)
public:
    enum Orientation {
        Landscape,
        Portrait
    };
    Q_ENUM(Orientation)

    explicit Picker(QQuickItem *parent = nullptr);

    QLocale locale() const;
    void setLocale(const QLocale &locale);

    Orientation orientation() const;
    void setOrientation(Orientation orientation);
    void resetOrientation();

    QQuickItem *background() const;
    void setBackground(QQuickItem *item);

Q_SIGNALS:
    void localeChanged();
    void orientationChanged();
    void backgroundChanged();

private:
    QLocale m_locale;
    bool m_hasOrientation = false;
    Orientation m_orientation = Landscape;
    QQuickItem *m_background = nullptr;

    bool updateOrientation();
};

#endif // PICKER_H
