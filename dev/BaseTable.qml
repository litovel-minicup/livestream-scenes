import QtQuick 2.0

Item {
    id: component

    property Component rowComponent
    property Component titleComponent: Item {}
    property int visibleRowCount: 6
    property int rowCount: 12
    property alias title: title
    property int titleHeight: height * 0.125

    Column{
        anchors.fill: parent

        Loader {
            id: title

            sourceComponent: component.titleComponent
            width: parent.width
            height: component.titleHeight
        }

        Repeater {
            model: visibleRowCount

            Loader {
                readonly property int rowIndex: index

                sourceComponent: component.rowComponent

                width: component.width
                height: (component.height - component.titleHeight) / component.visibleRowCount
            }
        }
    }
}
