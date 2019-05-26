import QtQuick 2.12
import QtQuick.Layouts 1.12


Item {
    id: component

    property int textPixelSize: component.height * 0.384
    property font font: Qt.font({"family": "Saira", })
    property var labels: ["", "", "", "", "", "", ""]
    property int spacing: 0
    property alias color: background.color
    property int animationsDuration: 250
    property int animationsDelay: 0
    property int textAnimationsDuration: 120 * 1

    QtObject {
        id: internal
        readonly property Component textComponent: Text {
            color: "white"

            font.family: component.font.family
            font.pixelSize: component.textPixelSize
        }
    }

    state: "hidden"
    states: [
        State {
            name: "full"
            PropertyChanges {
                target: background
                sideAnchor: "bottom"
                height: component.height
            }
            PropertyChanges { target: rowContent; opacity: 1 }
        },

        State {
            name: "hidden"
            PropertyChanges { target: background; sideAnchor: "top"; height: 0 }
            PropertyChanges { target: rowContent; opacity: 0 }
        }
    ]

    transitions: [
        Transition {
            from: "full"; to: "hidden"
            SequentialAnimation {
                NumberAnimation { duration: component.animationsDelay }
                NumberAnimation { target: rowContent; property: "opacity";
                    duration: component.textAnimationsDuration }
                NumberAnimation { target: background; property: "height";
                    duration: component.animationsDuration; easing.type: Easing.OutCubic }
            }
        },

        Transition {
            from: "hidden"; to: "full"
            SequentialAnimation {
                NumberAnimation { duration: component.animationsDelay }
                NumberAnimation { target: background; property: "height";
                    duration: component.animationsDuration; easing.type: Easing.OutCubic }
                NumberAnimation { target: rowContent; property: "opacity";
                    duration: component.textAnimationsDuration }
            }
        }

    ]

    SideAnchoredRect {
        id: background
        width: parent.width
        height: parent.height
    }

    RowLayout {
        id: rowContent

        spacing: component.spacing
        Layout.alignment: Qt.AlignVCenter

        height: parent.height

        anchors.left: parent.left
        anchors.right: parent.right

        anchors.leftMargin: rowContent.spacing
        anchors.rightMargin: rowContent.spacing

        Loader {
            sourceComponent: internal.textComponent
            Layout.leftMargin: rowContent.spacing * 0.5
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
            Layout.leftMargin: rowContent.spacing
            onLoaded: item.text = component.labels[5]
        }

        Loader {
            sourceComponent: internal.textComponent
            Layout.leftMargin: rowContent.spacing
            onLoaded: item.text = component.labels[6]
        }
    }
}
