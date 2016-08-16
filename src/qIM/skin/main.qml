import QtQuick 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4

Rectangle {
    width: 700
    height: 480

    ListModel {
        id: sessionModel
        ListElement {
            name: "Bill Smith"
            number: "555 3264"
        }
        ListElement {
            name: "John Brown"
            number: "555 8426"
        }
        ListElement {
            name: "Sam Wise"
            number: "555 0473"
        }
    }
    Component {
        id: sessionDelegate
        Item {
            width: 180
            height: 40
            Column {
                Text {
                    text: '<b>Name:</b> ' + name
                }
                Text {
                    text: '<b>Number:</b> ' + number
                }
            }

            MouseArea{
                anchors.fill: parent
                onClicked: parent.ListView.view.currentIndex=item //sessionListView.currentIndex = index

            }
        }
    }



    ListView {
        id: sessionListView
        width: 200

        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }
        model: sessionModel
        delegate: sessionDelegate
        highlight: Rectangle {
            color: "lightsteelblue"
            radius: 5
        }
        focus: true

        onCurrentIndexChanged: {
            console.log("current index ", index)

        //    sessionTabView.currentIndex = index
        }
    }

    TabView {
        id: sessionTabView

        tabsVisible: false
        anchors {
            left: sessionListView.right
            top: parent.top
            right: parent.right
            bottom: parent.bottom
        }
        Tab {
            title: "Red"
            Rectangle {
                color: "red"
            }
        }
        Tab {
            title: "Blue"
            Rectangle {
                color: "blue"
            }
        }
        Tab {
            title: "Green"
            Rectangle {
                color: "green"
            }
        }
    }
}
