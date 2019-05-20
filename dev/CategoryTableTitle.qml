import QtQuick 2.12
import QtQuick.Layouts 1.12


Rectangle {
    id: component

    property int textPixelSize: component.height * 0.384
    property font font: Qt.font({"family": "Saira", })
    property var labels: ["", "", "", "", "", "", ""]
    property int spacing: 0

    QtObject {
        id: internal
        readonly property Component textComponent: Text {
            color: "white"

            font.family: component.font.family
            font.pixelSize: component.textPixelSize
        }
    }

    RowLayout {
        id: layout

        spacing: component.spacing
        Layout.alignment: Qt.AlignVCenter

        height: parent.height

        anchors.left: parent.left
        anchors.right: parent.right

        anchors.leftMargin: layout.spacing
        anchors.rightMargin: layout.spacing

        Loader {
            sourceComponent: internal.textComponent
            Layout.leftMargin: layout.spacing * 0.5
            onLoaded: item.text = component.labels[0]
        }

        Loader {
            sourceComponent: internal.textComponent
            Layout.leftMargin: table.spacing
            onLoaded: item.text = component.labels[1]
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        Loader {
            sourceComponent: internal.textComponent
            onLoaded: item.text = component.labels[2]
        }

        Loader {
            sourceComponent: internal.textComponent
            onLoaded: item.text = component.labels[3]
        }

        Loader {
            sourceComponent: internal.textComponent
            onLoaded: item.text = component.labels[4]
        }

        Loader {
            sourceComponent: internal.textComponent
            Layout.leftMargin: layout.spacing
            onLoaded: item.text = component.labels[5]
        }

        Loader {
            sourceComponent: internal.textComponent
            Layout.leftMargin: layout.spacing
            onLoaded: item.text = component.labels[6]
        }
    }
}
