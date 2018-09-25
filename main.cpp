#include <QApplication>
#include <QQmlApplicationEngine>

struct LogicData
{
    enum State {
        Low,
        High,
        HighZ
    };

    State _state{ Low };
//    QRectF _rect;
};

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
