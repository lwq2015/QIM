import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtWebEngine 1.3

Rectangle {
    anchors.fill: parent
    color: backgroundColor
    property url rightViewName: "SessionRightSingle.qml"
    BorderImage {
        id: sessionBackground
        anchors.fill: parent
        //      opacity: 0.25 // 背景图片透明度小些，才能使前面控件图片的锯齿问题降低
        source: "images/background.png" // 会话窗口背景图片
        Rectangle {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: "#80ffffff"
                }
                GradientStop {
                    position: 0.3
                    color: "#c0ffffff"
                }
                GradientStop {
                    position: 1.0
                    color: "#ffffffff"
                }
            }
        }
    }

    ColumnLayout {
        spacing: 0
        anchors.fill: parent
        // 工具栏部份
        RowLayout {
            //            id: sessionToolbar
            Layout.minimumHeight: 72
            Layout.maximumHeight: 72
            Layout.fillWidth: true

            // 工具栏左边部份（标题、签名、工具栏）
            ColumnLayout {
                Layout.fillWidth: true
                Layout.minimumWidth: 200
                Layout.leftMargin: 6

                Text {
                    id: sessionTitle
                    //   height: 20
                    Layout.fillWidth: true
                    text: qsTr("Session Title")
                    font.pointSize: 16
                }
                Text {
                    id: sessionInfo
                    Layout.fillWidth: true
                    text: qsTr("Display sign or session information")
                }

                RowLayout {
                    id: sessionToolbar
                    spacing: 0

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
                        text: qsTr("Sms")
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
                        text: qsTr("Add to")
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
                Layout.minimumWidth: 164
                Layout.maximumWidth: 164
                Layout.fillHeight: true
                Layout.fillWidth: true
                spacing: 0

                SystemButton {
                    id: systemButtons
                    visableTrigger: true
                    visiableMenu: true
                    systemMenu: Menu {
                        MenuItem {
                            text: qsTr("Help")
                        }
                        MenuItem {
                            text: qsTr("Setting")
                        }
                    }

                    onRightTriggerChanged: {
                        rightView.visible = rightTrigger ? false : true
                        if (rightViewName.toString().length == 0
                                && rightView.visible == true) {
                            rightViewName = "SessionRightSingle.qml"
                        }
                    }

                    onClickedClose: Qt.quit()
                }

                Rectangle {
                    id: adButton
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "lightpink"
                    Text {
                        color: "#1bc566"
                        anchors.centerIn: parent
                        font.pointSize: 16
                        text: qsTr("Welcome to QIM")
                        styleColor: "#de2626"
                        font.italic: true
                        font.bold: true
                        style: Text.Raised
                    }
                }
            }
        }
        HLine {
        }
        // 工具栏下面的部份
        // 使用SplitView为了使其拖动sendToolbar可以改变收发窗口的高度
        RowLayout {
            // 左右：会话左边，会话右边的个人信息、历史记录、群成员等
            spacing: 0
            ColumnLayout {
                // 上下：消息接收窗口，消息发送窗口
                SplitView {
                    orientation: Qt.Vertical
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    handleDelegate: Rectangle {
                        width: 1
                        height: 2
                        HLine {
                        }
                    }

                    WebEngineView {
                        id: recvMsgView
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        url: "http://news.baidu.com/"
                        z: 1
                    }

                    ColumnLayout {
                        spacing: 0
                        Layout.minimumHeight: 60
                        Layout.maximumHeight: 340
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        RowLayout {
                            id: sendToolbar
                            spacing: 1
                            Layout.minimumHeight: 28
                            Layout.maximumHeight: 28
                            Layout.fillWidth: true

                            Button {
                                id: sendbarFont
                                iconSource: "images/1_sendbarFont.png"
                                checkable: true
                                text: qsTr("Font")
                                tooltip: qsTr("Font color and format")
                                style: StatusButtonStyle {
                                }
                            }

                            ToolButton {
                                id: sendbarEmot
                                iconSource: "images/1_sendbarEmot.png"
                                checkable: true
                                text: qsTr("Face")
                                tooltip: qsTr("Choose Emoticons")
                                style: StatusButtonStyle {
                                }
                            }

                            ToolButton {
                                id: senbarScreenshot
                                iconSource: "images/1_sendbarScreenshot.png"
                                text: qsTr("Capture")
                                tooltip: qsTr("Capture")
                                style: StatusButtonStyle {
                                }
                            }

                            ToolButton {
                                id: sendbarImage
                                iconSource: "images/1_sendbarImage.png"
                                text: qsTr("Image")
                                tooltip: qsTr("Choose Image(s)")
                                style: StatusButtonStyle {
                                }
                            }

                            ToolButton {
                                id: sendbarPin
                                iconSource: checked ? "images/1_sendbarPinSel.png" : "images/1_sendbarPin.png"
                                checkable: true
                                text: qsTr("Pin")
                                tooltip: qsTr("Pin Message")
                                style: StatusButtonStyle {
                                }
                            }

                            ToolButton {
                                id: sendbarShield
                                iconSource: checked ? "images/1_sendbarShieldSel.png" : "images/1_sendbarShield.png"
                                checkable: true
                                text: qsTr("Shield")
                                tooltip: qsTr("Shield New Message(s)")
                                style: StatusButtonStyle {
                                }
                            }

                            ToolButton {
                                id: sendbarCleanup
                                iconSource: "images/1_sendbarCleanup.png"
                                text: qsTr("Clear")
                                tooltip: qsTr("Clear")
                                style: StatusButtonStyle {
                                }
                            }

                            Item {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                            }

                            MenuButton {
                                id: sendbarHistorys
                                text: qsTr("History")
                                iconSource: "images/1_sendbarHistory.png"
                                tooltip: qsTr("Show Message History")
                                normal: false
                                menu: Menu {
                                    MenuItem {
                                        text: qsTr("Show message history")
                                    }

                                    MenuSeparator {
                                    }

                                    MenuItem {
                                        text: qsTr("Clear")
                                    }

                                    MenuItem {
                                        text: qsTr("Message manager")
                                    }
                                }

                                onClicked: {
                                    console.log("sendbarHistorys menu clicked")
                                }
                            }
                        }

                        TextEdit {
                            id: sendMsgEdit
                            Layout.preferredHeight: 120
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            // color: "azure"
                            wrapMode: TextEdit.Wrap
                            selectByMouse: true
                            selectByKeyboard: true
                            textFormat: TextEdit.RichText
                            text: "<b>Hello</b> <i>World!</i> This s a test send textaaaaaaaaa aaaaaaaaaaaaaa aaaaaaaaaaaaaa aaaaaaaaaaaaa aaaaaaaaaaaaaa This s a test send textaaaaaaaaa aaaaaaaaaaaaaa aaaaaaaaaaaaaa aaaaaaaaaaaaa aaaaaaaaaaaaaa"
                        }
                    }
                }

                // 最下面的一栏
                RowLayout {
                    id: sendFootbar
                    Layout.minimumHeight: 30
                    Layout.maximumHeight: 30
                    Layout.fillWidth: true
                    Layout.margins: 4

                    Text {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        verticalAlignment: Text.AlignBottom
                        color: "royalblue"
                        text: qsTr("[AD]Let's open the QML world")
                    }

                    Button {
                        id: sessionClose
                        Layout.fillHeight: true
                        text: qsTr("Close")
                        tooltip: qsTr("Close Current Session")
                    }

                    MenuButton {
                        id: sessionSendMsg
                        width: 80
                        height: 28
                        text: qsTr("Send")
                        tooltip: qsTr("Send Message")
                        menu: Menu {
                            MenuItem {
                                text: qsTr(
                                          "Enter as hotkey for sending message")
                            }

                            MenuItem {
                                text: qsTr("Ctrl+Enter as hotkey for sending message")
                            }
                        }
                    }
                }
            }

            VLine {
            }

            // 动态加载右侧边栏信息: 会话右边的个人信息、历史记录、群成员等
            Loader {
                id: rightView
                Layout.minimumWidth: 164
                Layout.maximumWidth: 360
                Layout.fillHeight: true
                source: rightViewName
                onStatusChanged: {
                    if (status === Loader.Error)
                        console.error("Failed to load right view")
                }
            }
        }
    }
}
