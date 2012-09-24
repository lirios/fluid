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

function __isSelected( index ){
    return __selectedIndexesHash[index]==true;
}

function __syncHash(){
  var selectedIndexesHash = new Array()
  var il = selectedIndexes.length;
  for( var it = 0; it < il; ++it ){
      selectedIndexesHash[selectedIndexes[it]]=true;
  }
  __selectedIndexesHash = selectedIndexesHash
}

function __toggleIndex( index ){
    // A QML list can not be modified, so let's create a new array
    var selectedArray = new Array;

    var il = selectedIndexes.length;

    // If selectedIndexes is empty then add the index and return.
    if ( il == 0 ){
        selectedArray.push(index);
        selectedIndexes = selectedArray;
        return;
    }

    // Check whether the list is sorted.
    var isSorted = true;
    var previousIndex = -1;

    for( var it = 0; it < il; ++it ){
        if ( previousIndex > selectedIndexes[it] ){
            isSorted = false;
            break;
        }
        previousIndex = selectedIndexes[it];
    }

    if (!isSorted){
        // For unsorted selectedIndexes just append the index if it's not present yet.
        var indexAvailable = false;
        for( var it = 0; it < il; ++it ) {
            if ( index == selectedIndexes[it] ){
                indexAvailable = true;
            }
            else {
                selectedArray.push(selectedIndexes[it]);
            }
        }
        if (!indexAvailable){
            selectedArray.push(index);
        }
    }
    else{
        previousIndex = -1;
        // insert the index in a sorted way in between the existing indexes
        for( var it = 0; it < il; ++it ) {
            if ( previousIndex < index && index < selectedIndexes[it] ) {
                selectedArray.push(index);
            }
            if ( index != selectedIndexes[it] ) {
                selectedArray.push(selectedIndexes[it]);
            }

            previousIndex = selectedIndexes[it];
        }
        // If the index is the highest one append it
        if (index > selectedIndexes[selectedIndexes.length - 1]){
          selectedArray.push(index);
        }
    }
    // Assign the new built array to selectedIndexes
    selectedIndexes = selectedArray;
}
