import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0

Style {
    id: buttonstyle

    /*! The \l {QtQuick.Controls::}{Button} this style is attached to. */
    readonly property BasicButton control: __control
    /*! The padding between the background and the label components. */
    padding {
        top: 4
        left: 4
        right: 4 + (menu !== null ? Math.round(TextSingleton.implicitHeight * 1.2) : 0)
        bottom: 4
    }

    /*! This defines the background of the button. */
    property Component background: Item {
        property real alpha: normal ? 1.0 : 0.6
        implicitWidth: Math.round(TextSingleton.implicitHeight * 4.5)
        implicitHeight: Math.max(25, Math.round(TextSingleton.implicitHeight * 1.2))
        Rectangle {
            anchors.fill: parent
            border.width: control.activeFocus ? 2 : 1
            border.color: (control.hovered || control.checked) ? "#47b" : (normal ? "#999" : "#00000000")
        //    border.color: control.activeFocus ? "#47b" : "#999"
            radius: 1
            opacity: alpha

            color: normal ? "white" : "#00000000"
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: control.pressed ? Qt.rgba(204/255.0,204/255.0,204/255.0, alpha) : Qt.rgba(238/255.0,238/255.0,238/255.0, alpha)
                }
                GradientStop {
                    position: 1
                    color: control.pressed ? Qt.rgba(170/255.0,170/255.0,170/255.0, alpha) : Qt.rgba(204/255.0,204/255.0,204/255.0, alpha)
                }
            }
        }
        Image {
            id: imageItem
            visible: menu !== null
            source: "images/arrow-down.png"
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 4
            opacity: control.enabled ? 0.6 : 0.5
        }

        Binding {
            target: menu
            property: "__visualItem"
            value: control
        }
        Connections {
            target: __behavior
            property bool showMenu: menu !== null ? contains(mapToItem(imageItem, __behavior.mouseX, __behavior.mouseY)) : false
            onEffectivePressedChanged: {
                if (!Settings.hasTouchScreen && __behavior.effectivePressed && showMenu)
                    menuTimer.start()

            }
            onReleased: {
                if (Settings.hasTouchScreen && __behavior.containsMouse && showMenu)
                    menuTimer.start()
            }
        }

        Timer {
            id: menuTimer
            interval: 10
            onTriggered: {
                __behavior.keyPressed = false
                if (Qt.application.layoutDirection === Qt.RightToLeft)
                    menu.__popup(Qt.rect(control.width, control.height, 0, 0), 0)
                else
                    menu.__popup(Qt.rect(0, control.height, 0, 0), 0)
            }
        }
    }

    /*! This defines the label of the button.  */
    property Component label: Item {
        implicitWidth: row.implicitWidth
        implicitHeight: row.implicitHeight
        baselineOffset: row.y + text.y + text.baselineOffset
        Row {
            id: row
            anchors.centerIn: parent
            spacing: 2
            Image {
                source: control.iconSource
                anchors.verticalCenter: parent.verticalCenter
            }
            Text {
                id: text
                renderType: Settings.isMobile ? Text.QtRendering : Text.NativeRendering
                anchors.verticalCenter: parent.verticalCenter
                text: StyleHelpers.stylizeMnemonics(control.text)
                color: SystemPaletteSingleton.buttonText(control.enabled)
            }
        }
    }

    /*! \internal */
    property Component panel: Item {
        anchors.fill: parent
        implicitWidth: Math.max(labelLoader.implicitWidth + padding.left + padding.right,backgroundLoader.implicitWidth)
        implicitHeight: Math.max(labelLoader.implicitHeight + padding.top + padding.bottom, backgroundLoader.implicitHeight)
        baselineOffset: labelLoader.item ? padding.top + labelLoader.item.baselineOffset : 0

        Loader {
            id: backgroundLoader
            anchors.fill: parent
            sourceComponent: background
        }

        Loader {
            id: labelLoader
            sourceComponent: label
            anchors.fill: parent
            anchors.leftMargin: padding.left
            anchors.topMargin: padding.top
            anchors.rightMargin: padding.right
            anchors.bottomMargin: padding.bottom
        }
    }
}
