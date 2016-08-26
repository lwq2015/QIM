import QtQuick 2.7
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.3

Column {
    anchors.fill: parent
    anchors.margins: 6
    spacing: 10
    topPadding:12

    Image {
        id: otherHeadImage
        source: "images/userHeadBoy.png"
        anchors.horizontalCenter: parent.horizontalCenter
    }

    LinkInfo{
        text: "13588888888"
        source: "images/1_infoPhone.png"
        tooltip: qsTr("Mobile: ") + text
        onLinkClicked: {
            console.log(link)
        }
    }

    LinkInfo{
        text: "99999999"
        source: "images/1_infoTel.png"
        tooltip: qsTr("Telephone: ") + text
        onLinkClicked: {
            console.log(link)
        }
    }

    LinkInfo{
        text: "13588888888"
        source: "images/1_infoPhone.png"
        tooltip: qsTr("Email: ") + text
        onLinkClicked: {
            console.log(link)
        }
    }

    Item{
        height: 50
        width: parent.width
    }

    Image {
        id: myselfHeadImage
        anchors.horizontalCenter: parent.horizontalCenter
        source: "images/userHeadGirl.png"
    }
}
