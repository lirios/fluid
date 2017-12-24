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

#include <QQuickWindow>
#include <QScreen>

#include "picker.h"

Picker::Picker(QQuickItem *parent)
    : QQuickItem(parent)
{
    connect(this, &QQuickItem::windowChanged, this, [&] {
        if (!m_hasOrientation)
            updateOrientation();
    });
}

QLocale Picker::locale() const
{
    return m_locale;
}

void Picker::setLocale(const QLocale &locale)
{
    if (m_locale == locale)
        return;

    m_locale = locale;
    Q_EMIT localeChanged();
}

Picker::Orientation Picker::orientation() const
{
    return m_orientation;
}

void Picker::setOrientation(Picker::Orientation orientation)
{
    if (m_orientation == orientation)
        return;

    m_orientation = orientation;
    m_hasOrientation = true;
    Q_EMIT orientationChanged();
}

void Picker::resetOrientation()
{
    if (!updateOrientation())
        setOrientation(Picker::Landscape);
}

QQuickItem *Picker::background() const
{
    return m_background;
}

void Picker::setBackground(QQuickItem *item)
{
    if (m_background == item)
        return;

    if (m_background)
        m_background->setParentItem(nullptr);

    m_background = item;
    m_background->setParentItem(this);
    Q_EMIT backgroundChanged();
}

bool Picker::updateOrientation()
{
    if (!window())
        return false;

    auto screen = window()->screen();
    if (!screen)
        return false;

    auto screenOrientation = screen->primaryOrientation();
    if (screenOrientation == Qt::LandscapeOrientation)
        setOrientation(Landscape);
    else if (screenOrientation == Qt::PortraitOrientation)
        setOrientation(Portrait);

    return true;
}
