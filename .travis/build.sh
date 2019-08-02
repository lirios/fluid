#!/bin/bash

set -e

source /usr/local/share/liri-travis/functions

# Install packages
travis_start "install_packages"
msg "Install packages..."
dnf install -y \
    desktop-file-utils \
    libappstream-glib \
    wayland-devel \
    qt5-qtwayland-devel
# workaround for the missing renameat2 syscall
strip --remove-section=.note.ABI-tag /usr/lib64/libQt5Core.so.5
travis_end "install_packages"

# Install artifacts
travis_start "artifacts"
msg "Install artifacts..."
/usr/local/bin/liri-download-artifacts $TRAVIS_BRANCH cmakeshared-artifacts.tar.gz
travis_end "artifacts"

# Configure
travis_start "configure"
msg "Setup CMake..."
mkdir build
cd build
if [ "$CXX" == "clang++" ]; then
    clazy="-DENABLE_CLAZY:BOOL=ON"
fi
cmake .. $clazy \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DINSTALL_LIBDIR=/usr/lib64 \
    -DINSTALL_QMLDIR=/usr/lib64/qt5/qml \
    -DINSTALL_PLUGINSDIR=/usr/lib64/qt5/plugins
travis_end "configure"

# Build
travis_start "build"
msg "Build..."
make -j $(nproc)
travis_end "build"

# Install
travis_start "install"
msg "Install..."
make install
travis_end "install"

# Test
travis_start "test"
msg "Test..."
dbus-run-session -- \
    xvfb-run -a -s "-screen 0 800x600x24" \
    ctest -V
travis_end "test"

# Package
travis_start "package"
msg "Package..."
mkdir -p artifacts
tar czf artifacts/fluid-artifacts.tar.gz -T install_manifest.txt
travis_end "package"

# Validate desktop file and appdata
travis_start "validate"
msg "Validate..."
for filename in $(find . -type f -name "*.desktop"); do
    desktop-file-validate $filename
done
for filename in $(find . -type f -name "*.appdata.xml"); do
    appstream-util validate-relax --nonet $filename
done
travis_end "validate"
