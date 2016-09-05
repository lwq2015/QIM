import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtLocation 5.6

WindowBase {
    id: window
    title: "《Window Title》"
    minimumWidth: 400
    minimumHeight: 300
    property int titlebarSize: 30
    property url logo: "images/qIM.ico"
    property alias client: clientArea
    RowLayout {
        id: titleBar
        height: titlebarSize
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.leftMargin: borderSize
        anchors.topMargin: borderSize
        anchors.rightMargin: borderSize

        Rectangle {
            id: titleBarBackground
            anchors.fill: parent
            color: "gray"
            opacity: 0.3
        }
        Image {
            id: icon
            Layout.maximumWidth: 18
            Layout.maximumHeight: 18
            source: logo
        }

        Label {
            id: title
            font.pointSize: 16
            Layout.fillWidth: true
            Layout.fillHeight: true
            verticalAlignment: Text.AlignVCenter
            text: window.title
        }

        SystemButton {
            onClickedClose: window.close()
            onClickedMin: window.showMinimized()
            onClickedMax: window.showMaximized() // window.showFullScreen()
            onClickedRestore: window.showNormal()
        }
    }

    // 定义一个客户区域，方便使用。
    Item {
        id: clientArea
        anchors {
            left: parent.left
            top: parent.top
            right: parent.right
            bottom: parent.bottom
            margins: borderSize
            topMargin: borderSize + titlebarSize
        }
    }
}
