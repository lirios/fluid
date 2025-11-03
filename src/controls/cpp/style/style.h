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

#include <QtQml/QQmlEngine>
#include <QtQuickControls2/QQuickAttachedPropertyPropagator>

class Style : public QQuickAttachedPropertyPropagator
{
    Q_OBJECT
    Q_DISABLE_COPY(Style)

    Q_PROPERTY(Theme theme READ theme WRITE setTheme RESET resetTheme NOTIFY themeChanged FINAL)
    Q_PROPERTY(int elevation READ elevation WRITE setElevation RESET resetElevation NOTIFY
                       elevationChanged FINAL)

    QML_NAMED_ELEMENT(Style)
    QML_ATTACHED(Style)
    QML_UNCREATABLE("")
    QML_ADDED_IN_VERSION(2, 0)
public:
    enum Theme {
        Light,
        Dark,
        System
    };
    Q_ENUM(Theme)

    explicit Style(QObject *parent = nullptr);

    Theme theme() const;
    void setTheme(Theme theme);
    void resetTheme();

    int elevation() const;
    void setElevation(int elevation);
    void resetElevation();

    static Style *qmlAttachedProperties(QObject *object);

    static bool isDarkSystemTheme();
    static Theme effectiveTheme(Theme theme);

Q_SIGNALS:
    void themeChanged();
    void elevationChanged();

protected:
    void attachedParentChange(QQuickAttachedPropertyPropagator *newParent,
                              QQuickAttachedPropertyPropagator *oldParent) override;

private:
    // Whether a particular setting was explicitly set on this instance
    bool m_explicitTheme = false;

    // Actual property values
    bool m_systemTheme = false;
    Style::Theme m_theme = Style::Light;
    int m_elevation = 0;

    void inheritTheme(Style::Theme theme);
    void propagateTheme();
};
