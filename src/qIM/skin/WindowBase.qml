// 窗口基础组件
// 功能：
//   1、实现窗口边框阴影效果
//   2、窗口背景颜色设置
//   3、窗口背景图片设置
//   4、窗口位置拖动
//   5、无默认窗口标题栏
import QtQuick 2.7
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2

Window {
    id: window
    width: 820
    height: 510
    color: "#00000000" // 设置透明度为0的白色背景，是为了窗口阴影能显示透明效果
    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WA_TranslucentBackground
    property int borderSize: 5 // 默认窗口阴影边框为5像素, 设置为0就关闭了阴影效果
    property alias source: backgroundImage.source // 会话窗口背景图片
    property alias backgroundColor: backgroundShadow.color
    property int titleSize: 32 // 默认窗口标题高度

    // 窗口背景图片
    Image {
        id: backgroundImage
        anchors.centerIn: parent
        width: parent.width - borderSize * 2
        height: parent.height - borderSize * 2
        source: "images/background.png" // 会话窗口背景图片
    }
    // 窗口背景阴影及颜色
    Rectangle {
        id: backgroundShadow
        width: parent.width - borderSize * 2
        height: parent.height - borderSize * 2
        anchors.centerIn: parent
        layer.enabled: true
        layer.effect: DropShadow {
            color: "gray"
            transparentBorder: true
            radius: borderSize
            samples: borderSize * 1.5
        }

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

    MouseArea {
        id: dragRegion
        hoverEnabled: true
        anchors.fill: parent
        property point start: "0,0"
        property int hitType: noSection
        property rect pos
        readonly property int noSection: 0
        readonly property int leftSection: 1
        readonly property int topLeftSection: 2
        readonly property int topSection: 3
        readonly property int topRightSection: 4
        readonly property int rightSection: 5
        readonly property int bottomRightSection: 6
        readonly property int bottomSection: 7
        readonly property int bottomLeftSection: 8
        readonly property int titleBarArea: 9

        onPressed: {
            pos.x = window.x
            pos.y = window.y
            pos.width = window.width
            pos.height = window.height
            start = Qt.point(mouse.x, mouse.y)
        }

        onPositionChanged: {
            if (pressed) {
                var delta = Qt.point(mouse.x - start.x, mouse.y - start.y)

                if (hitType == leftSection) {
                    if (updateWidth(window.width - delta.x))
                        window.setX(window.x + delta.x)
                } else if (hitType == topLeftSection) {
                    if (updateWidth(window.width - delta.x))
                        window.setX(window.x + delta.x)
                    if (updateHeight(window.height - delta.y))
                        window.setY(window.y + delta.y)
                } else if (hitType == topSection) {
                    if (updateHeight(window.height - delta.y))
                        window.setY(window.y + delta.y)
                } else if (hitType == topRightSection) {
                    updateWidth(pos.width + delta.x)
                    if (updateHeight(window.height - delta.y))
                        window.setY(window.y + delta.y)
                } else if (hitType == rightSection) {
                    updateWidth(pos.width + delta.x)
                } else if (hitType == bottomRightSection) {
                    updateWidth(pos.width + delta.x)
                    updateHeight(pos.height + delta.y)
                } else if (hitType == bottomSection) {
                    updateHeight(pos.height + delta.y)
                } else if (hitType == bottomLeftSection) {
                    if (updateWidth(window.width - delta.x))
                        window.setX(window.x + delta.x)
                    updateHeight(pos.height + delta.y)
                } else if (hitType == titleBarArea) {
                    window.setX(window.x + delta.x)
                    window.setY(window.y + delta.y)
                }
            } else {
                hitType = hitTest(width, height, titleSize, mouse.x, mouse.y)

                if (hitType == leftSection || hitType == rightSection)
                    cursorShape = Qt.SizeHorCursor // 左右箭头
                else if (hitType == topSection || hitType == bottomSection)
                    cursorShape = Qt.SizeVerCursor // 上下箭头
                else if (hitType == topLeftSection
                         || hitType == bottomRightSection)
                    cursorShape = Qt.SizeFDiagCursor // top-left and bottom-right
                else if (hitType == topRightSection
                         || hitType == bottomLeftSection)
                    cursorShape = Qt.SizeBDiagCursor // top-right and bottom-left corners.
                else
                    cursorShape = Qt.ArrowCursor
            }
        }

        function updateWidth(w) {
            if (w >= window.minimumWidth && w <= window.maximumWidth) {
                window.setWidth(w)
                return true
            }
            return false
        }
        function updateHeight(h) {
            if (h >= window.minimumHeight && h <= window.maximumHeight) {
                window.setHeight(h)
                return true
            }

            return false
        }

        function hitTest(width, height, title, x, y) {
            var borderSize = 6
            if (x <= borderSize) {
                if (y <= borderSize)
                    return topLeftSection
                else if (y >= height - borderSize)
                    return bottomLeftSection
                else
                    return leftSection
            } else if (x >= width - borderSize) {
                if (y <= borderSize)
                    return topRightSection
                else if (y >= height - borderSize)
                    return bottomRightSection
                else
                    return rightSection
            } else if (y <= borderSize) {
                return topSection
            } else if (y >= height - borderSize) {
                return bottomSection
            } else if (y <= title) {
                return titleBarArea
            } else {
                return noSection
            }
        }
    }
}
