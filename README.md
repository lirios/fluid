Fluid
=====

[![ZenHub.io](https://img.shields.io/badge/supercharged%20by-zenhub.io-blue.svg)](https://zenhub.io)

[![License](https://img.shields.io/badge/license-MPL2-blue.svg)](https://www.mozilla.org/en-US/MPL/2.0/)
[![GitHub release](https://img.shields.io/github/release/lirios/fluid.svg)](https://github.com/lirios/fluid)
[![Build Status](https://travis-ci.org/lirios/fluid.svg?branch=develop)](https://travis-ci.org/lirios/fluid)
[![GitHub issues](https://img.shields.io/github/issues/lirios/fluid.svg)](https://github.com/lirios/fluid/issues)
[![Maintained](https://img.shields.io/maintenance/yes/2017.svg)](https://github.com/lirios/fluid/commits/develop)

Fluid is a collection of cross-platform QtQuick components for building fluid and dynamic applications.

## Dependencies

Qt >= 5.8.0 with at least the following modules is required:

 * [qtbase](http://code.qt.io/cgit/qt/qtbase.git)
 * [qtdeclarative](http://code.qt.io/cgit/qt/qtdeclarative.git)
 * [qtquickcontrols2](http://code.qt.io/cgit/qt/qtquickcontrols2.git)
 * [qtgraphicaleffects](http://code.qt.io/cgit/qt/qtgraphicaleffects.git)
 * [qtsvg](http://code.qt.io/cgit/qt/qtsvg.git)

## System-wide installation

First, if you want to include the Material Design icons used with the `Icon` component, run:

```sh
./scripts/fetch_icons.sh
```

This will clone the Google repository holding the icons and copy the SVG icons into the `icons` directory.

From the root of the repository, run:

```sh
mkdir build; cd build
cmake .. -DKDE_INSTALL_USE_QT_SYS_PATHS=ON
make
make install # use sudo if necessary
```

On the `cmake` line, you can specify additional configuration parameters:

 * `-DCMAKE_INSTALL_PREFIX=/path/to/install` (for example, `/opt/liri` or `/usr`)
 * `-DCMAKE_BUILD_TYPE=<build_type>`, where `<build_type>` is one of:
   * **Debug:** debug build
   * **Release:** release build
   * **RelWithDebInfo:** release build with debugging information

## Per-project installation using QMake

First, clone this repository.

Run the icon script located here:

```sh
./scripts/fetch_icons.sh
```

In your project file, include the `fluid.pri` file:  
```qmake
include(path/to/fluid.pri)
```

Then, in your `main.cpp` file or wherever you set up a `QQmlApplicationEngine`:
* add this include directive:
```cpp
#include "iconsimageprovider.h"
#include "iconthemeimageprovider.h"
```
* add the resources files to your `QQmlApplicationEngine` import paths:
```cpp
engine.addImportPath(QLatin1String("qrc:/"));
```
* register fluid's image providers to the engine:
```cpp
engine.addImageProvider(QLatin1String("fluidicons"), new IconsImageProvider());
engine.addImageProvider(QLatin1String("fluidicontheme"), new IconThemeImageProvider());
```
* and after that you can load your qml file:  
```cpp
engine.load(QUrl(QLatin1String("qrc:/main.qml")));
```

## Licensing

Licensed under the terms of the Mozilla Public License version 2.0.
