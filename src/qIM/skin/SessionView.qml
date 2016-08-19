import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Rectangle {
    anchors.fill: parent
    ColumnLayout {
        anchors.fill: parent
        // 工具栏部份
        RowLayout {
            Layout.minimumHeight: 80
            Layout.maximumHeight: 80
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.right

            // 工具栏左边部份（标题、签名、工具栏）
            ColumnLayout {
                Layout.fillWidth: true
                Layout.minimumWidth: 200
                anchors.margins: 40
             //   Layout.fillHeight: true
                Text {
                    id: sessionTitle
                    height: 20
                    Layout.fillWidth: true
                    text: "会话标题"
                    font.pointSize: 16
                }
                Text {
                    id: sessionInfo
                    height: 16
                    Layout.fillWidth: true
                    text: "显示签名或者群信息"
                }

                RowLayout {
                    id: sessionToolbar
                    Layout.minimumWidth: 400
                    Layout.fillWidth: true
                    Layout.fillHeight: true

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
                        text:qsTr("Add To")
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
                        text:qsTr("Quit")
                    }
                }
            }

            // 工具栏右边部份（系统按钮，广告）
            ColumnLayout {
             //   width: 200
             //   Layout.fillHeight: true
                Layout.minimumWidth: 160
                Layout.maximumWidth: 160

                RowLayout{
                    Layout.alignment: Qt.AlignRight
                    Layout.fillWidth: true
                    Layout.minimumHeight: 30
                    Layout.maximumHeight: 30
                    Button{
                        id: systemMinButton
                        iconSource: {
                            if ( hovered )
                                return "images/systemMinButtonH.png"

                            if (pressed)
                                return "images/systemMinButtonD.png"

                            return "images/systemMinButton.png"
                        }

                    }
                    Button{
                        id: systemMaxButton
                        iconSource: {
                            if ( hovered )
                                return "images/systemMaxButtonH.png"

                            if (pressed)
                                return "images/systemMaxButtonD.png"

                            return "images/systemMaxButton.png"
                        }
                    }
                    Button{
                        id: systemRestoreButton
                        visible: false
                        iconSource: {
                            if ( hovered )
                                return "images/systemRestoreButtonH.png"

                            if (pressed)
                                return "images/systemRestoreButtonD.png"

                            return "images/systemRestoreButton.png"
                        }
                    }
                    Button{
                        id: systemCloseButton
                        iconSource: {
                            if ( hovered )
                                return "images/systemCloseButtonH.png"

                            if (pressed)
                                return "images/systemCloseButtonD.png"

                            return "images/systemCloseButton.png"
                        }
                    }
                }

                Rectangle{
                    id: adButton
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "green"
                }
            }

        }

        // 工具栏下面的部份
        RowLayout {
           Layout.fillWidth: true
           Layout.fillHeight: true

            Rectangle{
                color: "red"
                anchors.fill: parent
            }
        }
    }
}
