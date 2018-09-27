#include "squaredatagenerator.h"
#include <QQuickView>
#include <QtCharts/QXYSeries>
#include <QtCharts/QAreaSeries>
#include <QtQuick/QQuickView>
#include <QtQuick/QQuickItem>
#include <QtCore/QDebug>
#include <QtCore/QtMath>

QT_CHARTS_USE_NAMESPACE

Q_DECLARE_METATYPE(QAbstractSeries *)
Q_DECLARE_METATYPE(QAbstractAxis *)

SquareDataGenerator::SquareDataGenerator(QObject *parent)
    : QObject(parent)
{
    qRegisterMetaType<QAbstractSeries*>();
    qRegisterMetaType<QAbstractAxis*>();
}

double squareWaveValue(double x, double period)
{
    return sin(x / period * 2.0 * M_PI) >= 0.0 ? 1.0 : -1.0;
}

QVector<QPointF> generateChartData(int size)
{
    QVector<QPointF> res;
    for (int i = 0; i < size; i += 10)
        res.append({i*1.0, squareWaveValue(i, 3.0)});

    return res;
}

void SquareDataGenerator::update(QAbstractSeries *series)
{
    if (series)
    {
        QXYSeries *xySeries = static_cast<QXYSeries *>(series);
        _data = generateChartData(1000);
        xySeries->replace(_data);
    }
}
