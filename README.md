Fluid
=====

[![GitHub release](https://img.shields.io/github/release/hawaii-desktop/fluid.svg)](https://github.com/hawaii-desktop/fluid)
[![GitHub issues](https://img.shields.io/github/issues/hawaii-desktop/fluid.svg)](https://github.com/hawaii-desktop/fluid/issues)
[![IRC Network](https://img.shields.io/badge/irc-freenode-blue.svg "IRC Freenode")](https://webchat.freenode.net/?channels=hawaii-desktop)

Modules for fluid and dynamic applications development with QtQuick.

## Dependencies

Qt >= 5.5 with at least the following modules is required:

* [qtbase](http://code.qt.io/cgit/qt/qtbase.git)
* [qtdeclarative](http://code.qt.io/cgit/qt/qtdeclarative.git)
* [qtquickcontrols](http://code.qt.io/cgit/qt/qtquickcontrols.git)

## License

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

## Build and installation

Building Green Island is a piece of cake.

Assuming you are in the source directory, just create a build directory
and run cmake:

```sh
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/opt/hawaii ..
```

To do a debug build the last command can be:

```sh
cmake -DCMAKE_INSTALL_PREFIX=/opt/hawaii -DCMAKE_BUILD_TYPE=Debug ..
```

To do a release build instead it can be:

```sh
cmake -DCMAKE_INSTALL_PREFIX=/opt/hawaii -DCMAKE_BUILD_TYPE=Release ..
```

If not passed, the `CMAKE_INSTALL_PREFIX` parameter defaults to /usr/local.
You have to specify a path that fits your needs, /opt/hawaii is just an example.

The `CMAKE_BUILD_TYPE` parameter allows the following values:

* **Debug:** debug build
* **Release:** release build
* **RelWithDebInfo:** release build with debugging information

Install with:

```sh
sudo make install
```

### System-wide installation

Those who want to perform a system-wide installation, such as package
maintainers, should pass different arguments to cmake:

```sh
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr -DKDE_INSTALL_USE_QT_SYS_PATHS=ON ..
```

Feel free to choose whatever `CMAKE_BUILD_TYPE` value you desire.

Install with:

```sh
sudo make install
```
