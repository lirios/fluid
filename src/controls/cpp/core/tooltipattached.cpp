// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#include <cstring>

#include <QtCore/qmetaobject.h>
#include <QtCore/qvariant.h>
#include <QtQml/qqmlcomponent.h>
#include <QtQml/qqmlengine.h>
#include <QtQml/qqmlinfo.h>
#include <QtQuick/qquickitem.h>

#include "tooltipattached.h"

namespace Fluid {

// The public-Qt attached-provider and per-engine manager design follows QmlMaterial:
// https://github.com/hypengw/QmlMaterial/blob/main/src/control/tool_tip.cpp

namespace {

constexpr auto managerPropertyName = "_fluid_plain_tooltip_manager";
constexpr auto plainToolTipUrl = "qrc:/qt/qml/Fluid/qml/components/PlainToolTip.qml";

void resetProperty(QObject *object, const char *name)
{
    const int index = object->metaObject()->indexOfProperty(name);
    if (index >= 0) {
        const QMetaProperty property = object->metaObject()->property(index);
        if (property.isResettable())
            property.reset(object);
    }
}

} // namespace

class PlainToolTipManager : public QObject
{
    Q_OBJECT

public:
    explicit PlainToolTipManager(QQmlEngine *engine)
        : QObject(engine)
        , m_engine(engine)
    {
    }

    static PlainToolTipManager *instance(QQmlEngine *engine, bool create)
    {
        if (!engine)
            return nullptr;

        const QVariant value = engine->property(managerPropertyName);
        if (auto *manager = qobject_cast<PlainToolTipManager *>(value.value<QObject *>()))
            return manager;
        if (!create)
            return nullptr;

        auto *manager = new PlainToolTipManager(engine);
        engine->setProperty(managerPropertyName, QVariant::fromValue<QObject *>(manager));
        return manager;
    }

    QObject *toolTip(bool create)
    {
        if (m_toolTip || !create)
            return m_toolTip;

        QQmlComponent component(m_engine, QUrl(QString::fromLatin1(plainToolTipUrl)));
        if (!component.isReady()) {
            reportErrors(component);
            return nullptr;
        }

        QObject *toolTip = component.create();
        if (!toolTip) {
            reportErrors(component);
            return nullptr;
        }

        toolTip->setParent(this);
        m_toolTip = toolTip;
        connect(toolTip, SIGNAL(visibleChanged()), this, SLOT(toolTipVisibleChanged()));
        return toolTip;
    }

    bool isVisible(const PlainToolTipAttached *attached) const
    {
        return attached && attached == m_current && m_toolTip
                && m_toolTip->property("visible").toBool();
    }

    void show(PlainToolTipAttached *attached, const QString &text, int timeout)
    {
        QQuickItem *owner = attached ? attached->target() : nullptr;
        QObject *toolTip = owner ? this->toolTip(true) : nullptr;
        if (!owner || !toolTip)
            return;

        if (m_current && m_current != attached)
            hide(m_current);

        m_current = attached;
        setOwner(owner);
        resetProperty(toolTip, "width");
        resetProperty(toolTip, "height");
        toolTip->setProperty("parent", QVariant::fromValue(owner));
        toolTip->setProperty("text", text);
        toolTip->setProperty("delay", attached->delay());
        toolTip->setProperty("timeout", attached->timeout());
        m_requestedText = text;
        m_requestedTimeout = timeout;
        m_showRequested = true;

        if (owner->window())
            invokeShow();
    }

    void hide(PlainToolTipAttached *attached)
    {
        if (!attached || attached != m_current || !m_toolTip)
            return;

        m_showRequested = false;
        if (!QMetaObject::invokeMethod(m_toolTip, "hide"))
            qmlWarning(attached->target()) << "Failed to invoke PlainToolTip.hide()";
    }

    void release(PlainToolTipAttached *attached)
    {
        if (!attached || attached != m_current)
            return;

        m_showRequested = false;
        if (m_toolTip)
            QMetaObject::invokeMethod(m_toolTip, "hide");
        m_current.clear();
        setOwner(nullptr);
    }

    void sync(PlainToolTipAttached *attached, const char *property, const QVariant &value)
    {
        if (!attached || attached != m_current || !m_toolTip
            || (!m_showRequested && !isVisible(attached))) {
            return;
        }

        m_toolTip->setProperty(property, value);
        if (std::strcmp(property, "text") == 0)
            m_requestedText = value.toString();
        else if (std::strcmp(property, "timeout") == 0)
            m_requestedTimeout = -1;
        else if (std::strcmp(property, "delay") == 0 && m_showRequested
                 && !m_toolTip->property("visible").toBool() && m_owner && m_owner->window())
            invokeShow();
    }

private Q_SLOTS:
    void toolTipVisibleChanged()
    {
        if (m_toolTip && !m_toolTip->property("visible").toBool())
            m_showRequested = false;
        if (m_current)
            m_current->notifyVisibleChanged();
    }

private:
    void setOwner(QQuickItem *owner)
    {
        if (m_owner == owner)
            return;
        if (m_owner)
            disconnect(m_owner, nullptr, this, nullptr);

        m_owner = owner;
        if (m_owner) {
            connect(m_owner, &QQuickItem::windowChanged, this, [this](QQuickWindow *window) {
                if (window && m_showRequested)
                    invokeShow();
            });
        }
    }

