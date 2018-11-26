#ifndef MAINCHARTVIEW_H
#define MAINCHARTVIEW_H

#include <QtCharts/QChartView>
#include <QtWidgets/QRubberBand>

QT_CHARTS_USE_NAMESPACE

class MainChartView : public QChartView
{
public:
    /*explicit*/ MainChartView(QChart *chart, QWidget *parent = nullptr);

protected:
    bool viewportEvent(QEvent *event);
    void mousePressEvent(QMouseEvent *event);
    void mouseMoveEvent(QMouseEvent *event);
    void mouseReleaseEvent(QMouseEvent *event);
    void keyPressEvent(QKeyEvent *event);

private:
    bool _isTouching;
};

#endif // MAINCHARTVIEW_H
