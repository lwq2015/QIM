import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles 1.4

ButtonStyle {
    background: Item {
        //  implicitWidth: 80
        Rectangle {
            anchors.fill: parent
            border.width: control.activeFocus ? 2 : 1
            border.color: (control.hovered
                           || (control.checkable
                               && control.checked)) ? "#0078d7" : "#00000000"
            radius: control.checkable ? 1 : 4
            opacity: 0.5

            color: "#00000000" // 正常状态时，无色透明
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: control.pressed ? "#80cccccc" : "#80eeeeee"
                }
                GradientStop {
                    position: 1
                    color: control.pressed ? "#80aaaaaa" : "#80cccccc"
                }
            }
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                console.log(mouse.x, mouse.y)
            }
        }
    }

    label: Item {
        implicitWidth: row.implicitWidth // + (menuDown.visible ? menuDown.width : 0)
        implicitHeight: row.implicitHeight
     //   baselineOffset: row.y + text.y + text.baselineOffset
        Row {
            id: row
            anchors.centerIn: parent
            spacing: 2
            Image {
                source: control.iconSource
                anchors.verticalCenter: parent.verticalCenter
            }
            Text {
                renderType: Settings.isMobile ? Text.QtRendering : Text.NativeRendering
                anchors.verticalCenter: parent.verticalCenter
                text: StyleHelpers.stylizeMnemonics(control.text)
                color: SystemPaletteSingleton.buttonText(control.enabled)
            }
            Image {
                visible: control.menu !== null
                source: "images/arrow-down.png"
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 2
                opacity: control.enabled ? 0.6 : 0.5
            }
        }


    }
}
