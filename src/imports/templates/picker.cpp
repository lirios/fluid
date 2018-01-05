/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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

QQuickItem *Picker::header() const
{
    return m_header;
}

void Picker::setHeader(QQuickItem *item)
{
    if (m_header == item)
        return;

    if (m_header)
        m_header->setParentItem(nullptr);

    m_header = item;
    m_header->setParentItem(this);
    if (isComponentComplete())
        updateLayout();
    Q_EMIT headerChanged();
}

QQuickItem *Picker::selector() const
{
    return m_selector;
}

void Picker::setSelector(QQuickItem *item)
{
    if (m_selector == item)
        return;

    if (m_selector)
        m_selector->setParentItem(nullptr);

    m_selector = item;
    m_selector->setParentItem(this);
    if (isComponentComplete())
        updateLayout();
    Q_EMIT selectorChanged();
}

QQuickItem *Picker::footer() const
{
    return m_footer;
}

void Picker::setFooter(QQuickItem *item)
{
    if (m_footer == item)
        return;

    if (m_footer)
        m_footer->setParentItem(nullptr);

    m_footer = item;
    m_footer->setParentItem(this);
    if (isComponentComplete())
        updateLayout();
    Q_EMIT footerChanged();
}

void Picker::componentComplete()
{
    updateLayout();
    QQuickItem::componentComplete();
}

void Picker::geometryChanged(const QRectF &newGeometry, const QRectF &oldGeometry)
{
    updateLayout();
    QQuickItem::geometryChanged(newGeometry, oldGeometry);
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

void Picker::updateLayout()
{
    const qreal headerHeight = 96;
    const qreal footerHeight = m_footer ? 50 : 0;

    if (m_header) {
        if (m_orientation == Landscape) {
            m_header->setX(0);
            m_header->setY(0);
            m_header->setWidth(width() / 3);
            m_header->setHeight(height());
        } else {
            m_header->setX(0);
            m_header->setY(0);
            m_header->setWidth(width());
            m_header->setHeight(headerHeight);
        }
        m_header->setZ(1);
    }

    if (m_selector) {
        const qreal margin = 5;

        if (m_orientation == Landscape) {
            m_selector->setX((width() / 3) + margin);
            m_selector->setY(0);
            m_selector->setWidth(width() - (width() / 3) - (margin * 2));
            m_selector->setHeight(height() - footerHeight);
        } else {
            m_selector->setX(margin);
            m_selector->setY(headerHeight);
            m_selector->setWidth(width() - (margin * 2));
            m_selector->setHeight(height() - headerHeight - footerHeight);
        }
        m_selector->setZ(1);
    }

    if (m_footer) {
        const qreal margin = 10;

        if (m_orientation == Landscape) {
            m_footer->setX(margin + (width() / 3));
            m_footer->setY(height() - footerHeight);
            m_footer->setWidth(((width() / 3) * 2) - (margin * 2));
            m_footer->setHeight(footerHeight);
        } else {
            m_footer->setX(margin);
            m_footer->setY(height() - footerHeight);
            m_footer->setWidth(width() - (margin * 2));
            m_footer->setHeight(footerHeight);
        }
        m_footer->setZ(1);
    };
}
