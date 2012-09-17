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

var sectionData = [];
var _sections = [];

function initialize(list) {
    initSectionData(list);
}

function initSectionData(list) {
    if (!list || !list.model) return;

    // give an ability to provide custom initializers for C++ models
    if (list.customSectionScrollerDataHandler) {
        var ret = list.customSectionScrollerDataHandler();
        sectionData = ret.sectionData;
        _sections = ret._sections;
        return;
    }

    sectionData = [];
    _sections = [];
    var current = "",
        prop = list.section.property,
        item;

    for (var i = 0, count = (typeof list.model.count === 'undefined' ? list.model.length : list.model.count); i < count; i++) {
        item = list.model.get(i);
        if (item[prop] !== current) {
            current = item[prop];
            _sections.push(current);
            sectionData.push({ index: i, header: current });
        }
    }
}

function getSectionPositionString(name) {
    var val = _sections.indexOf(name);
    return val === 0 ? "first" :
           val === _sections.length - 1 ? "last" : false;
}

function getAt(pos) {
    return _sections[pos] ? _sections[pos] : "";
}

function getRelativeSections(current) {
    var val = _sections.indexOf(current),
        sect = [],
        sl = _sections.length;

    val = val < 1 ? 1 : val >= sl-1 ? sl-2 : val;
    sect = [getAt(val - 1), getAt(val), getAt(val + 1)];

    return sect;
}

function getClosestSection(pos, down) {
    var tmp = (_sections.length) * pos;
    var val = Math.ceil(tmp) // TODO: better algorithm
    val = val < 2 ? 1 : val;
    return _sections[val-1];
}

function getNextSection(current) {
    var val = _sections.indexOf(current);
    return (val > -1 ? _sections[(val < _sections.length - 1 ? val + 1 : val)] : _sections[0]) || "";
}

function getPreviousSection(current) {
    var val = _sections.indexOf(current);
    return (val > -1 ? _sections[(val > 0 ? val - 1 : val)] : _sections[0]) || "";
}

function getIndexFor(sectionName) {
    var val = sectionData[_sections.indexOf(sectionName)].index;
    return val === 0 || val > 0 ? val : -1;
}
