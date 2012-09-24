/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
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

// The PageStack item defines a container for pages and a stack-based
// navigation model. Pages can be defined as QML items or components.

import QtQuick 2.0
import "." 1.0
import "PageStack.js" as Engine

Item {
    id: root

    width: parent ? parent.width : 0
    height: parent ? parent.height : 0

    // Page stack depth.
    property int depth: Engine.getDepth()

    // The currently active page.
    property Item currentPage: null

    // The application tool bar.
    property ToolBar toolBar

    // Indicates whether there is an ongoing page transition.
    property bool busy: __ongoingTransitionCount > 0

    // The number of ongoing transitions.
    property int __ongoingTransitionCount: 0

    // Pushes a page on the stack.
    // The page can be defined as a component, item or string.
    // If an item is used then the page will get re-parented.
    // If a string is used then it is interpreted as a url that is used to load a page component.
    //
    // The page can also be given as an array of pages. In this case all those pages will be pushed
    // onto the stack. The items in the stack can be components, items or strings just like for single
    // pages. Additionally an object can be used, which specifies a page and an optional properties
    // property. This can be used to push multiple pages while still giving each of them properties.
    // When an array is used the transition animation will only be to the last page.
    //
    // The properties argument is optional and allows defining a map of properties to set on the page.
    // If the immediate argument is true then no transition animation is performed.
    // Returns the page instance.
    function push(page, properties, immediate) {
        return Engine.push(page, properties, false, immediate);
    }

    // Pops a page off the stack.
    // If page is specified then the stack is unwound to that page; null to unwind the to first page.
    // If the immediate argument is true then no transition animation is performed.
    // Returns the page instance that was popped off the stack.
    function pop(page, immediate) {
        return Engine.pop(page, immediate);
    }

    // Replaces a page on the stack.
    // See push() for details.
    function replace(page, properties, immediate) {
        return Engine.push(page, properties, true, immediate);
    }

    // Clears the page stack.
    function clear() {
        return Engine.clear();
    }

    // Iterates through all pages (top to bottom) and invokes the specified function.
    // If the specified function returns true the search stops and the find function
    // returns the page that the iteration stopped at. If the search doesn't result
    // in any page being found then null is returned.
    function find(func) {
        return Engine.find(func);
    }
    
    // Called when the page stack visibility changes.
    onVisibleChanged: {
        if (currentPage) {
            __setPageStatus(currentPage, visible ? PageStatus.Active : PageStatus.Inactive);
            if (visible) {
                currentPage.visible = currentPage.parent.visible = true;
            }
        }
    }

    // Sets the page status.
    function __setPageStatus(page, status) {
        if (page.status !== undefined) {
            if (status == PageStatus.Active && page.status == PageStatus.Inactive) {
                page.status = PageStatus.Activating;
            } else if (status == PageStatus.Inactive && page.status == PageStatus.Active) {
                page.status = PageStatus.Deactivating;
            }
            page.status = status;
        }
    }

    // Component for page containers.
    Component {
        id: containerComponent

        Item {
            id: container

            width: parent ? parent.width : 0
            height: parent ? parent.height : 0

            // The states correspond to the different possible positions of the container.
            state: "hidden"

            // The page held by this container.
            property Item page: null
            
            // The owner of the page.
            property Item owner: null

            // Duration of transition animation (in ms)
            property int transitionDuration: 500

            // Flag that indicates the container should be cleaned up after the transition has ended.
            property bool cleanupAfterTransition: false

            // Performs a push enter transition.
            function pushEnter(replace, immediate) {
                if (!immediate) {
                    state = replace ? "front" : "right";
                }
                state = "";
                page.visible = true;
                if (root.visible && immediate) {
                    __setPageStatus(page, PageStatus.Active);
                }
            }

            // Performs a push exit transition.
            function pushExit(replace, immediate) {
                state = immediate ? "hidden" : (replace ? "back" : "left");
                if (root.visible && immediate) {
                    __setPageStatus(page, PageStatus.Inactive);
                }
                if (replace) {
                    if (immediate) {
                        cleanup();
                    } else {
                        cleanupAfterTransition = true;
                    }
                }
            }

            // Performs a pop enter transition.
            function popEnter(immediate) {
                if (!immediate) {
                    state = "left";
                }
                state = "";
                page.visible = true;
                if (root.visible && immediate) {
                    __setPageStatus(page, PageStatus.Active);
                }
            }

            // Performs a pop exit transition.
            function popExit(immediate) {
                state = immediate ? "hidden" : "right";
                if (root.visible && immediate) {
                    __setPageStatus(page, PageStatus.Inactive);
                }
                if (immediate) {
                    cleanup();
                } else {
                    cleanupAfterTransition = true;
                }
            }
            
            // Called when a transition has started.
            function transitionStarted() {
                __ongoingTransitionCount++;
                if (root.visible) {
                    __setPageStatus(page, (state == "") ? PageStatus.Activating : PageStatus.Deactivating);
                }
            }
            
            // Called when a transition has ended.
            function transitionEnded() {
                if (state != "") {
                    state = "hidden";
                }
                if (root.visible) {
                    __setPageStatus(page, (state == "") ? PageStatus.Active : PageStatus.Inactive);
                }
                __ongoingTransitionCount--;
                if (cleanupAfterTransition) {
                    cleanup();
                }
            }

            states: [
                // Explicit properties for default state.
                State {
                    name: ""
                    PropertyChanges { target: container; visible: true }
                },
                // Start state for pop entry, end state for push exit.
                State {
                    name: "left"
                    PropertyChanges { target: container; x: -width }
                },
                // Start state for push entry, end state for pop exit.
                State {
                    name: "right"
                    PropertyChanges { target: container; x: width }
                },
                // Start state for replace entry.
                State {
                    name: "front"
                    PropertyChanges { target: container; scale: 1.5; opacity: 0.0 }
                },
                // End state for replace exit.
                State {
                    name: "back"
                    PropertyChanges { target: container; scale: 0.5; opacity: 0.0 }
                },
                // Inactive state.
                State {
                    name: "hidden"
                    PropertyChanges { target: container; visible: false }
                }
            ]

            transitions: [
                // Pop entry and push exit transition.
                Transition {
                    from: ""; to: "left"; reversible: true
                    SequentialAnimation {
                        ScriptAction { script: if (state == "left") { transitionStarted(); } else { transitionEnded(); } }
                        PropertyAnimation { properties: "x"; easing.type: Easing.InOutExpo; duration: transitionDuration }
                        ScriptAction { script: if (state == "left") { transitionEnded(); } else { transitionStarted(); } }
                    }
                },
                // Push entry and pop exit transition.
                Transition {
                    from: ""; to: "right"; reversible: true
                    SequentialAnimation {
                        ScriptAction { script: if (state == "right") { transitionStarted(); } else { transitionEnded(); } }
                        PropertyAnimation { properties: "x"; easing.type: Easing.InOutExpo; duration: transitionDuration }
                        ScriptAction { script: if (state == "right") { transitionEnded(); } else { transitionStarted(); } }
                    }
                },
                // Replace entry transition.
                Transition {
                    from: "front"; to: "";
                    SequentialAnimation {
                        ScriptAction { script: transitionStarted(); }
                        PropertyAnimation { properties: "scale,opacity"; easing.type: Easing.InOutExpo; duration: transitionDuration }
                        ScriptAction { script: transitionEnded(); }
                    }
                },
                // Replace exit transition.
                Transition {
                    from: ""; to: "back";
                    SequentialAnimation {
                        ScriptAction { script: transitionStarted(); }
                        PropertyAnimation { properties: "scale,opacity"; easing.type: Easing.InOutExpo; duration: transitionDuration }
                        ScriptAction { script: transitionEnded(); }
                   }
                }
            ]
            
            // Cleans up the container and then destroys it.
            function cleanup() {
                if (page.status == PageStatus.Active) {
                    __setPageStatus(page, PageStatus.Inactive);
                }
                if (owner != container) {
                    // container is not the owner of the page - re-parent back to original owner
                    page.visible = false;
                    page.parent = owner;
                }
                container.destroy();
            }

        }
    }

}

