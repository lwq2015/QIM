import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3

Control {
    id: menuButton
    signal clicked
    property alias text:
    property alias iconSource: _image_.source
    property alias iconMenu: _menu_
    property alias color: menuBackground.color
    property string borderColor
    //  property alias width: width
    property Menu menu:null
    property string tooltip
    readonly property alias pressed: _mouse_.pressed
    readonly property alias hovered: _mouse_.containsMouse

    // 默认高度与宽度，8 = leftPadding(4) + rightPadding(4) 或 topPadding(4) + bottomPadding(4)
    implicitHeight: Math.max(menuRow.implicitHeight + 8, height)
    implicitWidth: Math.max(menuRow.implicitWidth + 8, width)

    // 背景边框
    property Component background: Item {
        Rectangle {
            id: menuBackground
            anchors.fill: parent
            border.width: 1
            border.color: hovered
                          || pressed ? "#0078d7" : (borderColor.length ? borderColor : "#00000000")
            radius: 1
            //    opacity: 0.6
            color: "#00000000" // 正常状态时，无色透明
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: pressed ? "#80cccccc" : "#80eeeeee"
                }
                GradientStop {
                    position: 1
                    color: pressed ? "#80aaaaaa" : "#80cccccc"
                }
            }
        }
    }
    // Button布局： 图标 + 文字 + 菜单前头
    property Component label: Item {
        implicitWidth: menuRow.implicitWidth
        implicitHeight: menuRow.implicitHeight
        RowLayout {
            id: menuRow
            spacing: 2
            anchors.centerIn: parent
            Image {
                id: _image_
                // source: iconSource
                anchors.verticalCenter: parent.verticalCenter
                //   anchors.left: parent.left
                //  anchors.leftMargin: 2
            }

            Text {
                id: _text_
                text: text
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Image {
                id: _menu_
                source: "images/arrow-down.png"
                opacity: enabled ? 0.6 : 0.5
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 2
            }
        }
    }

    /*! \internal */
    property Component panel: Item {
        anchors.fill: parent
        implicitWidth: Math.max(
                           labelLoader.implicitWidth + padding.left + padding.right,
                           backgroundLoader.implicitWidth)
        implicitHeight: Math.max(
                            labelLoader.implicitHeight + padding.top + padding.bottom,
                            backgroundLoader.implicitHeight)
        baselineOffset: labelLoader.item ? padding.top + labelLoader.item.baselineOffset : 0

        Loader {
            id: backgroundLoader
            anchors.fill: parent
            sourceComponent: background
        }

        Loader {
            id: labelLoader
            sourceComponent: label
            anchors.fill: parent
            anchors.leftMargin: padding.left
            anchors.topMargin: padding.top
            anchors.rightMargin: padding.right
            anchors.bottomMargin: padding.bottom
        }
    }

    // 鼠标事件
    MouseArea {
        id: _mouse_
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            console.log("size:", menuButton.width, menuButton.height)
            if (_menu_.contains(mapToItem(_menu_, mouse.x, mouse.y))) {
                // 菜单显示在整个控件的下面
                menu.__xOffset = menuRow.x - mouse.x
                menu.__yOffset = (menuRow.y + menuRow.height + 6) - mouse.y
                menu.popup()
            } else {
                // 当不在菜单图片上点击时，才发出clicked信号
                menuButton.clicked()
            }
        }
        onExited: Tooltip.hideText()
        onCanceled: Tooltip.hideText()
        Timer {
            interval: 1000
            running: hovered && !pressed && tooltip.length
            onTriggered: Tooltip.showText(_mouse_,
                                          Qt.point(_mouse_.mouseX,
                                                   _mouse_.mouseY), tooltip)
        }
    }
}
