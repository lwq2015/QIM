#include <QGuiApplication>
//#include <QQuickView>
//#include <QQmlContext>
#include <QColor>
//#include <QQmlEngine>
#include <QtWebEngine>
#include <QQmlApplicationEngine>
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QtWebEngine::initialize();

    QTranslator qtTranslator;
    qtTranslator.load("qim_" + QLocale::system().name(), ":/i18n/");
    app.installTranslator(&qtTranslator);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/skin/SessionMgrView.qml")));
 /*
    QQuickView viewer;
    QObject::connect(viewer.engine(), SIGNAL(quit()), &app, SLOT(quit()));
    viewer.setColor(QColor(Qt::transparent));
    viewer.setSource(QUrl(QStringLiteral("qrc:/skin/SessionMgrView.qml")));
    viewer.setResizeMode(QQuickView::SizeRootObjectToView);
    viewer.setFlags(Qt::Window | Qt::FramelessWindowHint);
    viewer.show();
    viewer.rootContext()->setContextProperty("window",&viewer);
*/
    return app.exec();
}
