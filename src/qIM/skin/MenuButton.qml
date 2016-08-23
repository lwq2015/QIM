import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles 1.4

Rectangle {
    property string title
    property url iconImage
    property url iconMenu
    property Menu popup
    property string tooltip

    implicitHeight: button.height
    implicitWidth: button.width
    Button{
        id: button
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        text: title
        iconSource: iconMenu
        menu:popup
    }
}
