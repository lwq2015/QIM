#include <QApplication>
#include <QQuickView>
#include <QQmlContext>
#include <QColor>
#include <QQmlEngine>
#include <QtWebEngine>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QtWebEngine::initialize();
 //   QQmlApplicationEngine engine;
 //   engine.load(QUrl(QStringLiteral("qrc:/skin/SessionView.qml")));
    QQuickView viewer;
    QObject::connect(viewer.engine(), SIGNAL(quit()), &app, SLOT(quit()));
    viewer.setColor(QColor(Qt::transparent));
    viewer.setSource(QUrl(QStringLiteral("qrc:/skin/SessionMgrView.qml")));
    viewer.setResizeMode(QQuickView::SizeRootObjectToView);
    viewer.setFlags(Qt::Window | Qt::FramelessWindowHint);
    viewer.show();
    viewer.rootContext()->setContextProperty("window",&viewer);

    return app.exec();
}
