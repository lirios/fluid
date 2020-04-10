cmake_minimum_required(VERSION 3.5)

project(Demo LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# QtCreator supports the following variables for Android, which are identical to qmake Android variables.
# Check http://doc.qt.io/qt-5/deployment-android.html for more information.
# They need to be set before the find_package(Qt5 ...) call.

#if(ANDROID)
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
#    if (ANDROID_ABI STREQUAL "armeabi-v7a")
#        set(ANDROID_EXTRA_LIBS
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libcrypto.so
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libssl.so)
#    endif()
#endif()

find_package(Qt5 COMPONENTS Core Quick QuickControls2 REQUIRED)

if(ANDROID)
    add_library(Demo SHARED
      iconcategorymodel.cpp iconcategorymodel.h
      iconnamemodel.cpp iconnamemodel.h
      main.cpp
      qml.qrc
    )
else()
    add_executable(Demo
      iconcategorymodel.cpp iconcategorymodel.h
      iconnamemodel.cpp iconnamemodel.h
      main.cpp
      qml.qrc
    )
endif()

target_compile_definitions(Demo
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(Demo
  PRIVATE Qt5::Core Qt5::Quick Qt5::QuickControls2)
