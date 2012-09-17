Fluid
=====

Library for fluid and dynamic applications development with QtQuick.

Dependencies
============

In order to build and install Fluid you need Qt 5.
The Qt Project has detailed instructions: http://qt-project.org/wiki/Building_Qt_5_from_Git

Build
=====

Building Fluid is a piece of cake.

Assuming you are in the source directory, just create a build directory
and run cmake:

    mkdir build
    cd build
    cmake -DCMAKE_INSTALL_PREFIX=/system ..

To do a debug build the last command can be:

    cmake -DCMAKE_INSTALL_PREFIX=/system -DCMAKE_BUILD_TYPE=Debug ..

To do a release build instead it can be:

    cmake -DCMAKE_INSTALL_PREFIX=/system -DCMAKE_BUILD_TYPE=Release ..

The CMAKE_BUILD_TYPE parameter allows the following values:

    Debug: debug build
    Release: release build
    RelWithDebInfo: release build with debugging information

Installation
============

It's really, it's just a matter of typing:

    make install

from the build directory.
