load(liri_deployment)

include(demo.pri)

target.path = $$LIRI_INSTALL_BINDIR
INSTALLS += target

QML_IMPORT_PATH = $$FLUID_BUILD_DIR/qml

android {
    DISTFILES += \
        android/AndroidManifest.xml \
        android/res/drawable/splash.xml \
        android/res/values/libs.xml \
        android/build.gradle

    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

    ANDROID_EXTRA_LIBS = $$FLUID_BUILD_DIR/lib/libFluid.so
}
