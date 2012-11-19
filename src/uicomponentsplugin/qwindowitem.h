/****************************************************************************
**
** Copyright (C) 2012 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the Qt Components project.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
**     the names of its contributors may be used to endorse or promote
**     products derived from this software without specific prior written
**     permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
** $QT_END_LICENSE$
**
****************************************************************************/

#ifndef QWindowItem_H
#define QWindowItem_H

#include "qtoplevelwindow.h"

#include <QtGui/QGuiApplication>
#include <QtQuick/QQuickItem>
#include <QtQuick/QQuickView>
#include <QMenuBar>

class QWindowItem : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(int minimumHeight READ minimumHeight WRITE setMinimumHeight NOTIFY minimumHeightChanged)
    Q_PROPERTY(int maximumHeight READ maximumHeight WRITE setMaximumHeight NOTIFY maximumHeightChanged)
    Q_PROPERTY(int minimumWidth READ minimumWidth WRITE setMinimumWidth NOTIFY minimumWidthChanged)
    Q_PROPERTY(int maximumWidth READ maximumWidth WRITE setMaximumWidth NOTIFY maximumWidthChanged)
    Q_PROPERTY(bool visible READ isVisible WRITE setVisible NOTIFY visibleChanged)
    Q_PROPERTY(bool windowDecoration READ windowDecoration WRITE setWindowDecoration NOTIFY windowDecorationChanged)
    Q_PROPERTY(bool modal READ modal WRITE setModal NOTIFY modalityChanged)
    Q_PROPERTY(bool deleteOnClose READ deleteOnClose WRITE setDeleteOnClose NOTIFY deleteOnCloseChanged)
    Q_PROPERTY(Qt::WindowState windowState READ windowState WRITE setWindowState NOTIFY windowStateChanged)
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)

public:
    QWindowItem();
    ~QWindowItem();
    QTopLevelWindow *window() { return _window; }
    QQuickView *view() { return _window->view(); }
    int minimumHeight() const { return _window->minimumSize().height(); }
    int maximumHeight() const { return _window->maximumSize().height(); }
    int minimumWidth() const { return _window->minimumSize().width(); }
    int maximumWidth() const { return _window->maximumSize().width(); }
    bool isVisible() const { return _window->isVisible(); }
    bool windowDecoration() const { return !(_window->windowFlags() & Qt::FramelessWindowHint); }
    Qt::WindowState windowState() const { return static_cast<Qt::WindowState>(static_cast<int>(_window->windowState()) & ~Qt::WindowActive); }
    QString title() const { return _window->windowTitle(); }
    bool deleteOnClose() const { return _deleteOnClose; }
    bool modal() const { return _window->isModal(); }

    void setMinimumHeight(int height);
    void setMaximumHeight(int height);
    void setMinimumWidth(int width);
    void setMaximumWidth(int width);
    void setVisible(bool visible);
    void setWindowDecoration(bool s);
    void setWindowState(Qt::WindowState state) { _window->setWindowState(state); }
    void setTitle(QString title);
    void setModal(bool modal);
    void setDeleteOnClose(bool close);

public Q_SLOTS:
    void close();

protected:
    bool eventFilter(QObject *, QEvent *ev);
    void updateParentWindow();
    void registerChildWindow(QWindowItem* child);
    void componentComplete();

protected Q_SLOTS:
    void updateWindowGeometry();
    void center();
    void moveWindow(int x, int y, int lx, int ly);

Q_SIGNALS:
    void visibleChanged();
    void windowDecorationChanged();
    void windowStateChanged();
    void minimumHeightChanged();
    void minimumWidthChanged();
    void maximumHeightChanged();
    void maximumWidthChanged();
    void titleChanged();
    void modalityChanged();
    void deleteOnCloseChanged();

private:
    QTopLevelWindow *_window;
    bool _complete;
    bool _positionIsDefined;
    bool _delayedVisible;
    bool _deleteOnClose;
    int _x;
    int _y;
};

#endif // QWindowItem_H
