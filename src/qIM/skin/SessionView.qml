import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtWebEngine 1.3

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

    Component {
        // 无正常状态的按钮
        id: statusButtonStyle
        ButtonStyle {
            background: Rectangle {
                border.width: control.activeFocus ? 2 : 1
                readonly property bool bordered: control.hovered
                                                 || (control.checkable
                                                     && control.checked)
                border.color: bordered ? "#0078d7" : "#00000000"
                radius: control.checkable ? 1 : 4
                opacity: 0.5
                color: "#00000000" // 正常状态时，无色透明
                gradient: Gradient {
                    GradientStop {
                        position: 0
                        color: bordered ? "#80cccccc" : "#80eeeeee"
                    }
                    GradientStop {
                        position: 1
                        color: bordered ? "#80aaaaaa" : "#80cccccc"
                    }
                }
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        // 工具栏部份
        RowLayout {
            id: sessionToolbar
            Layout.minimumHeight: 80
            Layout.maximumHeight: 80
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
                    spacing: 0

                    Button {
                        id: sendFileButton
                        iconSource: "images/1_sendFileButton.png"
                        tooltip: qsTr("Send file(s)")
                        text: qsTr("Send File")
                        antialiasing: true
                        style: statusButtonStyle
                    }
                    Button {
                        id: sendSmsButton
                        iconSource: "images/1_sendSmsButton.png"
                        tooltip: qsTr("Send SMS")
                        text: qsTr("Send Sms")
                        style: statusButtonStyle
                    }
                    Button {
                        id: inviteButton
                        iconSource: "images/1_inviteButton.png"
                        tooltip: qsTr("Invite")
                        text: qsTr("Invite")
                        style: statusButtonStyle
                    }
                    Button {
                        id: addToButton
                        iconSource: "images/1_addToButton.png"
                        tooltip: qsTr("Add to...")
                        text: qsTr("Add To")
                        style: statusButtonStyle
                    }
                    Button {
                        id: scheduleButton
                        visible: false
                        iconSource: "images/1_scheduleButton.png"
                        tooltip: qsTr("Schedule")
                        text: qsTr("Schedule")
                        style: statusButtonStyle
                    }
                    Button {
                        id: topmostButton
                        visible: false
                        iconSource: "images/1_topmostButton.png"
                        tooltip: qsTr("Topmost")
                        text: qsTr("Topmost")
                        style: statusButtonStyle
                    }
                    Button {
                        id: quitSessionButton
                        iconSource: "images/1_quitSessionButton.png"
                        tooltip: qsTr("Quit session")
                        text: qsTr("Quit")
                        style: statusButtonStyle
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
                        style: statusButtonStyle
                    }
                    Button {
                        id: systemMinButton
                        anchors.top: parent.top
                        iconSource: (hovered + pressed) ? "images/systemMinButtonH.png" : "images/systemMinButton.png"
                        style: statusButtonStyle
                    }
                    Button {
                        id: systemMaxButton
                        anchors.top: parent.top
                        iconSource: (hovered + pressed) ? "images/systemMaxButtonH.png" : "images/systemMaxButton.png"
                        style: statusButtonStyle
                    }
                    Button {
                        id: systemRestoreButton
                        anchors.top: parent.top
                        visible: false
                        iconSource: (hovered + pressed) ? "images/systemRestoreButtonH.png" : "images/systemRestoreButton.png"
                        style: statusButtonStyle
                    }
                    Button {
                        id: systemCloseButton
                        anchors.top: parent.top
                        iconSource: (hovered + pressed) ? "images/systemCloseButtonH.png" : "images/systemCloseButton.png"
                        style: statusButtonStyle
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
        // 使用SplitView为了使其拖动sendToolbar可以改变收发窗口的高度
        SplitView {
            orientation: Qt.Vertical
            Layout.fillWidth: true
            Layout.fillHeight: true
            handleDelegate: Item {
                width: 1
                height: 2
            }

            WebEngineView {
                id: recvMsgView
                Layout.fillHeight: true
                Layout.fillWidth: true
                url: "http://news.baidu.com/"
            }

            ColumnLayout {
                spacing: 0
                Layout.minimumHeight: 138
                Layout.maximumHeight: 358
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
                        style: statusButtonStyle
                    }

                    ToolButton {
                        id: sendbarEmot
                        iconSource: "images/1_sendbarEmot.png"
                        checkable: true
                        text: qsTr("Emoticon")
                        tooltip: qsTr("Choose Emoticons")
                        style: statusButtonStyle
                    }

                    ToolButton {
                        id: senbarScreenshot
                        iconSource: "images/1_sendbarScreenshot.png"
                        text: qsTr("Screenshot")
                        tooltip: qsTr("Screenshot")
                        style: statusButtonStyle
                    }

                    ToolButton {
                        id: sendbarImage
                        iconSource: "images/1_sendbarImage.png"
                        text: qsTr("Image")
                        tooltip: qsTr("Choose Image(s)")
                        style: statusButtonStyle
                    }

                    ToolButton {
                        id: sendbarPin
                        iconSource: checked ? "images/1_sendbarPinSel.png" : "images/1_sendbarPin.png"
                        checkable: true
                        text: qsTr("Pin")
                        tooltip: qsTr("Pin Message")
                        style: statusButtonStyle
                    }

                    ToolButton {
                        id: sendbarShield
                        iconSource: checked ? "images/1_sendbarShieldSel.png" : "images/1_sendbarShield.png"
                        checkable: true
                        text: qsTr("Shield")
                        tooltip: qsTr("Shield New Message(s)")
                        style: statusButtonStyle
                    }

                    ToolButton {
                        id: sendbarCleanup
                        iconSource: "images/1_sendbarCleanup.png"
                        text: qsTr("Clear")
                        tooltip: qsTr("Clear")
                        style: statusButtonStyle
                    }

                    Item {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }

                    Button {
                        id: sendbarHistory
                        iconSource: "images/1_sendbarHistory.png"
                        text: qsTr("History")
                        tooltip: qsTr("Show Message History")
                        style: statusButtonStyle
                    }
                }

                TextEdit {
                    id: sendMsgEdit
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "azure"
                    wrapMode: TextEdit.Wrap
                    selectByMouse: true
                    selectByKeyboard: true
                    textFormat: TextEdit.RichText
                    text: "This s a test send textaaaaaaaaa aaaaaaaaaaaaaa aaaaaaaaaaaaaa aaaaaaaaaaaaa aaaaaaaaaaaaaa This s a test send textaaaaaaaaa aaaaaaaaaaaaaa aaaaaaaaaaaaaa aaaaaaaaaaaaa aaaaaaaaaaaaaa"
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
                verticalAlignment:  Text.AlignBottom
                color: "royalblue"
                text: "[广告]让我们开启QML之旅吧"
            }

            Button {
                id: sessionClose
                Layout.fillHeight: true
                text: qsTr("Close")
                tooltip: qsTr("Close Current Session")
            }

            Button {
                id: sessionSendMsg
                Layout.fillHeight: true
                text: qsTr("Send")
                tooltip: qsTr("Send Message")
            }
        }
    }
}
