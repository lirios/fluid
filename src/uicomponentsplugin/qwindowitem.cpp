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

#include "qwindowitem.h"
#include "qtoplevelwindow.h"

#include <QTimer>

QWindowItem::QWindowItem()
    : QQuickItem()
    , _window(new QTopLevelWindow)
    , _positionIsDefined(false)
    , _delayedVisible(false)
    , _deleteOnClose(false)
    , _x(0), _y(0)
{
    connect(_window, SIGNAL(visibilityChanged()), this, SIGNAL(visibleChanged()));
    connect(_window, SIGNAL(windowStateChanged()), this, SIGNAL(windowStateChanged()));

    connect(this, SIGNAL(xChanged()), this, SLOT(updateWindowGeometry()));
    connect(this, SIGNAL(yChanged()), this, SLOT(updateWindowGeometry()));
    connect(this, SIGNAL(widthChanged()), this, SLOT(updateWindowGeometry()));
    connect(this, SIGNAL(heightChanged()), this, SLOT(updateWindowGeometry()));

    view()->setResizeMode(QQuickView::SizeRootObjectToView);
    _window->installEventFilter(this);
}

QWindowItem::~QWindowItem()
{
    delete _window;
}

bool QWindowItem::eventFilter(QObject *, QEvent *ev)
{
    switch (ev->type()) {
    case QEvent::Close:
        close();
        return _deleteOnClose;

    case QEvent::Resize: {
        QResizeEvent *rev = static_cast<QResizeEvent *>(ev);
        setSize(rev->size());
        break;
    }

    case QEvent::Move: {
        QMoveEvent *mev = static_cast<QMoveEvent *>(ev);
        setPos(mev->pos());
        break;
    }

    default:
        break;
    }
    return false;
}

void QWindowItem::registerChildWindow(QWindowItem *child) {
    _window->registerChildWindow(child->window());
}

void QWindowItem::updateParentWindow() {
    QQuickItem *p = parentItem();
    while (p) {
        if (QWindowItem *w = qobject_cast<QWindowItem*>(p)) {
            w->registerChildWindow(this);
            return;
        }
        p = p->parentItem();
    }
}

void QWindowItem::componentComplete()
{
    updateParentWindow();
    this->setParentItem(_window->view()->rootObject());
    if (_window->isTopLevel())
        _window->initPosition();
    QQuickItem::componentComplete();
    if (_delayedVisible) {
        setVisible(true);
    }
}

void QWindowItem::updateWindowGeometry()
{
    // Translate the view's root item on the other direction to keep this item in place
    QQuickItem *viewRootItem = _window->view()->rootObject();
    if (viewRootItem) {
        viewRootItem->setX(-x());
        viewRootItem->setY(-y());
    }

    _window->move(x(), y());
    _window->resize(width(), height());
}

void QWindowItem::center()
{
    _window->center();
}

void QWindowItem::moveWindow(int x,int y, int lx, int ly)
{
    QPoint p = _window->mapToGlobal(QPoint(x,y));
    p.setX(p.x() - lx);
    p.setY(p.y() - ly);
    _window->move(p);
}

void QWindowItem::setMinimumHeight(int h)
{
    _window->setMinimumSize(QSize(_window->minimumSize().width(), h));
    if (height() < h)
        setHeight(h);
}

void QWindowItem::setMaximumHeight(int h)
{
    _window->setMaximumSize(QSize(_window->maximumSize().width(), h));
    if (height() > h)
        setHeight(h);
}

void QWindowItem::setMinimumWidth(int w)
{
    _window->setMinimumSize(QSize(w, _window->minimumSize().height()));
    if (width() < w)
        setWidth(w);
}

void QWindowItem::setMaximumWidth(int w)
{
    _window->setMinimumSize(QSize(w, _window->maximumSize().height()));
    if (width() > w)
        setWidth(w);
}

void QWindowItem::setTitle(QString title)
{
    _window->setWindowTitle(title);
    emit titleChanged();
}

void QWindowItem::setVisible(bool visible)
{
    _window->setWindowFlags(_window->windowFlags() | Qt::Window);
    if (visible) {
        if (isComponentComplete()) {
            // avoid flickering when showing the widget,
            // by passing the event loop at least once
            QTimer::singleShot(1, _window, SLOT(show()));
        } else {
            _delayedVisible = true;
        }
    } else {
        _window->hide();
    }
}

void QWindowItem::setWindowDecoration(bool s)
{
    bool visible = _window->isVisible();


    _window->setWindowFlags(s ? _window->windowFlags() & ~Qt::FramelessWindowHint
                              : _window->windowFlags() | Qt::FramelessWindowHint);
    if (visible)
        _window->show();
    emit windowDecorationChanged();
}

void QWindowItem::setModal(bool modal)
{
    bool visible = _window->isVisible();
    _window->hide();
    _window->setWindowModality(modal ? Qt::WindowModal : Qt::NonModal);

    if (visible)
        _window->show();
    emit modalityChanged();
}

void QWindowItem::setDeleteOnClose(bool deleteOnClose)
{
    if (deleteOnClose == _deleteOnClose)
        return;
    _deleteOnClose = deleteOnClose;
    emit deleteOnCloseChanged();
}

void QWindowItem::close()
{
    if (_deleteOnClose)
        deleteLater();
    else
        _window->hide();
}
