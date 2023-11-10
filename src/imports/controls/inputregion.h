// SPDX-FileCopyrightText: 2022 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
//
// SPDX-License-Identifier: MPL-2.0

#ifndef INPUTREGION_H
#define INPUTREGION_H

#include <QQmlListProperty>
#include <QQmlParserStatus>
#include <QWindow>

class InputRegion;

class InputArea : public QObject, public QQmlParserStatus
{
    Q_OBJECT
    Q_PROPERTY(InputRegion *region READ region WRITE setRegion NOTIFY regionChanged)
    Q_PROPERTY(bool enabled READ isEnabled WRITE setEnabled NOTIFY enabledChanged)
    Q_PROPERTY(qreal x READ x WRITE setX NOTIFY xChanged)
    Q_PROPERTY(qreal y READ y WRITE setY NOTIFY yChanged)
    Q_PROPERTY(qreal width READ width WRITE setWidth NOTIFY widthChanged)
    Q_PROPERTY(qreal height READ height WRITE setHeight NOTIFY heightChanged)
    Q_INTERFACES(QQmlParserStatus)
public:
    InputArea(QObject *parent = nullptr);
    ~InputArea();

    InputRegion *region() const;
    void setRegion(InputRegion *region);

    bool isEnabled() const;
    void setEnabled(bool enabled);

    qreal x() const;
    void setX(qreal x);

    qreal y() const;
    void setY(qreal y);

    qreal width() const;
    void setWidth(qreal width);

    qreal height() const;
    void setHeight(qreal height);

    QRectF rect() const;

Q_SIGNALS:
    void regionChanged(InputRegion *region);
    void enabledChanged(bool enabled);
    void xChanged(qreal x);
    void yChanged(qreal y);
    void widthChanged(qreal width);
    void heightChanged(qreal height);

protected:
    void classBegin() override {}
    void componentComplete() override;

private:
    bool m_initialized = false;
    InputRegion *m_region = nullptr;
    bool m_enabled = true;
    qreal m_x = 0, m_y = 0, m_width = 0, m_height = 0;
};

class InputRegion : public QObject, public QQmlParserStatus
{
    Q_OBJECT
    Q_PROPERTY(bool enabled READ isEnabled WRITE setEnabled NOTIFY enabledChanged)
    Q_PROPERTY(QWindow *window READ window WRITE setWindow NOTIFY windowChanged)
    Q_PROPERTY(QQmlListProperty<InputArea> areas READ areas CONSTANT)
    Q_INTERFACES(QQmlParserStatus)
public:
    explicit InputRegion(QObject *parent = nullptr);

    bool isEnabled() const;
    void setEnabled(bool enabled);

    QWindow *window() const;
    void setWindow(QWindow *window);

    QQmlListProperty<InputArea> areas();

    void registerArea(InputArea *area);
    void unregisterArea(InputArea *area);

Q_SIGNALS:
    void enabledChanged(bool enabled);
    void windowChanged(QWindow *window);

protected:
    void classBegin() override {}
    void componentComplete() override;

private:
    bool m_initialized = false;
    bool m_enabled = true;
    QWindow *m_window = nullptr;
    QList<InputArea *> m_areas;

    static int areasCount(QQmlListProperty<InputArea> *list);
    static InputArea *areaAt(QQmlListProperty<InputArea> *list, int index);

private Q_SLOTS:
    void setInputRegion();
};

#endif // INPUTREGION_H
