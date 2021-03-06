import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3

ButtonStyle {
    background: Item {
        Rectangle {
            anchors.fill: parent
            border.width: control.activeFocus ? 2 : 1
            border.color: (control.hovered
                           || (control.checkable
                               && control.checked)) ? "#0078d7" : "#00000000"
            radius: 1 //control.checkable ? 1 : 4
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
    }
}
