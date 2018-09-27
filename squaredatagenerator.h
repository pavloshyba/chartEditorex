#ifndef SQUAREDATAGENERATOR_H
#define SQUAREDATAGENERATOR_H

#include <QObject>
#include <QtCharts/QAbstractSeries>

class QQuickView;

QT_CHARTS_USE_NAMESPACE

class SquareDataGenerator : public QObject
{
    Q_OBJECT
public:
    explicit SquareDataGenerator(QObject *parent = nullptr);

public slots:
    void update(QAbstractSeries *series);

private:
    QVector<QPointF> _data;
};

#endif // SQUAREDATAGENERATOR_H
