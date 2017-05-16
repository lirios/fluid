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

import QtQuick 2.0

/*!
    \qmltype Object
    \inqmlmodule Fluid.Core
    \ingroup fluidcore

    \brief A \l QtObject with children.

    The \l Object type is a non-visual element that extends \l QtObject
    with the ability to hold children objects.
*/
QtObject {
    default property alias children: object.__children

    /*!
        \qmlproperty list<QtObject> Object::children

        Children objects.
    */
    property list<QtObject> __children: [QtObject {}]

    id: object
}
