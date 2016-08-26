// 说明： LinkInfo 组件所提供的功能为：
// 1、可以设置一个图标在最左边
// 2、可以设置一个文本，紧随在图标右边
// 3、可以设置tooltip
// 4、点击时会发出信号linkClicked，参数内容为所所设置的text
//
// Q & A:
// Q1、Tooltip为何不使用QtQuick.Controls 2.0中的ToolTip?
// A1、2.0中的ToolTip有缺陷：tooltip无法超过组件所以在的窗口位置，当内容过长时，就无法显示完全
// Q2、为何给一个空的ButtonStyle？
// A2、为了去除Button的默认背景效果
// Q3、为何外面使用一个Button？
// A3、使用Button为了：1、显示Tooltip； 2、点击时发出linkClicked事件
//
import QtQuick 2.7
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4

RowLayout {
    id: linkInfo
    property alias text: linkLabel.text
    property alias tooltip: linkButton.tooltip
    property alias source: linkImage.source
    property color color: "green"
    signal linkClicked(string link)

    anchors.left: parent.left
    anchors.right: parent.right
    clip: true

    Button {
        id: linkButton
        Layout.preferredHeight: 16
        Layout.fillWidth: true
        Layout.fillHeight: true
        tooltip: linkInfo.text
        onClicked: linkClicked(linkInfo.text)
        style: ButtonStyle {
            background: Item {
            }
        }
        Image {
            id: linkImage
            anchors.verticalCenter: parent.verticalCenter
         }

        Label {
            id: linkLabel
            color: linkButton.hovered ? Qt.lighter(linkInfo.color) : linkInfo.color
            anchors.leftMargin: 4
            anchors.left: linkImage.right
            anchors.verticalCenter: parent.verticalCenter
            elide: Text.ElideRight
            font.underline: linkButton.hovered
        }
    }
}
