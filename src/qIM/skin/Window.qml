import QtQuick 2.7

MouseArea {
    id: dragRegion
    anchors.fill: parent
    property point start: "0,0"
    onPressed: start = Qt.point(mouse.x, mouse.y)

    onPositionChanged: {
        //鼠标偏移量
        var delta = Qt.point(mouse.x - start.x, mouse.y - start.y)
        //如果mainwindow继承自QWidget,用setPos
        mainwindow.setX(mainwindow.x + delta.x)
        mainwindow.setY(mainwindow.y + delta.y)
    }
}
