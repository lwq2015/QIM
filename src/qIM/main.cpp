#include <QGuiApplication>
#include <QQuickView>
#include <QQmlContext>
#include <QColor>
#include <QQmlEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

 //   QQmlApplicationEngine engine;
 //   engine.load(QUrl(QStringLiteral("qrc:/skin/SessionView.qml")));
    QQuickView viewer;
    QObject::connect(viewer.engine(), SIGNAL(quit()), &app, SLOT(quit()));
    viewer.setColor(QColor(Qt::transparent));
    viewer.setSource(QUrl(QStringLiteral("qrc:/skin/SessionMgrView.qml")));
    viewer.setResizeMode(QQuickView::SizeRootObjectToView);
    viewer.setFlags(Qt::Window | Qt::FramelessWindowHint);  // 无标题栏，但在任务栏中显示
    viewer.show();
    viewer.rootContext()->setContextProperty("mainwindow",&viewer);

    return app.exec();
}
