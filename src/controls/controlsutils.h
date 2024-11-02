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

    /*!
        Returns an URL for the Material Design icon \a name.
        Use this URL with Image or icon grouped property with controls.

        \code{.qml}
        import QtQuick
        import Fluid as Fluid

        Image {
            source: Fluid.Utils.iconUrl("action/alarm")
            width: 64
            height: 64
        }
        \endcode

        \code{.qml}
        import QtQuick
        import QtQuick.Controls
        import Fluid as Fluid

        Button {
            icon.source: Fluid.Utils.iconUrl("action/alarm")
            text: qsTr("Alarm")
        }
        \endcode
    */
    Q_INVOKABLE QUrl iconUrl(const QString &name);

    static ControlsUtils *create(QQmlEngine *engine, QJSEngine *jsEngine);

private:
    QUrl m_baseUrl;
};

