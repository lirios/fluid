// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtCore/qpointer.h>
#include <QtCore/qstring.h>
#include <QtQml/qqmlregistration.h>

QT_FORWARD_DECLARE_CLASS(QQuickItem)

namespace Fluid {

class PlainToolTipManager;

class PlainToolTipAttached : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged FINAL)
    Q_PROPERTY(int delay READ delay WRITE setDelay NOTIFY delayChanged FINAL)
    Q_PROPERTY(int timeout READ timeout WRITE setTimeout NOTIFY timeoutChanged FINAL)
    Q_PROPERTY(bool visible READ isVisible WRITE setVisible NOTIFY visibleChanged FINAL)
    Q_PROPERTY(QObject *toolTip READ toolTip CONSTANT FINAL)

public:
    explicit PlainToolTipAttached(QObject *parent = nullptr);
    ~PlainToolTipAttached() override;

    QString text() const;
    void setText(const QString &text);

    int delay() const;
    void setDelay(int delay);

    int timeout() const;
    void setTimeout(int timeout);

    bool isVisible() const;
    void setVisible(bool visible);

    QObject *toolTip() const;

    Q_INVOKABLE void show(const QString &text, int timeout = -1);
    Q_INVOKABLE void hide();

Q_SIGNALS:
    void textChanged();
    void delayChanged();
    void timeoutChanged();
    void visibleChanged();

private:
    friend class PlainToolTipManager;

    PlainToolTipManager *manager(bool create) const;
    QQuickItem *target() const;
    void notifyVisibleChanged();

    QString m_text;
    int m_delay = 0;
    int m_timeout = -1;
};

/*!
    \class AttachedToolTip
    \brief Provides the Material plain-tooltip attached API.

    ToolTip exposes \c text, \c visible, \c delay, \c timeout, \c show(), and
    \c hide() as attached properties and methods. It lazily shares a styled
    PlainToolTip instance within each QML engine.

    \code{.qml}
    MD.IconButton {
        MD.ToolTip.text: qsTr("Search")
        MD.ToolTip.visible: hovered || visualFocus
    }
    \endcode

    Use PlainToolTip when a standalone popup instance is required.
*/
class AttachedToolTip : public QObject
{
    Q_OBJECT
    QML_NAMED_ELEMENT(ToolTip)
    QML_UNCREATABLE("ToolTip is only available as an attached property")
    QML_ATTACHED(PlainToolTipAttached)

public:
    explicit AttachedToolTip(QObject *parent = nullptr);

    static PlainToolTipAttached *qmlAttachedProperties(QObject *object);
};

} // namespace Fluid

QML_DECLARE_TYPEINFO(Fluid::AttachedToolTip, QML_HAS_ATTACHED_PROPERTIES)
