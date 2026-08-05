// SPDX-FileCopyrightText: 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick

/*!
    \brief A \l QtObject with children.

    The \l Object type is a non-visual element that extends \l QtObject
    with the ability to hold children objects.

   \code{.qml}
   import QtQuick
   import Fluid

   Object {
       QtObject {}
       QtObject {}
   }
   \endcode
*/
QtObject {
    id: object

    /*!
        \internal
    */
    default property alias children: object.__children

    /*!
        \internal
    */
    property list<QtObject> __children: [
        QtObject {}
    ]
}