    void invokeShow()
    {
        if (!m_toolTip || !m_owner || !m_showRequested)
            return;

        if (!QMetaObject::invokeMethod(m_toolTip, "show", Q_ARG(QString, m_requestedText),
                                       Q_ARG(int, m_requestedTimeout))) {
            m_showRequested = false;
            qmlWarning(m_owner) << "Failed to invoke PlainToolTip.show()";
        }
    }

    void reportErrors(const QQmlComponent &component) const
    {
        const auto errors = component.errors();
        if (errors.isEmpty()) {
            qmlWarning(m_engine) << "Failed to create PlainToolTip";
            return;
        }
        for (const auto &error : errors)
            qmlWarning(m_engine) << error.toString();
    }

    QPointer<QQmlEngine> m_engine;
    QPointer<QObject> m_toolTip;
    QPointer<PlainToolTipAttached> m_current;
    QPointer<QQuickItem> m_owner;
    QString m_requestedText;
    int m_requestedTimeout = -1;
    bool m_showRequested = false;
};

PlainToolTipAttached::PlainToolTipAttached(QObject *parent)
    : QObject(parent)
{
    if (parent && !qobject_cast<QQuickItem *>(parent))
        qmlWarning(parent) << "ToolTip attached properties require a QQuickItem target";
}

PlainToolTipAttached::~PlainToolTipAttached()
{
    if (PlainToolTipManager *toolTipManager = manager(false))
        toolTipManager->release(this);
}

QString PlainToolTipAttached::text() const
{
    return m_text;
}

void PlainToolTipAttached::setText(const QString &text)
{
    if (m_text == text)
        return;
    m_text = text;
    if (PlainToolTipManager *toolTipManager = manager(false))
        toolTipManager->sync(this, "text", text);
    Q_EMIT textChanged();
}

int PlainToolTipAttached::delay() const
{
    return m_delay;
}

void PlainToolTipAttached::setDelay(int delay)
{
    if (m_delay == delay)
        return;
    m_delay = delay;
    if (PlainToolTipManager *toolTipManager = manager(false))
        toolTipManager->sync(this, "delay", delay);
    Q_EMIT delayChanged();
}

int PlainToolTipAttached::timeout() const
{
    return m_timeout;
}

void PlainToolTipAttached::setTimeout(int timeout)
{
    if (m_timeout == timeout)
        return;
    m_timeout = timeout;
    if (PlainToolTipManager *toolTipManager = manager(false))
        toolTipManager->sync(this, "timeout", timeout);
    Q_EMIT timeoutChanged();
}

bool PlainToolTipAttached::isVisible() const
{
    PlainToolTipManager *toolTipManager = manager(false);
    return toolTipManager && toolTipManager->isVisible(this);
}

void PlainToolTipAttached::setVisible(bool visible)
{
    if (visible)
        show(m_text);
    else
        hide();
}

QObject *PlainToolTipAttached::toolTip() const
{
    PlainToolTipManager *toolTipManager = manager(true);
    return toolTipManager ? toolTipManager->toolTip(true) : nullptr;
}

void PlainToolTipAttached::show(const QString &text, int timeout)
{
    PlainToolTipManager *toolTipManager = manager(true);
    if (toolTipManager)
        toolTipManager->show(this, text, timeout);
}

void PlainToolTipAttached::hide()
{
    if (PlainToolTipManager *toolTipManager = manager(false))
        toolTipManager->hide(this);
}

PlainToolTipManager *PlainToolTipAttached::manager(bool create) const
{
    return PlainToolTipManager::instance(qmlEngine(parent()), create);
}

QQuickItem *PlainToolTipAttached::target() const
{
    return qobject_cast<QQuickItem *>(parent());
}

void PlainToolTipAttached::notifyVisibleChanged()
{
    Q_EMIT visibleChanged();
}

AttachedToolTip::AttachedToolTip(QObject *parent)
    : QObject(parent)
{
}

PlainToolTipAttached *AttachedToolTip::qmlAttachedProperties(QObject *object)
{
    return new PlainToolTipAttached(object);
}

} // namespace Fluid

#include "tooltipattached.moc"
