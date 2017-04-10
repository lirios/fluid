TEMPLATE = app
TARGET = fluid-demo

QT += gui qml quick quickcontrols2

SOURCES += $$PWD/main.cpp
RESOURCES += $$PWD/demo.qrc

OTHER_FILES += \
    $$files(qml/*.qml) \
    $$files(qml/+material/*.qml) \
    $$files(qml/+universal/*.qml) \
    $$files(qml/Pages/Basic/*.qml) \
    $$files(qml/Pages/Compound/*.qml) \
    $$files(qml/Pages/Style/*.qml) \
    $$files(qml/Pages/Layouts/*.qml) \
    $$files(qml/Pages/Material/*.qml) \
    $$files(qml/Pages/Navigation/*.qml)
