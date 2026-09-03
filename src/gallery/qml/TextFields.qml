// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Fluid as MD

/*!
    \internal
    \brief Gallery page demonstrating Material 3 text fields.

    The examples cover filled and outlined fields, labels and supporting text,
    affixes, custom leading and trailing content, validation, common input
    states, and right-to-left layout.
*/
Item {
    id: page

    readonly property real compactSpacing: MD.Tokens.measurement.space100
    readonly property real contentSpacing: MD.Tokens.measurement.space200
    readonly property real sectionSpacing: MD.Tokens.measurement.space300

    function cardSpan(columns) {
        if (columns >= 12)
            return 6;
        return Math.min(columns, 4);
    }

    component ShowcaseCard: GalleryCard {
        gridColumns: galleryPage.columns
    }

    GalleryPage {
        id: galleryPage
        anchors.fill: parent
        headline: qsTr("Text fields")
        description: qsTr("Text fields let people enter and edit a single line of text. Choose a filled or outlined container to fit the surrounding hierarchy.")

        ShowcaseCard {
            title: qsTr("Filled and outlined")

            ColumnLayout {
                width: parent.width
                spacing: page.contentSpacing

                MD.TextField {
                    id: firstNameField

                    Layout.fillWidth: true
                    Layout.bottomMargin: galleryPage.columns > page.cardSpan(galleryPage.columns) ? Math.max(0, emailField.implicitHeight - implicitHeight) : 0
                    fieldStyle: MD.TextField.Filled
                    focus: true
                    label: qsTr("First name")
                    placeholderText: qsTr("Enter your first name")
                }

                MD.TextField {
                    Layout.fillWidth: true
                    fieldStyle: MD.TextField.Outlined
                    label: qsTr("Last name")
                    text: qsTr("Rivera")
                }
            }
        }

        ShowcaseCard {
            title: qsTr("Supporting and error text")

            ColumnLayout {
                width: parent.width
                spacing: page.contentSpacing

                MD.TextField {
                    id: emailField

                    Layout.fillWidth: true
                    label: qsTr("Email")
                    placeholderText: qsTr("name@example.com")
                    supportingText: qsTr("We will only use this address for account messages")
                }

                MD.TextField {
                    Layout.fillWidth: true
                    fieldStyle: MD.TextField.Outlined
                    label: qsTr("Username")
                    text: qsTr("already-taken")
                    error: true
                    errorText: qsTr("That username is not available")
                }
            }
        }

        ShowcaseCard {
            title: qsTr("Affixes and custom slots")

            ColumnLayout {
                width: parent.width
                spacing: page.contentSpacing

                MD.TextField {
                    id: profileField

                    Layout.fillWidth: true
                    fieldStyle: MD.TextField.Filled
                    label: qsTr("Profile")
                    prefixText: "@"
                    suffixText: qsTr(".social")
                    text: qsTr("alex")

                    leading: MD.Symbol {
                        name: MD.SymbolNames.symbolPerson
                        color: profileField.leadingContentColor
                    }
                }

                MD.TextField {
                    id: searchField

                    Layout.fillWidth: true
                    fieldStyle: MD.TextField.Outlined
                    label: qsTr("Search")
                    placeholderText: qsTr("Search the gallery")
                    text: qsTr("Material")

                    leading: MD.Symbol {
                        name: MD.SymbolNames.symbolSearch
                        color: searchField.leadingContentColor
                    }

                    trailing: MD.IconButton {
                        text: qsTr("Clear search")
                        type: MD.IconButton.Standard
                        size: MD.IconButton.ExtraSmall
                        icon.name: MD.SymbolNames.symbolClear
                        contentColor: searchField.trailingContentColor
                        disabledContentColor: searchField.trailingContentColor
                        enabled: searchField.text.length > 0
                        onClicked: searchField.clear()
                    }
                }
            }
        }

        ShowcaseCard {
            title: qsTr("Input states")

            ColumnLayout {
                width: parent.width
                spacing: page.contentSpacing

                MD.TextField {
                    Layout.fillWidth: true
                    enabled: false
                    label: qsTr("Disabled")
                    text: qsTr("Unavailable value")
                }

                MD.TextField {
                    Layout.fillWidth: true
                    fieldStyle: MD.TextField.Outlined
                    readOnly: true
                    label: qsTr("Read only")
                    text: qsTr("Account identifier")
                    supportingText: qsTr("This value cannot be edited")
                }

                MD.TextField {
                    id: passwordField

                    Layout.fillWidth: true
                    label: qsTr("Password")
                    text: "material3"
                    echoMode: TextInput.Password

                    leading: MD.Symbol {
                        name: MD.SymbolNames.symbolLock
                        color: passwordField.leadingContentColor
                    }

                    trailing: MD.IconButton {
                        text: passwordField.echoMode === TextInput.Password ? qsTr("Show password") : qsTr("Hide password")
                        type: MD.IconButton.Standard
                        size: MD.IconButton.ExtraSmall
                        icon.name: passwordField.echoMode === TextInput.Password ? MD.SymbolNames.symbolVisibility : MD.SymbolNames.symbolVisibilityOff
                        contentColor: passwordField.trailingContentColor
                        disabledContentColor: passwordField.trailingContentColor
                        onClicked: passwordField.echoMode = passwordField.echoMode === TextInput.Password ? TextInput.Normal : TextInput.Password
                    }
                }
            }
        }

        ShowcaseCard {
            title: qsTr("Validation")

            ColumnLayout {
                width: parent.width
                spacing: page.contentSpacing

                MD.Label {
                    Layout.fillWidth: true
                    text: qsTr("Enter a whole number from 18 through 120 to see validator-driven error feedback.")
                    color: page.MD.Style.onSurfaceVariantColor
                    wrapMode: Text.WordWrap
                }

                MD.TextField {
                    Layout.fillWidth: true
                    fieldStyle: MD.TextField.Outlined
                    label: qsTr("Age")
                    text: "18"
                    inputMethodHints: Qt.ImhDigitsOnly
                    validator: IntValidator {
                        bottom: 18
                        top: 120
                    }
                    error: text.length > 0 && !acceptableInput
                    errorText: qsTr("Enter an age from 18 through 120")
                    supportingText: qsTr("Whole numbers only")
                }
            }
        }

        ShowcaseCard {
            title: qsTr("Right-to-left")

            ColumnLayout {
                width: parent.width
                spacing: page.contentSpacing

                MD.Label {
                    Layout.fillWidth: true
                    text: qsTr("Logical leading and trailing content mirror with the field layout.")
                    color: page.MD.Style.onSurfaceVariantColor
                    wrapMode: Text.WordWrap
                }

                Item {
                    Layout.fillWidth: true
                    implicitHeight: rtlPhoneField.implicitHeight
                    LayoutMirroring.enabled: true
                    LayoutMirroring.childrenInherit: true

                    MD.TextField {
                        id: rtlPhoneField

                        width: parent.width
                        fieldStyle: MD.TextField.Outlined
                        label: qsTr("رقم الهاتف")
                        placeholderText: qsTr("أدخل رقم الهاتف")
                        prefixText: "+971"
                        supportingText: qsTr("سيتم إرسال رمز التحقق إلى هذا الرقم")

                        leading: MD.Symbol {
                            name: MD.SymbolNames.symbolPhone
                            color: rtlPhoneField.leadingContentColor
                        }
                    }
                }
            }
        }
    }
}
