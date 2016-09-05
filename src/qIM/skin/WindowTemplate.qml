import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

WindowImpl {
    ColumnLayout {
        // 顶层的Layout，需要使用client 进行定位到客户区域
        anchors.fill: client

        Button {
            anchors.top: parent.top
            text: "测试按钮<左上角>"
        }
        Button {
            anchors.top: parent.top
            anchors.right: parent.right
            text: "测试按钮<右上角>"
        }
        Button {
            anchors.centerIn: parent
            text: "测试按钮<中心位置>"
        }
        Button {
            anchors.bottom: parent.bottom
            text: "测试按钮<左下角>"
        }
        Button {
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            text: "测试按钮<右下角>"
        }
    }
}
