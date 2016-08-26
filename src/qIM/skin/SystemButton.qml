import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3

RowLayout {
    spacing: 0
    property Menu systemMenu: null
    property alias rightTrigger: triggerRightView.checked
    property alias visiableMenu: systemMenuButton.visible
    property alias visableTrigger: triggerRightView.visible
    property alias visableMin: systemMinButton.visible
    property alias visableMax: systemMaxButton.visible
    property alias visableRestore: systemRestoreButton.visible
    property alias visableClose: systemCloseButton.visible

    signal clickedMin
    signal clickedMax
    signal clickedRestore
    signal clickedClose

    Layout.minimumHeight: 30
    Layout.maximumHeight: 30
    Layout.fillWidth: true
    Layout.alignment: Qt.AlignRight

    // 使用 '||' 重新格式化会换行，使用 '+' 是一样的效果
    Button {
        id: systemMenuButton
        anchors.top: parent.top
        iconSource: "images/systemMenuButton.png"
        tooltip: qsTr("Show menu")
        visible: false
        style: SystemButtonStyle {
        }
        onClicked: {
            if (systemMenu === null) {
                console.log("未设置systemMenu属性, 无法显示菜单")
            } else {
                systemMenu.__xOffset = -__behavior.mouseX
                systemMenu.__yOffset = systemMenuButton.height - __behavior.mouseY
                systemMenu.popup()
            }
        }
    }
    Button {
        id: triggerRightView
        checkable: true
        anchors.top: parent.top
        iconSource: checked ? "images/1_triggerRightSel.png" : "images/1_triggerRight.png"
        tooltip: qsTr("Show or Hide right view")
        visible: false
        style: SystemButtonStyle {
        }
    }
    Button {
        id: systemMinButton
        anchors.top: parent.top
        iconSource: (hovered
                     + pressed) ? "images/systemMinButtonH.png" : "images/systemMinButton.png"
        tooltip: qsTr("Minimum")
        style: SystemButtonStyle {
        }
        onClicked: clickedMin()
    }
    Button {
        id: systemMaxButton
        anchors.top: parent.top
        iconSource: (hovered
                     + pressed) ? "images/systemMaxButtonH.png" : "images/systemMaxButton.png"
        tooltip: qsTr("Maximum")
        style: SystemButtonStyle {
        }
        onClicked: {
            visible = false
            visableRestore = true
            clickedMax()
        }
    }
    Button {
        id: systemRestoreButton
        anchors.top: parent.top
        visible: false
        iconSource: (hovered + pressed) ? "images/systemRestoreButtonH.png" : "images/systemRestoreButton.png"
        tooltip: qsTr("Restore")
        style: SystemButtonStyle {
        }
        onClicked: {
            visible = false
            visableMax = true
            clickedRestore()
        }
    }
    Button {
        id: systemCloseButton
        anchors.top: parent.top
        iconSource: (hovered
                     + pressed) ? "images/systemCloseButtonH.png" : "images/systemCloseButton.png"
        tooltip: qsTr("Close")
        style: SystemButtonStyle {
        }
        onClicked: clickedClose()
    }
}
