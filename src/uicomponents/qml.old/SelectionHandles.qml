import QtQuick 2.0
import "." 1.0
import "Utils.js" as Utils
import "EditBubble.js" as Popup
import "SelectionHandles.js" as Private
import "Magnifier.js" as MagnifierPopup

Item {
    id: contents

    // Styling for the Label
    property Style platformStyle: SelectionHandlesStyle{}

    //Deprecated, TODO Remove this some day
    property alias style: contents.platformStyle

    property Item textInput: null

    property variant selectionStartRect: textInput ? textInput.positionToRectangle( textInput.selectionStart ) : Qt.rect(0,0,0,0);
    property variant selectionEndRect: textInput ? textInput.positionToRectangle( textInput.selectionEnd ) : Qt.rect(0,0,0,0);

    property variant selectionStartPoint: Qt.point(0,0)
    property variant selectionEndPoint: Qt.point(0,0)

    property alias leftSelectionHandle: leftSelectionImage
    property alias rightSelectionHandle: rightSelectionImage

    property alias privateRect: rect
    property bool privateIgnoreClose: false

    onSelectionStartRectChanged: Private.adjustPosition(contents)

    onSelectionEndRectChanged: Private.adjustPosition(contents)

    Item {
        id: rect
        objectName: "selectionHandles"
        // fake baseline since the baseline of a font is not accessible in QML (except for anchors which doesn't work well here):
        property int fontBaseLine: textInput ? textInput.font.pixelSize * 0.16 : 0

        z: 1015 // Have the selection handles under the copy-paste bubble

        // Function to calculate whether the handle positions are out of the view area:
        function outOfView( rootX, rootY, offset ) {
            var point = contents.mapToItem( textInput, rootX, rootY );
            return (point.x - offset) < 0 || ( textInput != null  && (point.x - offset) > textInput.width + 5);
        }

        function updateMagnifierPosition( item, posX, posY) {
            if (!textInput) return;
            var magnifier = MagnifierPopup.popup;
            var cursorHeight = textInput.positionToRectangle(0,0).height
            var yAdjustment = - magnifier.height / 2 - cursorHeight - 70;
            var mappedPos =  contents.mapFromItem(item, posX - magnifier.width / 2,
                                       posY);

            magnifier.xCenter = textInput.mapFromItem(item, posX, 0).x;
            magnifier.x = mappedPos.x;
            var minMappedPos = contents.mapFromItem( textInput, 0, 0).y;

            magnifier.yCenter = Math.min( textInput.mapFromItem(item, 0, Math.max(posY, 0)).y, textInput.positionToRectangle( textInput.selectionEnd ).y ) + cursorHeight
            magnifier.y = Math.min( Math.max(mappedPos.y, minMappedPos), minMappedPos + textInput.height )
                          + yAdjustment
            if ( magnifier.y < 0 ) magnifier.y += ( magnifier.height / 3 + cursorHeight - 30 );
        }

        Image {
            id: leftSelectionImage
            objectName: "leftSelectionImage"
              property variant dragStart: Qt.point(0,0); // required for selection across multiple lines
              property int offset: -width/2;
              property int animationDuration: leftSelectionMouseArea.pressed ? 350 : 0
              x: selectionStartPoint.x + offset;
              y: selectionStartPoint.y + contents.selectionStartRect.height - 10 - rect.fontBaseLine; // vertical offset: 4 pixels
              visible: y > Utils.statusBarCoveredHeight( contents )
                    && y < screen.platformHeight - Utils.toolBarCoveredHeight ( contents );
              source: platformStyle.leftSelectionHandle
              property bool pressed: leftSelectionMouseArea.pressed;
              property bool outOfView: rect.outOfView(x, y, offset);
              onXChanged: outOfView = rect.outOfView(x, y, offset)

              MouseArea {
                  id: leftSelectionMouseArea
                  anchors.fill: parent
                  onPressed: {
                      if (Popup.isOpened(textInput)) {
                          Popup.close(textInput);
                      }
                      leftSelectionImage.dragStart = Qt.point( mouse.x, mouse.y );
                      var sourceItem = textInput.parent != undefined ? textInput.parent : textInput
                      MagnifierPopup.open(sourceItem);
                      rect.updateMagnifierPosition(parent,mouse.x,mouse.y)
                  }
                  onPositionChanged: {
                      var pixelpos = mapToItem( textInput, mouse.x, mouse.y );
                      var ydelta = pixelpos.y - leftSelectionImage.dragStart.y;  // Determine the line distance
                      if ( ydelta < 0 ) ydelta = 0;  // Avoid jumpy text selection
                      var pos = textInput.positionAt(pixelpos.x, ydelta);
                      var h = textInput.selectionEnd;
                      privateIgnoreClose = true;    // Avoid closing the handles while setting the cursor position
                      if (pos >= h) {
                          textInput.cursorPosition = h; // proper autoscrolling
                          pos = h - 1;  // Ensure at minimum one character between selection handles
                      }
                      textInput.select(h,pos); // Select by character
                      rect.updateMagnifierPosition(parent,mouse.x,mouse.y)
                      privateIgnoreClose = false;
                  }
                  onReleased: {
                      Popup.enableOffset( false );
                      Popup.open(textInput,textInput.positionToRectangle(textInput.cursorPosition));
                      Popup.enableOffset( Private.handlesIntersectWith(Popup.geometry()) );
                      MagnifierPopup.close();
                  }
                  onExited: {
                      Popup.enableOffset( false );
                      Popup.open(textInput,textInput.positionToRectangle(textInput.cursorPosition));
                      Popup.enableOffset( Private.handlesIntersectWith(Popup.geometry()) );
                      MagnifierPopup.close();
                  }
              }

              states: [
                  State {
                      name: "normal"
                      when: !leftSelectionImage.outOfView && !leftSelectionImage.pressed && !rightSelectionImage.pressed
                      PropertyChanges { target: leftSelectionImage; opacity: 1.0 }
                  },
                  State {
                      name: "pressed"
                      when: !leftSelectionImage.outOfView && leftSelectionImage.pressed
                      PropertyChanges { target: leftSelectionImage; opacity: 0.0 }
                  },
                  State {
                      name: "otherpressed"
                      when: !leftSelectionImage.outOfView && rightSelectionImage.pressed
                      PropertyChanges { target: leftSelectionImage; opacity: 0.7 }
                  },
                  State {
                      name: "outofview"
                      when: leftSelectionImage.outOfView
                      PropertyChanges { target: leftSelectionImage; opacity: 0.0 }
                  }
              ]

              transitions: [
                  Transition {
                      from: "pressed"; to: "normal"
                      NumberAnimation {target: leftSelectionImage; property: "opacity";
                                    easing.type: Easing.InOutQuad;
                                    from: 0.0; to: 1.0; duration: 350}
                  },
                  Transition {
                      from: "normal"; to: "pressed"
                      NumberAnimation {target: leftSelectionImage; property: "opacity";
                                    easing.type: Easing.InOutQuad;
                                    from: 1.0; to: 0.0; duration: 350}
                  },
                  Transition {
                      from: "otherpressed"; to: "normal"
                      NumberAnimation {target: leftSelectionImage; property: "opacity";
                                    easing.type: Easing.InOutQuad;
                                    from: 0.7; to: 1.0; duration: 350}
                  },
                  Transition {
                      from: "normal"; to: "otherpressed"
                      NumberAnimation {target: leftSelectionImage; property: "opacity";
                                    easing.type: Easing.InOutQuad;
                                    from: 1.0; to: 0.7; duration: 350}
                  }
              ]
        }

        Image {
            id: rightSelectionImage
            objectName: "rightSelectionImage"
              property variant dragStart: Qt.point(0,0); // required for selection across multiple lines
              property int offset: -width/2;
              property int animationDuration: rightSelectionMouseArea.pressed ? 350 : 0
              x: selectionEndPoint.x + offset;
              y: selectionEndPoint.y + contents.selectionEndRect.height - 10 - rect.fontBaseLine; // vertical offset: 4 pixels
              visible: y > Utils.statusBarCoveredHeight( contents )
                    && y < screen.platformHeight - Utils.toolBarCoveredHeight ( contents );
              source: platformStyle.rightSelectionHandle;
              property bool pressed: rightSelectionMouseArea.pressed;
              property bool outOfView: rect.outOfView(x, y, offset);
              onXChanged: outOfView = rect.outOfView(x, y, offset);

              MouseArea {
                  id: rightSelectionMouseArea
                  anchors.fill: parent
                  onPressed: {
                      if (Popup.isOpened(textInput)) {
                          Popup.close(textInput);
                      }
                      rightSelectionImage.dragStart = Qt.point( mouse.x, mouse.y );
                      var sourceItem = textInput.parent != undefined ? textInput.parent : textInput
                      MagnifierPopup.open(sourceItem);
                      rect.updateMagnifierPosition(parent,mouse.x,mouse.y)
                  }
                  onPositionChanged: {
                      var pixelpos = mapToItem( textInput, mouse.x, mouse.y );
                      var ydelta = pixelpos.y - rightSelectionImage.dragStart.y;  // Determine the line distance
                      if ( ydelta < 0 ) ydelta = 0;  // Avoid jumpy text selection
                      var pos = textInput.positionAt(pixelpos.x, ydelta);
                      var h = textInput.selectionStart;
                      privateIgnoreClose = true;    // Avoid closing the handles while setting the cursor position
                      if (pos <= h) {
                          textInput.cursorPosition = h; // proper autoscrolling
                          pos = h + 1;  // Ensure at minimum one character between selection handles
                      }
                      textInput.select(h,pos); // Select by character
                      rect.updateMagnifierPosition(parent,mouse.x,mouse.y);
                      privateIgnoreClose = false;            
                 }
                 onReleased: {
                      Popup.enableOffset( false );
                      Popup.open(textInput,textInput.positionToRectangle(textInput.cursorPosition));
                      Popup.enableOffset( Private.handlesIntersectWith(Popup.geometry()) );
                      MagnifierPopup.close();
                 }
                 onExited: {
                     Popup.enableOffset( false );
                     Popup.open(textInput,textInput.positionToRectangle(textInput.cursorPosition));
                     Popup.enableOffset( Private.handlesIntersectWith(Popup.geometry()) );
                     MagnifierPopup.close();
                 }
             }

              states: [
                  State {
                      name: "normal"
                      when:  !rightSelectionImage.outOfView && !leftSelectionImage.pressed && !rightSelectionImage.pressed
                      PropertyChanges { target: rightSelectionImage; opacity: 1.0 }
                  },
                  State {
                      name: "pressed"
                      when:  !rightSelectionImage.outOfView && rightSelectionImage.pressed
                      PropertyChanges { target: rightSelectionImage; opacity: 0.0 }
                  },
                  State {
                      name: "otherpressed"
                      when: !rightSelectionImage.outOfView && leftSelectionImage.pressed
                      PropertyChanges { target: rightSelectionImage; opacity: 0.7 }
                  },
                  State {
                      name: "outofview"
                      when: rightSelectionImage.outOfView
                      PropertyChanges { target: rightSelectionImage; opacity: 0.0 }
                  }
              ]

              transitions: [
                  Transition {
                      from: "pressed"; to: "normal"
                      NumberAnimation {target: rightSelectionImage; property: "opacity";
                                    easing.type: Easing.InOutQuad;
                                    from: 0.0; to: 1.0; duration: 350}
                  },
                  Transition {
                      from: "normal"; to: "pressed"
                      NumberAnimation {target: rightSelectionImage; property: "opacity";
                                    easing.type: Easing.InOutQuad;
                                    from: 1.0; to: 0.0; duration: 350}
                  },
                  Transition {
                      from: "otherpressed"; to: "normal"
                      NumberAnimation {target: rightSelectionImage; property: "opacity";
                                    easing.type: Easing.InOutQuad;
                                    from: 0.7; to: 1.0; duration: 350}
                  },
                  Transition {
                      from: "normal"; to: "otherpressed"
                      NumberAnimation {target: rightSelectionImage; property: "opacity";
                                    easing.type: Easing.InOutQuad;
                                    from: 1.0; to: 0.7; duration: 350}
                  }
              ]
        }
    }

    Connections {
        target: Utils.findFlickable(textInput)
        onContentXChanged: Private.adjustPosition(contents)
        onContentYChanged: {
            Popup.enableOffset( false );
            Popup.enableOffset( Private.handlesIntersectWith(Popup.geometry()) );
            Private.adjustPosition(contents)
        }
    }

    Connections {
        target: screen
        onCurrentOrientationChanged: {
            Popup.enableOffset( false );
            Popup.enableOffset( Private.handlesIntersectWith(Popup.geometry()) );
            Private.adjustPosition(contents)
        }
    }

    function findWindowRoot() {
        var item = Utils.findRootItem(contents, "windowRoot");
        if (item.objectName != "windowRoot")
            item = Utils.findRootItem(contents, "pageStackWindow");
        return item;
    }

    Connections {
       target: findWindowRoot();
       ignoreUnknownSignals: true
       onOrientationChangeFinished: {
           Popup.enableOffset( false );
           Popup.enableOffset( Private.handlesIntersectWith(Popup.geometry()) );
           Private.adjustPosition(contents)
       }
    }

    state: "closed"

    states: [
        State {
            name: "opened"
            ParentChange { target: rect; parent: Utils.findRootItem(textInput); }
            PropertyChanges { target: rect; visible: true; }
        },
        State {
            name: "closed"
            ParentChange { target: rect; parent: contents; }
            PropertyChanges { target: rect; visible: false; }
        }
    ]

    transitions: [
        Transition {
            from: "closed"; to: "opened"
            NumberAnimation {target: rect; property: "opacity";
                          easing.type: Easing.InOutQuad;
                          from: 0.0; to: 1.0; duration: 350}
        },
        Transition {
            from: "opened"; to: "closed"
            NumberAnimation {target: rect; property: "opacity";
                          easing.type: Easing.InOutQuad;
                          from: 1.0; to: 0.0; duration: 350}
        }
    ]
}
