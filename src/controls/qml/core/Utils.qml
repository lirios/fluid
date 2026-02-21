// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma Singleton

import QtQml

QtObject {
    function scale(percent: real, start: real, end: real): real {
        return start + ((end - start) * (percent / 100));
    }
}
