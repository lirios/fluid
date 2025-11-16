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

#pragma once

#include <QObject>
#include <QUrl>
#include <QQmlEngine>

/*!
    \brief A collection of helpful utility methods.
*/
class ControlsUtils : public QObject
{
    Q_OBJECT
    QML_NAMED_ELEMENT(Utils)
    QML_SINGLETON
public:
    explicit ControlsUtils(const QUrl &baseUrl, QObject *parent = nullptr);

    /*!
        Scale \a percent in the range between \a start and \a end.
    */
    Q_INVOKABLE qreal scale(qreal percent, qreal start, qreal end);

    static ControlsUtils *create(QQmlEngine *engine, QJSEngine *jsEngine);

private:
    QUrl m_baseUrl;
};
