#include "squaredatagenerator.h"

#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QVector>
#include <QDebug>
#include <QQmlComponent>
#include <QtCharts/QLineSeries>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    SquareDataGenerator dataSource(&app);
    engine.rootContext()->setContextProperty("dataSource", &dataSource);

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
