import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Rectangle {
    anchors.fill: parent
    color: backgroundColor
    ColumnLayout {
        anchors.fill: parent
        // 工具栏部份
        RowLayout {
            Layout.minimumHeight: 80
            Layout.maximumHeight: 80
            Layout.fillWidth: true

            // 工具栏左边部份（标题、签名、工具栏）
            ColumnLayout {
                Layout.fillWidth: true
                Layout.minimumWidth: 200

                Text {
                    id: sessionTitle
                    //   height: 20
                    Layout.fillWidth: true
                    text: "会话标题"
                    font.pointSize: 16
                }
                Text {
                    id: sessionInfo
                    //    height: 16
                    Layout.fillWidth: true
                    text: "显示签名或者群信息"
                }

                RowLayout {
                    spacing: 1

                    Button {
                        id: sendFileButton
                        iconSource: "images/1_sendFileButton.png"
                        tooltip: qsTr("Send file(s)")
                        text: qsTr("Send File")
                    }
                    Button {
                        id: sendSmsButton
                        iconSource: "images/1_sendSmsButton.png"
                        tooltip: qsTr("Send SMS")
                        text: qsTr("Send Sms")
                    }
                    Button {
                        id: inviteButton
                        iconSource: "images/1_inviteButton.png"
                        tooltip: qsTr("Invite")
                        text: qsTr("Invite")
                    }
                    Button {
                        id: addToButton
                        iconSource: "images/1_addToButton.png"
                        tooltip: qsTr("Add to...")
                        text: qsTr("Add To")
                    }
                    Button {
                        id: scheduleButton
                        visible: false
                        iconSource: "images/1_scheduleButton.png"
                        tooltip: qsTr("Schedule")
                        text: qsTr("Schedule")
                    }
                    Button {
                        id: topmostButton
                        visible: false
                        iconSource: "images/1_topmostButton.png"
                        tooltip: qsTr("Topmost")
                        text: qsTr("Topmost")
                    }
                    Button {
                        id: quitSessionButton
                        iconSource: "images/1_quitSessionButton.png"
                        tooltip: qsTr("Quit session")
                        text: qsTr("Quit")
                    }
                }
            }

            // 工具栏右边部份（系统按钮，广告）
            ColumnLayout {
                Layout.minimumWidth: 160
                Layout.maximumWidth: 160
                Layout.fillHeight: true
                Layout.fillWidth: true

                RowLayout {
                    spacing: 0
                    Layout.alignment: Qt.AlignRight
                    Layout.fillWidth: true
                    Layout.minimumHeight: 30
                    Layout.maximumHeight: 30
                    Button {
                        id: systemMinButton
                        iconSource: hovered ? "images/systemMinButtonH.png" : (pressed ? "images/systemMinButtonD.png" : "images/systemMinButton.png")
                    }
                    Button {
                        id: systemMaxButton
                        iconSource: hovered ? "images/systemMaxButtonH.png" : (pressed ? "images/systemMaxButtonD.png" : "images/systemMaxButton.png")
                    }
                    Button {
                        id: systemRestoreButton
                        visible: false
                        iconSource: hovered ? "images/systemRestoreButtonH.png" : (pressed ? "images/systemRestoreButtonD.png" : "images/systemRestoreButton.png")
                    }
                    Button {
                        id: systemCloseButton
                        iconSource: hovered ? "images/systemCloseButtonH.png" : (pressed ? "images/systemCloseButtonD.png" : "images/systemCloseButton.png")
                        onClicked: Qt.quit()
                    }
                }

                Rectangle {
                    id: adButton
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "lightpink"
                    Text {
                        color: "#1bc566"
                        anchors.centerIn: parent
                        font.pointSize: 18
                        text: "欢迎使用QIM"
                        styleColor: "#de2626"
                        font.italic: true
                        font.bold: true
                        style: Text.Raised
                    }
                }
            }
        }

        // 工具栏下面的部份
        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Rectangle {
                color: "red"
                anchors.fill: parent
            }
        }
    }
}
