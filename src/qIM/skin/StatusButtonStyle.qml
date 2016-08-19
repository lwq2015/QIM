import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles 1.4

Component {
    ButtonStyle {
        background: Rectangle {
        //  implicitWidth: 100
        //  implicitHeight: 25
            border.width: 1
            border.color: control.hovered ? "#0078d7" : "#00000000"
            radius: 4
            opacity: 0.5
            width: control.width
            color:"#00000000"


            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: control.pressed ? "#80cccccc" : "#80eeeeee"
                }
                GradientStop {
                    position: 0
                    color: control.pressed ? "#80aaaaaa" : "#80cccccc"
                }
            }
        }
    }
}


