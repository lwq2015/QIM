import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Rectangle {
    anchors.fill: parent
    color: backgroundColor
    BorderImage {
        id: sessionBackground
        border {
            left: 2
            top: 80
            right: 2
            bottom: 2
        }
        anchors.fill: parent
        opacity: 0.25 // 背景图片透明度小些，才能使前面控件图片的锯齿问题降低
        source: "images/background.jpg" // 会话窗口背景图片
    }

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
                        antialiasing: true
                        style: StatusButtonStyle {
                        }
                    }
                    Button {
                        id: sendSmsButton
                        iconSource: "images/1_sendSmsButton.png"
                        tooltip: qsTr("Send SMS")
                        text: qsTr("Send Sms")
                        style: StatusButtonStyle {
                        }
                    }
                    Button {
                        id: inviteButton
                        iconSource: "images/1_inviteButton.png"
                        tooltip: qsTr("Invite")
                        text: qsTr("Invite")
                        style: StatusButtonStyle {
                        }
                    }
                    Button {
                        id: addToButton
                        iconSource: "images/1_addToButton.png"
                        tooltip: qsTr("Add to...")
                        text: qsTr("Add To")
                        style: StatusButtonStyle {
                        }
                    }
                    Button {
                        id: scheduleButton
                        visible: false
                        iconSource: "images/1_scheduleButton.png"
                        tooltip: qsTr("Schedule")
                        text: qsTr("Schedule")
                        style: StatusButtonStyle {
                        }
                    }
                    Button {
                        id: topmostButton
                        visible: false
                        iconSource: "images/1_topmostButton.png"
                        tooltip: qsTr("Topmost")
                        text: qsTr("Topmost")
                        style: StatusButtonStyle {
                        }
                    }
                    Button {
                        id: quitSessionButton
                        iconSource: "images/1_quitSessionButton.png"
                        tooltip: qsTr("Quit session")
                        text: qsTr("Quit")
                        style: StatusButtonStyle {
                        }
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
                    Layout.minimumHeight: 30
                    Layout.maximumHeight: 30
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignRight
                    // 使用 '||' 重新格式化会换行，使用 '+' 是一样的效果
                    Button {
                        id: systemMenuButton
                        anchors.top: parent.top
                        iconSource: "images/systemMenuButton.png"
                        style: StatusButtonStyle {
                        }
                    }
                    Button {
                        id: systemMinButton
                        anchors.top: parent.top
                        iconSource: (hovered + pressed) ? "images/systemMinButtonH.png" : "images/systemMinButton.png"
                        style: StatusButtonStyle {
                        }
                    }
                    Button {
                        id: systemMaxButton
                        anchors.top: parent.top
                        iconSource: (hovered + pressed) ? "images/systemMaxButtonH.png" : "images/systemMaxButton.png"
                        style: StatusButtonStyle {
                        }
                    }
                    Button {
                        id: systemRestoreButton
                        anchors.top: parent.top
                        visible: false
                        iconSource: (hovered + pressed) ? "images/systemRestoreButtonH.png" : "images/systemRestoreButton.png"
                        style: StatusButtonStyle {
                        }
                    }
                    Button {
                        id: systemCloseButton
                        anchors.top: parent.top
                        iconSource: (hovered + pressed) ? "images/systemCloseButtonH.png" : "images/systemCloseButton.png"
                        style: StatusButtonStyle {
                        }
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
                color: "lightblue"
                opacity: 0.6
                anchors.fill: parent
            }
        }
    }
}
