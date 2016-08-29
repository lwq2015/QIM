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
    // 窗口背景图片
    Image {
        id: backgroundImage
        anchors.centerIn: parent
        width: parent.width - borderSize * 2
        height: parent.height - borderSize * 2
        source: "images/background.png" // 会话窗口背景图片
        //  layer.enabled: true
        //   opacity: 0.3
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
        anchors.fill: parent
        property point start: "0,0"
        onPressed: start = Qt.point(mouse.x, mouse.y)

        onPositionChanged: {
            //鼠标偏移量
            var delta = Qt.point(mouse.x - start.x, mouse.y - start.y)
            //如果mainwindow继承自QWidget,用setPos
            window.setX(window.x + delta.x)
            window.setY(window.y + delta.y)
        }
    }
}
