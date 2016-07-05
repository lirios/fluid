Fluid
=====

[![ZenHub.io](https://img.shields.io/badge/supercharged%20by-zenhub.io-blue.svg)](https://zenhub.io)

[![License](https://img.shields.io/badge/license-LGPLv2.1%2B-blue.svg)](http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html)
[![GitHub release](https://img.shields.io/github/release/hawaii-desktop/fluid.svg)](https://github.com/hawaii-desktop/fluid)
[![Build Status](https://travis-ci.org/hawaii-desktop/fluid.svg?branch=develop)](https://travis-ci.org/hawaii-desktop/fluid)
[![GitHub issues](https://img.shields.io/github/issues/hawaii-desktop/fluid.svg)](https://github.com/hawaii-desktop/fluid/issues)
[![Maintained](https://img.shields.io/maintenance/yes/2016.svg)](https://github.com/hawaii-desktop/fluid/commits/develop)

Fluid is a collection of cross-platform QtQuick components for building fluid and dynamic applications.

### Dependencies

Qt >= 5.6.0 with at least the following modules is required:

* [qtbase](http://code.qt.io/cgit/qt/qtbase.git)
* [qtdeclarative](http://code.qt.io/cgit/qt/qtdeclarative.git)
* [qtquickcontrols](http://code.qt.io/cgit/qt/qtquickcontrols.git)
* [qtquickcontrols2](http://code.qt.io/cgit/qt/qtquickcontrols2.git)

### Installation

From the root of the repository, run:

```sh
mkdir build; cd build
cmake ..
make
make install # use sudo if necessary
```

On the `cmake` line, you can specify additional configuration parameters:

 * `-DCMAKE_INSTALL_PREFIX=/path/to/install` (for example, `/opt/hawaii` or `/usr`)
 * `-DCMAKE_BUILD_TYPE=<build_type>`, where `<build_type>` is one of:
   * **Debug:** debug build
   * **Release:** release build
   * **RelWithDebInfo:** release build with debugging information

### Licensing

Fluid is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.
