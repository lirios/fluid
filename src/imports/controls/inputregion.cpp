// SPDX-FileCopyrightText: 2022 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
//
// SPDX-License-Identifier: MPL-2.0

#include <QLoggingCategory>

#include "inputregion.h"

Q_DECLARE_LOGGING_CATEGORY(gLcInputRegion)
Q_LOGGING_CATEGORY(gLcInputRegion, "fluid.inputregion")

/*
 * InputArea
 */

InputArea::InputArea(QObject *parent)
    : QObject(parent)
{
}

InputArea::~InputArea()
{
    if (m_region)
        m_region->unregisterArea(this);
}

InputRegion *InputArea::region() const
{
    return m_region;
}

void InputArea::setRegion(InputRegion *region)
{
    if (m_initialized) {
        qCWarning(gLcInputRegion, "Unable to change InputArea::region after initialization");
        return;
    }

    if (m_region == region)
        return;

    m_region = region;
    Q_EMIT regionChanged(region);
}

bool InputArea::isEnabled() const
{
    return m_enabled;
}

void InputArea::setEnabled(bool enabled)
{
    if (m_enabled == enabled)
        return;

    m_enabled = enabled;
    Q_EMIT enabledChanged(enabled);
}

qreal InputArea::x() const
{
    return m_x;
}

void InputArea::setX(qreal x)
{
    if (m_x == x)
        return;

    m_x = x;
    emit xChanged(x);
}

qreal InputArea::y() const
{
    return m_y;
}

void InputArea::setY(qreal y)
{
    if (m_y == y)
        return;

    m_y = y;
    emit yChanged(y);
}

qreal InputArea::width() const
{
    return m_width;
}

void InputArea::setWidth(qreal width)
{
    if (m_width == width)
        return;

    m_width = width;
    emit widthChanged(width);
}

qreal InputArea::height() const
{
    return m_height;
}

void InputArea::setHeight(qreal height)
{
    if (m_height == height)
        return;

    m_height = height;
    emit heightChanged(height);
}

QRectF InputArea::rect() const
{
    return QRectF(m_x, m_y, m_width, m_height);
}

void InputArea::componentComplete()
{
    if (m_initialized)
        return;

    m_initialized = true;

    // Register this area
    if (m_region)
        m_region->registerArea(this);
}

/*
 * InputRegion
 */

InputRegion::InputRegion(QObject *parent)
    : QObject(parent)
{
}

bool InputRegion::isEnabled() const
{
    return m_enabled;
}

void InputRegion::setEnabled(bool enabled)
{
    if (m_enabled == enabled)
        return;

    m_enabled = enabled;
    Q_EMIT enabledChanged(enabled);

    setInputRegion();
}

QWindow *InputRegion::window() const
{
    return m_window;
}

void InputRegion::setWindow(QWindow *window)
{
    if (m_initialized) {
        qCWarning(gLcInputRegion, "Unable to change InputRegion::window after initialization");
        return;
    }

    if (m_window == window)
        return;

    m_window = window;
    Q_EMIT windowChanged(m_window);
}

QQmlListProperty<InputArea> InputRegion::areas()
{
    return {
        this, this,
        &InputRegion::areasCount,
                &InputRegion::areaAt
    };
}

void InputRegion::registerArea(InputArea *area)
{
    if (!m_areas.contains(area)) {
        connect(area, &InputArea::enabledChanged, this, &InputRegion::setInputRegion);
        connect(area, &InputArea::xChanged, this, &InputRegion::setInputRegion);
        connect(area, &InputArea::yChanged, this, &InputRegion::setInputRegion);
        connect(area, &InputArea::widthChanged, this, &InputRegion::setInputRegion);
        connect(area, &InputArea::heightChanged, this, &InputRegion::setInputRegion);
        m_areas.append(area);
    }
}

void InputRegion::unregisterArea(InputArea *area)
{
    if (m_areas.removeOne(area)) {
        disconnect(area, &InputArea::enabledChanged, this, &InputRegion::setInputRegion);
        disconnect(area, &InputArea::xChanged, this, &InputRegion::setInputRegion);
        disconnect(area, &InputArea::yChanged, this, &InputRegion::setInputRegion);
        disconnect(area, &InputArea::widthChanged, this, &InputRegion::setInputRegion);
        disconnect(area, &InputArea::heightChanged, this, &InputRegion::setInputRegion);
    }
}

void InputRegion::componentComplete()
{
    if (m_initialized)
        return;

    // Find the window from the parent, if not specified
    if (!m_window) {
        for (auto *p = parent(); p != nullptr; p = p->parent()) {
            if (auto *w = qobject_cast<QWindow *>(p)) {
                setWindow(w);
                break;
            }
        }
    }

    // Initialize
    m_initialized = true;

    // Set initial mask based on properties set when the component is complete
    setInputRegion();
}

int InputRegion::areasCount(QQmlListProperty<InputArea> *list)
{
    return reinterpret_cast<InputRegion *>(list->data)->m_areas.count();
}

InputArea *InputRegion::areaAt(QQmlListProperty<InputArea> *list, int index)
{
    return reinterpret_cast<InputRegion *>(list->data)->m_areas.at(index);
}

void InputRegion::setInputRegion()
{
    if (!m_window)
        return;

    // Calculate input region
    QRegion region;
    if (m_enabled) {
        for (auto *a : qAsConst(m_areas)) {
            if (a->isEnabled()) {
                //qCDebug(gLcInputRegion) << "Input area" << a << "for" << a->rect().toRect();
                region += a->rect().toRect();
            }
        }
    }

    // Don't set the same mask twice
    if (m_window->mask() != region) {
        if (region.isNull())
            qCDebug(gLcInputRegion) << "Unset input region from" << m_window;
        else
            qCDebug(gLcInputRegion) << "Set" << m_window << "input region to:" << region;
        m_window->setMask(region);
    }
}
