import QtQuick 2.2
import QtGraphicalEffects 1.0
import QtQuick.Window 2.1
Window {
    id:window
    width: 300
    height: 200
    color: "#00000000" // 设置透明度为0的白色背景，是为了窗口阴影能显示透明效果
    flags: Qt.FramelessWindowHint |Qt.WindowSystemMenuHint |Qt.WindowCloseButtonHint | Qt.Window
    property int borderSize: 5 // 默认窗口阴影边框为5像素, 设置为0就关闭了阴影效果



    // 使用背景边框图片来实现窗口边框的阴影
    BorderImage {
        id: backgroundImage
        source: "images/border.png"
        anchors.fill: parent

        border{left: borderSize; top: borderSize
        right: borderSize; bottom: borderSize}
    }
    // 窗口背景阴影及颜色
    Rectangle {
        id: backgroundShadow
    //    width: parent.width - borderSize * 2
    //    height: parent.height - borderSize * 2
        anchors.fill: parent
        anchors.margins: borderSize
        layer.enabled: false         // 启动Effect
        layer.effect: DropShadow {
            color: "gray"
            transparentBorder: true
            radius: borderSize
            samples: borderSize * 1.5
        }
    }
    MouseArea {
        id: dragRegion
        anchors.fill: parent
        property point start: "0,0"
        onPressed: start = Qt.point(mouse.x, mouse.y)

        onDoubleClicked: Qt.quit()
        onPositionChanged: {
            //鼠标偏移量
            var delta = Qt.point(mouse.x - start.x, mouse.y - start.y)
            //如果mainwindow继承自QWidget,用setPos
            window.setX(window.x + delta.x)
            window.setY(window.y + delta.y)
        }
    }
}
