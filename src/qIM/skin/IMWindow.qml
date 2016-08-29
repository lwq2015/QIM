import QtQuick 2.7
import QtQuick.Window 2.2
Window{
    id: window
    width: 820
    height: 510
    property color backgroundColor: "gainsboro"
    color: backgroundColor

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
