import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0


Item {
    id: component

    property int spacing: 0
    property int titleTextPixelSize: 0

    property string player1FirstName: ""
    property string player1LastName: ""
    property int player1Number: 0

    property string player2FirstName: ""
    property string player2LastName: ""
    property int player2Number: 0

    property string longestPlayerFirstName: ""
    property string longestPlayerLastName: ""

    property color teamTextColor: "black"
    property color color: "red"

    property int animationsDuration: 250
    property int animationsDelay: 0
    property int textAnimationsDuration: 120 * 1

    state: "hidden"

    QtObject {
        id: internal

        readonly property Component playerView: RowLayout {
            id: item

            property string playerFirstName: ""
            property string playerLastName: ""
            property int playerNumber: 0

            Item {
                width: 1.43 * height
                height: parent.height

                Text {
                    text: item.playerNumber
                    color: component.teamTextColor
                    visible: item.playerNumber != -1

                    font.family: "Saira Black"
                    font.pixelSize: parent.height * 0.65

                    anchors.centerIn: parent
                }
            }

            Item {
                height: firstname.height + lastname.height
                Layout.alignment: Qt.AlignVCenter

                Text {
                    id: lastname

                    text: item.playerLastName
                    color: "black"

                    font.family: "High School USA Sans"
                    font.pixelSize: component.height * 0.382

                    anchors.top: firstname.bottom
                }

                Text {
                    id: firstname

                    text: item.playerFirstName
                    color: "#444444"

                    font.family: "High School USA Sans"
                    font.pixelSize: component.height * 0.208
                }
            }

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }

    states: [
        State {
            name: "full"
            PropertyChanges { target: rowContent; opacity: 1 }
            PropertyChanges {
                target: backgroundClipper.mask
                sideAnchor: "left"
                width: component.width
            }
        },

        State {
            name: "hidden"
            PropertyChanges { target: rowContent; opacity: 0 }
            PropertyChanges {
                target: backgroundClipper.mask
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
                NumberAnimation { target: backgroundClipper.mask; property: "width";
                    duration: component.animationsDuration; easing.type: Easing.OutCubic }
            }
        },

        Transition {
            from: "hidden"; to: "full"
            SequentialAnimation {
                NumberAnimation { duration: component.animationsDelay }
                NumberAnimation { target: backgroundClipper.mask; property: "width";
                    duration: component.animationsDuration; easing.type: Easing.OutCubic }
                NumberAnimation { target: rowContent; property: "opacity";
                    duration: component.textAnimationsDuration }
            }
        }
    ]

    Row {
        id: background

        spacing: 2
        clip: true
        width: parent.width
        height: parent.height - 2
        visible: false

        Repeater {
            model: 2

            Rectangle {
                color: component.color
                height: parent.height
                width: parent.width / 2. - 1
            }
        }
    }

    MaskedClipper {
        id: backgroundClipper
        source: background
        anchors.fill: background
    }

    Row {
        id: rowContent

        height: parent.height
        width: parent.width

        anchors.left: parent.left
        anchors.right: parent.right

        Loader {
            sourceComponent: internal.playerView
            width: component.width / 2
            height: parent.height

            Component.onCompleted: {
                item.playerFirstName = Qt.binding(function() {
                    return component.player1FirstName
                })

                item.playerLastName = Qt.binding(function() {
                    return component.player1LastName
                })

                item.playerNumber = Qt.binding(function() {
                    return component.player1Number
                })
            }
        }

        Loader {
            sourceComponent: internal.playerView
            width: component.width / 2
            height: parent.height

            Component.onCompleted: {
                item.playerFirstName = Qt.binding(function() {
                    return component.player2FirstName
                })

                item.playerLastName = Qt.binding(function() {
                    return component.player2LastName
                })

                item.playerNumber = Qt.binding(function() {
                    return component.player2Number
                })
            }
        }
    }
}
