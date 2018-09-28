import QtQuick 2.9
import QtQuick.Controls 2.2
import QtCharts 2.2
import QtQuick.Layouts 1.3
import QtQml.Models 2.2
import QtGraphicalEffects 1.0

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 900
    height: 600
    title: qsTr("Chart EditoREX")

    Item {
        id: rootItem
        anchors.fill: parent
    }

    Component {
        id: dragDelegate

        MouseArea {
            id: dragArea

            property bool held: false

            anchors { left: parent.left; right: parent.right }
            height: content.height

            drag.target: held ? content : undefined
            drag.axis: Drag.YAxis

            onPressAndHold: held = true
            onReleased: held = false

            Rectangle {
                id: content

                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }

                width: dragArea.width; height: row.implicitHeight + 4

                border.width: 1
                border.color: "lightsteelblue"

                color: dragArea.held ? "lightsteelblue" : "white"
                Behavior on color { ColorAnimation { duration: 100 } }

                Drag.active: dragArea.held
                Drag.source: dragArea
                Drag.hotSpot.x: width / 2
                Drag.hotSpot.y: height / 2

                states: State {
                    when: dragArea.held

                    ParentChange { target: content; parent: rootItem }
                    AnchorChanges {
                        target: content
                        anchors { horizontalCenter: undefined; verticalCenter: undefined }
                    }
                }

                RowLayout {
                    id: row
                    anchors { fill: parent; margins: 2 }
                    spacing: 1

                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        Layout.preferredWidth: 10
                        Layout.fillHeight: true

                        LinearGradient {
                            anchors.fill: parent
                            start: Qt.point(0, 0)
                            end: Qt.point(width, 0)
                            gradient: Gradient {
                                GradientStop { position: 0.0; color: "gray" }
                                GradientStop { position: 1.0; color: "lightgray" }
                            }
                        }
                    }

                    Button {
                        id: timerButton

                        anchors.verticalCenter: parent.verticalCenter

                        width: 50
                        height: 30

                        text: refreshTimer.running ? "Stop" : "Start"

                        onClicked: {
                            if (refreshTimer.running)
                                refreshTimer.stop();
                            else
                                refreshTimer.start( 1 / 60 * 1000)
                        }
                    }

                    ChartView {
                        id: mainChartView

                        objectName: "mainChartView"
                        Layout.minimumHeight: 100; Layout.preferredHeight: 200
                        Layout.minimumWidth: 400; Layout.preferredWidth:600
                        Layout.fillWidth: true

                        legend.visible: false
                        title: model.name

                        ValueAxis {
                            id: axisX
                            min: 0
                            max: 1000
                        }

                        ValueAxis {
                            id: axisY
                            min: -2
                            max: 2
                        }

                        LineSeries {
                            id: lineSeries
                            name: "signal"

                            useOpenGL: true

                            pointsVisible: true

                            axisX: axisX
                            axisY: axisY

                        }

                        Timer {
                            id: refreshTimer
                            interval: 1 / 60 * 1000 // 60 Hz
                            running: true
                            repeat: true
                            onTriggered: {
                                dataSource.update(mainChartView.series(0));
                            }
                        }

                        Component.onCompleted: {
                            dataSource.update(mainChartView.series(0));
                        }
                    }
                }
            }

            DropArea {
                anchors { fill: parent; margins: 10 }

                onEntered: {
                    visualModel.items.move(
                                drag.source.DelegateModel.itemsIndex,
                                dragArea.DelegateModel.itemsIndex)
                }
            }
        }
    }

    DelegateModel {
        id: visualModel
        model: ListModel {
            ListElement { name: "Generator #1" }
            ListElement { name: "Generator #2" }
            ListElement { name: "Generator #3" }
            ListElement { name: "Generator #4" }
            ListElement { name: "OSC #3" }
        }

        delegate: dragDelegate
    }

    ListView {
        anchors.fill: parent
        model: visualModel
        spacing: 4
        cacheBuffer: 50
    }
}
