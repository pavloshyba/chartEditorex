import QtQuick 2.9
import QtQuick.Controls 2.2
import QtCharts 2.2
import QtQuick.Layouts 1.3
import QtQml.Models 2.2

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("Scroll")

    Item {
        id: rootItem
        anchors.fill: parent
    }

    DelegateModel {
        id: visualModel
        model: ListModel {
            ListElement { name: "FIRST" }
            ListElement { name: "SECOND" }
        }
        delegate: Component {
            id:dragDelegate

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

                    Row {
                        id: row
                        anchors { fill: parent; margins: 2 }
                        Text {
                            text: "Name: " + name;
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        ChartView {
                            height: 200
                            width: 500
                            legend.visible: false

                            LineSeries {
                                XYPoint { x:0; y:0 }
                                XYPoint { x:4; y:0 }
                                XYPoint { x:4; y:1 }
                                XYPoint { x:8; y:1 }
                                XYPoint { x:8; y:0 }
                                XYPoint { x:12; y:0 }
                                XYPoint { x:12; y:1 }
                                XYPoint { x:16; y:1 }
                                XYPoint { x:16; y:0 }
                                XYPoint { x:20; y:0 }
                                XYPoint { x:20; y:1 }
                                XYPoint { x:24; y:1 }
                                XYPoint { x:24; y:1 }
                            }
                        }
                    }
                }

                DropArea {
                    anchors { fill: parent; margins: 10 }

                    onEntered: {
                        console.log("drag.source.DelegateModel.itemsIndex",  drag.source.DelegateModel.itemsIndex)
                        console.log("dragArea.DelegateModel.itemsIndex",  dragArea.DelegateModel.itemsIndex)
                        visualModel.items.move(
                                    drag.source.DelegateModel.itemsIndex,
                                    dragArea.DelegateModel.itemsIndex)
                    }
                }
            }
        }
    }

    ListView {
        anchors.fill: parent
        model: visualModel
        spacing: 4
        cacheBuffer: 50
    }
}


//    Item {
//        id: mainContent
//        anchors.fill: parent
//        visible: true
//        opacity:

//        Item {
////            draggedItemParent: mainContent
//            anchors.fill: parent
//            /*contentItem:*/ ChartView {
//                width: 400
//                height: 200
//                legend.visible: false

//                LineSeries {
//                    XYPoint { x:0; y:0 }
//                    XYPoint { x:4; y:0 }
//                    XYPoint { x:4; y:1 }
//                    XYPoint { x:8; y:1 }
//                    XYPoint { x:8; y:0 }
//                    XYPoint { x:12; y:0 }
//                    XYPoint { x:12; y:1 }
//                    XYPoint { x:16; y:1 }
//                    XYPoint { x:16; y:0 }
//                    XYPoint { x:20; y:0 }
//                    XYPoint { x:20; y:1 }
//                    XYPoint { x:24; y:1 }
//                    XYPoint { x:24; y:1 }
//                }

//                MouseArea {
//                    anchors.fill: parent

//                    drag.target: parent
//                    drag.axis: Drag.YAxis
//                    drag.smoothed: false
//                    onReleased: {
//                        console.debug("onReleased");
//                        if (drag.active) {
//                             console.debug("drag.active");
//                        }
//                    }
//                }
//            }
//        }

//        ScrollView {
//            Layout.fillWidth: true
//            Layout.fillHeight: true

//            Layout.preferredHeight: 100; Layout.preferredWidth: 100
//            clip: true
//            visible: true
//            ColumnLayout {
//                anchors.fill: parent
//                spacing: 0
//                ListView {
//                    model: 3

//                    delegate: DraggableItem {
//                        draggedItemParent: mainContent
//                        contentItem: ChartView {
//                            height: 200
//                            width: 600
//                            anchors.fill: parent
//                            legend.visible: false

//                            LineSeries {
//                                XYPoint { x:0; y:0 }
//                                XYPoint { x:4; y:0 }
//                                XYPoint { x:4; y:1 }
//                                XYPoint { x:8; y:1 }
//                                XYPoint { x:8; y:0 }
//                                XYPoint { x:12; y:0 }
//                                XYPoint { x:12; y:1 }
//                                XYPoint { x:16; y:1 }
//                                XYPoint { x:16; y:0 }
//                                XYPoint { x:20; y:0 }
//                                XYPoint { x:20; y:1 }
//                                XYPoint { x:24; y:1 }
//                                XYPoint { x:24; y:1 }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
