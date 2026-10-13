.pragma library

// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

// One content contract is shared by standalone badges and their hosts.
function isValidCount(value) {
    return typeof value === "number" && Number.isSafeInteger(value) && value >= 0;
}

function hasContent(value) {
    return (typeof value === "string" && value.length > 0) || isValidCount(value);
}

function count(value) {
    return isValidCount(value) ? value : -1;
}

function text(value) {
    return typeof value === "string" ? value : "";
}

function accessibleName(destination, badgeDescription) {
    if (badgeDescription.length === 0)
        return destination;
    return destination.length > 0 ? destination + ", " + badgeDescription : badgeDescription;
}
