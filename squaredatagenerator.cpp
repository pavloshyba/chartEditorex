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
    static int ab = qRegisterMetaType<QAbstractSeries*>();
    static int aa = qRegisterMetaType<QAbstractAxis*>();
    Q_UNUSED(ab); Q_UNUSED(aa);
}

double randomDouble(double fMin, double fMax)
{
    double f = (double)rand() / RAND_MAX;
    return fMin + f * (fMax - fMin);
}

double squareWaveValue(double x, double period)
{
    const auto upper = randomDouble(1.4, 0.8);
    const auto bottom = randomDouble(-1.6, -0.6);
    return sin(x / period * 2.0 * M_PI) >= 0.0 ? upper : bottom;
}

QVector<QPointF> generateChartData(int size)
{
    QVector<QPointF> res;
    for (int i = 0; i < size; i += 2)
        res.append({i*1.0, squareWaveValue(i, 3.0)});

    return res;
}

void SquareDataGenerator::update(QAbstractSeries *series)
{
    if (series)
    {
        QXYSeries *xySeries = static_cast<QXYSeries *>(series);
        _data = generateChartData(10000);
        xySeries->replace(_data);
    }
}
