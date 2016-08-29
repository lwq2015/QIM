import QtQuick 2.7

import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

IMWindow {
    id: sessionMgrWindow
    SplitView {
        anchors.fill: parent
        ListModel {
            id: sessionMgrModel
            ListElement {
                image: "images/1_session.png"
                title: "Bill Smith"
                number: "555"
            }
            ListElement {
                image: "images/1_session.png"
                title: "John Brown"
                number: "55"
            }
            ListElement {
                image: "images/1_session.png"
                title: "Sam Wise"
                number: "0"
            }
        }

        Component {
            id: sessionMgrDelegate
            Item {
                id: sessionItem
                width: parent.width
                height: 40
                RowLayout {
                    anchors.fill: parent
                    spacing: 4

                    // 会话标识图片
                    Image {
                        Layout.preferredWidth: 30
                        Layout.preferredHeight: 30
                        source: image
                    }

                    // 会话主题
                    Item {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Text {
                            anchors.fill: parent
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            text: title
                        }
                    }

                    // 会话新消息条数
                    Rectangle {
                        color: "skyblue"
                        visible: (sessionItem.ListView.isCurrentItem === false
                                  && number > 0) ? true : false
                        radius: 8
                        Layout.preferredWidth: 22
                        Layout.preferredHeight: 18
                        Text {
                            color: "whitesmoke"
                            anchors.centerIn: parent
                            text: number
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    property Item closeButtonItem
                    property bool selectChanged
                    onClicked: {
                        selectChanged = (sessionItem.ListView.view.currentIndex === index)
                        sessionItem.ListView.view.currentIndex = index
                        // highlightItem 只有一个关闭子控件，所以如果找到了就会是关闭按钮
                        closeButtonItem = sessionItem.ListView.view.highlightItem.childAt(
                                    mouse.x, mouse.y)
                        // 由于这儿的MouseArea会吃掉关闭按钮的鼠标事件，所以需要这儿触发clicked.
                        if (selectChanged && closeButtonItem) {
                            closeButtonItem.clicked()
                        }
                    }
                }
            }
        }

        ListView {
            id: sessionListView
            clip: true
            width: 150
            Layout.minimumWidth: 56
            Layout.maximumWidth: 240
            model: sessionMgrModel
            delegate: sessionMgrDelegate
            highlight: Rectangle {
                color: "lightsteelblue"
                radius: 5
                focus: true

                // 会话关闭按钮
                Button {
                    id: sessionItemClose
                    tooltip: qsTr("Close session")
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    iconSource: hovered ? "images/1_sessionItemCloseH.png" : "images/1_sessionItemClose.png"
                    width: 16
                    height: 16
                    style: ButtonStyle {
                        // 设置一个dummy style为了去掉默认Button的状态
                        background: Item {
                        }
                    }
                    onClicked: {
                        // 关闭当前会话
                        sessionMgrModel.remove(sessionListView.currentIndex)
                    }
                }
            }

            onCurrentIndexChanged: sessionTabView.currentIndex = currentIndex
        }

        TabView {
            id: sessionTabView
            tabsVisible: false
            Layout.minimumWidth: 580
            Layout.minimumHeight: 480
            Layout.fillWidth: true
            Layout.fillHeight: true

            Tab {
                title: "Red"
                SessionView {}
            }
            Tab {
                title: "Blue"
                SessionView {}
            }
            Tab {
                title: "Green"
                Rectangle {
                    color: "green"
                }
            }
        }
    }
}
