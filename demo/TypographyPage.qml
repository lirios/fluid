 /*
  * Fluid - QtQuick components for fluid and dynamic applications
  *
  * Copyright (C) 2016 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
  *
  * This Source Code Form is subject to the terms of the Mozilla Public
  * License, v. 2.0. If a copy of the MPL was not distributed with this
  * file, You can obtain one at http://mozilla.org/MPL/2.0/.
  */

import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import Fluid.Controls 1.0

Page {
    title: "Typography"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 8

        DisplayLabel {
            level: 4
            text: "Display 4"
        }

        DisplayLabel {
            level: 3
            text: "Display 3"
        }

        DisplayLabel {
            level: 2
            text: "Display 2"
        }

        DisplayLabel {
            level: 1
            text: "Display 1"
        }

        HeadlineLabel {
            text: "Headline"
        }

        TitleLabel {
            text: "Title"
        }

        SubheadingLabel {
            text: "Subheading"
        }

        BodyLabel {
            level: 2
            text: "Body 2"
        }

        BodyLabel {
            level: 1
            text: "Body 1"
        }

        CaptionLabel {
            text: "Caption"
        }

        Label {
            text: "Label"
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
