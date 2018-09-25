import QtQuick 2.0

Item {
    id: root

    default property Item contentItem
    property Item draggedItemParent
    signal moveItemRequested(int from, int to)

    width: contentItem.width
    height: contentItem.height

    onContentItemChanged: {
        contentItem.parent = contentItemWrapper;
        console.debug("onContentItemChanged, width", width, "height", height);

    }

    Rectangle {
        id: contentItemWrapper
        anchors.fill: parent
        Drag.active: dragArea.drag.active
        Drag.hotSpot {
            x: contentItem.width / 2
            y: contentItem.height / 2
        }

        MouseArea {
            id: dragArea
            anchors.fill: parent
            drag.target: parent
            drag.axis: Drag.YAxis
            drag.smoothed: false

            propagateComposedEvents: true
            onReleased: {
                console.debug("released");
                if (drag.active) {
                    emitMoveItemRequested();
                }
            }
        }
    }

    states: [
        State {
            when: dragArea.drag.active
            name: "dragging"

            ParentChange {
                target: contentItemWrapper
                parent: draggedItemParent
            }
            PropertyChanges {
                target: contentItemWrapper
                opacity: 0.9
                anchors.fill: undefined
                width: contentItem.width
                height: contentItem.height
            }
            PropertyChanges {
                target: root
                height: 0
            }
        }]
}
