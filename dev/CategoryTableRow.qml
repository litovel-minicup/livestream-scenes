import QtQuick 2.12
import QtQuick.Layouts 1.12


Item {
    id: component

    property int spacing: 0
    property int titleTextPixelSize: 0

    property string teamName: ""
    property string teamSlug: ""
    property int teamWins: 0
    property int teamLoses: 0
    property int teamTies: 0
    property string teamScore: ""
    property int teamPoints: 0
    property color textColor: "black"
    property color teamTextColor: "black"
    property alias color: background.color

    property int animationsDuration: 250
    property int animationsDelay: 0
    property int textAnimationsDuration: 120 * 1

    state: "hidden"

    QtObject {
        id: internal

        readonly property Component textComponent: PosLinkedText {
            font.family: "Saira Black"
            font.pixelSize: component.height * 0.322

            linkedTextFont.family: "Saira"
            linkedTextFont.pixelSize: component.titleTextPixelSize

            textComponent.color: component.textColor
        }
    }

    states: [
        State {
            name: "full"
            PropertyChanges { target: rowContent; opacity: 1 }
            PropertyChanges {
                target: background
                sideAnchor: "left"
                width: component.width
            }
        },

        State {
            name: "hidden"
            PropertyChanges { target: rowContent; opacity: 0 }
            PropertyChanges {
                target: background
                sideAnchor: "right"
                width: 0
            }
        }
    ]

    transitions: [
        Transition {
            from: "full"; to: "hidden"
            SequentialAnimation {
                NumberAnimation { duration: component.animationsDelay }
                NumberAnimation { target: rowContent; property: "opacity";
                    duration: component.textAnimationsDuration }
                NumberAnimation { target: background; property: "width";
                    duration: component.animationsDuration; easing.type: Easing.OutCubic }
            }
        },

        Transition {
            from: "hidden"; to: "full"
            SequentialAnimation {
                NumberAnimation { duration: component.animationsDelay }
                NumberAnimation { target: background; property: "width";
                    duration: component.animationsDuration; easing.type: Easing.OutCubic }
                NumberAnimation { target: rowContent; property: "opacity";
                    duration: component.textAnimationsDuration }
            }
        }
    ]

    SideAnchoredRect {
        id: background

        color: "white"
        width: parent.width
        height: parent.height - 2
    }

    RowLayout {
        id: rowContent

        spacing: component.spacing

        height: parent.height
        width: parent.width

        anchors.left: parent.left
        anchors.right: parent.right

        anchors.leftMargin: rowContent.spacing * 1.5
        anchors.rightMargin: rowContent.spacing

        Loader {
            sourceComponent: internal.textComponent
            height: parent.height
            onLoaded: {
                item.linkedText = "#"
                item.text = rowIndex + 1
                item.textComponent.anchors.horizontalCenter =
                        item.textComponent.parent.horizontalCenter
            }
        }

        Item {
            width: height
            height: component.height * 0.74
            Layout.leftMargin: rowContent.spacing

            Image {
                source: "mc-club-logos-2019/2019/" + component.teamSlug + ".png"

                fillMode: Image.PreserveAspectFit
                mipmap: true
                anchors.fill: parent
            }
        }

        Text {
            text: component.teamName
            color: component.teamTextColor
            font.family: "High School USA Sans"
            font.pixelSize: parent.height * 0.462
        }

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        Loader {
            sourceComponent: internal.textComponent
            height: parent.height
            onLoaded: {
                item.linkedText = "V"
                item.text = Qt.binding(function() { return component.teamWins })
                item.textComponent.anchors.horizontalCenter = item.textComponent.parent.horizontalCenter
            }
        }

        Loader {
            sourceComponent: internal.textComponent
            height: parent.height
            onLoaded: {
                item.linkedText = "P"
                item.text = Qt.binding(function() { return component.teamLoses })
                item.textComponent.anchors.horizontalCenter = item.textComponent.parent.horizontalCenter
            }
        }

        Loader {
            sourceComponent: internal.textComponent
            height: parent.height
            onLoaded: {
                item.linkedText = "R"
                item.text = Qt.binding(function() { return component.teamTies })
                item.textComponent.anchors.horizontalCenter = item.textComponent.parent.horizontalCenter
            }
        }

        Loader {
            sourceComponent: internal.textComponent
            height: parent.height
            Layout.leftMargin: rowContent.spacing
            onLoaded: {
                item.linkedText = "skóre"
                item.text = Qt.binding(function() { return component.teamScore })
                item.textComponent.anchors.horizontalCenter = item.textComponent.parent.horizontalCenter
            }
        }

        Loader {
            sourceComponent: internal.textComponent
            height: parent.height
            Layout.leftMargin: rowContent.spacing
            onLoaded: {
                item.linkedText = "body"
                item.text = Qt.binding(function() { return component.teamPoints })
                item.textComponent.anchors.horizontalCenter = item.textComponent.parent.horizontalCenter
            }
        }
    }
}
