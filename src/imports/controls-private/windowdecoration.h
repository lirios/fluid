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

#ifndef WINDOWDECORATION_H
#define WINDOWDECORATION_H

#include <QObject>
#include <QColor>
#include <QWindow>
#include <QQmlParserStatus>

class WindowDecoration : public QObject, public QQmlParserStatus
{
    Q_OBJECT
    Q_PROPERTY(QWindow *window READ window WRITE setWindow NOTIFY windowChanged)
    Q_PROPERTY(Theme theme READ theme WRITE setTheme NOTIFY themeChanged)
    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged)
    Q_INTERFACES(QQmlParserStatus)
public:
    enum Theme {
        Light,
        Dark
    };
    Q_ENUM(Theme)

    explicit WindowDecoration(QObject *parent = nullptr);

    QWindow *window() const;
    void setWindow(QWindow *window);

    Theme theme() const;
    void setTheme(Theme theme);

    QColor color() const;
    void setColor(const QColor &color);

    void classBegin() override;
    void componentComplete() override;

Q_SIGNALS:
    void windowChanged();
    void themeChanged();
    void colorChanged();

protected:
    bool eventFilter(QObject *object, QEvent *event) override;

private:
    QWindow *m_window;
    Theme m_theme;
    QColor m_color;

private Q_SLOTS:
    void updateDecorationColor();
};

#endif // WINDOWDECORATION_H
