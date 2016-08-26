import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0

Style {
    id: buttonstyle

    /*! The \l {QtQuick.Controls::}{Button} this style is attached to. */
    readonly property Control control: __control
    /*! The padding between the background and the label components. */
    padding {
        top: 4
        left: 4
        right: 4 + (control.menu !== null ? Math.round(TextSingleton.implicitHeight * 1.2) : 0)
        bottom: 4
    }

    /*! This defines the background of the button. */
    property Component background: Item {
        property real alpha: control.normal ? 1.0 : 0.6
        implicitWidth: Math.max(TextSingleton.implicitHeight * 1.5, control.width)
        implicitHeight: Math.max(TextSingleton.implicitHeight * 1.2, control.height)
        Rectangle {
            anchors.fill: parent
            border.width: control.activeFocus ? 2 : 1
            border.color: (control.hovered || control.checked) ? "#47b" : (control.normal ? "#999" : "#00000000")
            radius: 1
            opacity: alpha
            color: control.normal ? "white" : "#00000000"
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
            property bool empty: !(control.iconSource.length >0 || control.text.length >0)
            visible: control.menu !== null
            source: control.menuSource
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: if (empty) return parent.horizontalCenter
            anchors.right: if (!empty) return parent.right
            anchors.rightMargin: 4
            opacity: control.enabled ? 0.6 : 0.5


        }

        Binding {
            target: control.menu
            property: "__visualItem"
            value: control
        }
        Connections {
            target: control.__behavior
            onEffectivePressedChanged: {
                if (!Settings.hasTouchScreen && control.__behavior.effectivePressed && control.menu &&
                     contains(mapToItem(imageItem, control.__behavior.mouseX, control.__behavior.mouseY)))
                    menuTimer.start()
            }
            onReleased: {
                if (Settings.hasTouchScreen && control.__behavior.containsMouse && control.menu &&
                    contains(mapToItem(imageItem, control.__behavior.mouseX, control.__behavior.mouseY)))
                    menuTimer.start()
            }
        }

        Timer {
            id: menuTimer
            interval: 10
            onTriggered: {
                control.__behavior.keyPressed = false
                if (Qt.application.layoutDirection === Qt.RightToLeft)
                    control.menu.__popup(Qt.rect(control.width, control.height, 0, 0), 0)
                else
                    control.menu.__popup(Qt.rect(0, control.height, 0, 0), 0)
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
