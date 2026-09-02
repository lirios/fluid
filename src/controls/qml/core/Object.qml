// SPDX-FileCopyrightText: 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick

/*!
    \class Object
    \brief A `QtObject` with children.

    The \ref Object type is a non-visual element that extends `QtObject`
    with the ability to hold children objects.

    Object is a Fluid infrastructure type and has no standalone Material 3
    component specification.

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
