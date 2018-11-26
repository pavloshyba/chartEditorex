#include "mainchart.h"
#include "mainchartview.h"
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

    QLineSeries *series = new QLineSeries();
    for (int i = 0; i < 500; i++)
    {
        QPointF p((qreal) i, std::sin(M_PI / 50 * i) * 100);
        p.ry() += qrand() % 20;
        *series << p;
    }

//    auto chart = new MainChart;
//    chart->addSeries(series);
//    chart->setTitle("Taked from Qt's Zoom in/out example");
//    chart->setAnimationOptions(QChart::SeriesAnimations);
//    chart->legend()->hide();
//    chart->createDefaultAxes();

//    auto chartView = new MainChartView(chart);
//    chartView->setRenderHint(QPainter::Antialiasing);


    SquareDataGenerator dataSource(&app);
    engine.rootContext()->setContextProperty("dataSource", &dataSource);

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
