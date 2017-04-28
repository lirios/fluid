defineTest(minQtVersion) {
    maj = $$1
    min = $$2
    patch = $$3
    isEqual(QT_MAJOR_VERSION, $$maj) {
        isEqual(QT_MINOR_VERSION, $$min) {
            isEqual(QT_PATCH_VERSION, $$patch) {
                return(true)
            }
            greaterThan(QT_PATCH_VERSION, $$patch) {
                return(true)
            }
        }
        greaterThan(QT_MINOR_VERSION, $$min) {
            return(true)
        }
    }
    greaterThan(QT_MAJOR_VERSION, $$maj) {
        return(true)
    }
    return(false)
}

!minQtVersion(5, 8, 0): \
    error("Fluid requires at least Qt 5.8.0, but $${QT_VERSION} was detected.")

!exists(features/liri_deployment.prf): \
    error("Git submodule missing. Run \'git submodule update --init\' in $${PWD}.")

TEMPLATE = subdirs

SUBDIRS += src tests
CONFIG += ordered

tests.depends = src

# We do not install features anymore, just rely on submodules
# to avoid a Fluid dependency on modules where it doesn't make sense
#prf.files = \
#    $$PWD/features/liri_create_cmake.prf \
#    $$PWD/features/liri_deployment.prf \
#    $$PWD/features/liri_qml_module.prf \
#    $$PWD/features/liri_qml_plugin.prf \
#    $$PWD/features/liri_qt_app.prf \
#    $$PWD/features/liri_qt_module.prf \
#    $$PWD/features/liri_qt_module_pris.prf \
#    $$PWD/features/liri_qt_plugin.prf
#prf.path = $$[QT_HOST_DATA]/mkspecs/features
#INSTALLS += prf
#
#prf_data_cmake.files = \
#    $$PWD/features/data/cmake/liri_ExtraSourceIncludes.cmake.in \
#    $$PWD/features/data/cmake/liri_Qt5BasicConfig.cmake.in \
#    $$PWD/features/data/cmake/liri_Qt5ConfigVersion.cmake.in \
#    $$PWD/features/data/cmake/liri_Qt5PluginTarget.cmake.in
#prf_data_cmake.path = $$[QT_HOST_DATA]/mkspecs/features/data/cmake
#INSTALLS += prf_data_cmake

OTHER_FILES += \
    $$PWD/AUTHORS.md \
    $$PWD/LICENSE.MPL2 \
    $$PWD/README.md

include(doc/doc.pri)
