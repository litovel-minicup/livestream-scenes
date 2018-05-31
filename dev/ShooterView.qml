import QtQuick 2.0

Item {
    id: component

    property string playerName: "Pepča Kolo"
    property string teamName: "Litovel"
    property int playerNumber: 2
    property int showDelay: 0

    state: "hidden"

    QtObject {
        id: internal

        readonly property int animationsDuration: 800 * 0.6
        readonly property int opacityAnimationsDuration: 400 * 0.6

        readonly property BoxedTextStyle playerNumberStyle: BoxedTextStyle {
            vPadding: component.height / 9.
            hPadding: component.height / 7.2
            textColor: "#8A6D1C"
            color: "#F8CF00"
            font.family: "Montserrat"
        }

        readonly property BoxedTextStyle playerNameStyle: BoxedTextStyle {
            vPadding: component.height / 12.
            hPadding: component.height / 6.
            textColor: "#4E4A49"
            color: "#D7D6D6"
            font.family: "Montserrat"
        }

        readonly property BoxedTextStyle teamNameStyle: BoxedTextStyle {
            vPadding: component.height / 25.71
            hPadding: component.height / 5.14
            textColor: "#D5D3D3"
            color: "#696664"
            font.family: "Montserrat"
        }
    }

    states: [
        State {
            name: "hidden"
            PropertyChanges { target: playerNumber; opacity: 0 }
            PropertyChanges { target: playerName; x: -width }
            PropertyChanges { target: teamName; y: -height }
        },
        State {
            name: "visible"
            PropertyChanges { target: playerNumber; opacity: 1 }
            PropertyChanges { target: playerName; x: 0 }
            PropertyChanges { target: teamName; y: 0 }
        }
    ]

    transitions: [
        Transition {
            from: "visible"; to: "hidden"
            SequentialAnimation {
                NumberAnimation { target: teamName; property: "y";
                    duration: internal.animationsDuration; easing.type: Easing.InOutQuad }
                NumberAnimation { target: playerName; property: "x"
                    duration: internal.animationsDuration; easing.type: Easing.InOutQuad }
                NumberAnimation { target: playerNumber; property: "opacity"
                    duration: internal.opacityAnimationsDuration }
            }
        },
        Transition {
            from: "hidden"; to: "visible"
            SequentialAnimation {
                NumberAnimation { duration: component.showDelay }
                NumberAnimation { target: playerNumber; property: "opacity"
                    duration: internal.opacityAnimationsDuration }
                NumberAnimation { target: playerName; property: "x"
                    duration: internal.animationsDuration; easing.type: Easing.InOutQuad }
                NumberAnimation { target: teamName; property: "y";
                    duration: internal.animationsDuration; easing.type: Easing.InOutQuad }
            }
        }
    ]

    Item {
        id: playerNumberClipper

        clip: true
        height: parent.height
        width: playerNumber.width

        BoxedText {
            id: playerNumber

            text.text: component.playerNumber
            size: parent.height
            backgroundOpacity: 0.9
            style: internal.playerNumberStyle
        }
    }

    Item {
        id: playerNameClipper

        clip: true
        height: parent.height / 1.5
        width: playerName.width

        anchors.left: playerNumberClipper.right

        BoxedText {
            id: playerName

            text.text: component.playerName + "    "
            size: parent.height
//            alignWidth: teamName.width
            backgroundOpacity: 0.9
            style: internal.playerNameStyle

            text.anchors.centerIn: null
            text.anchors.left: textParent.left
            text.anchors.leftMargin: style.hPadding
        }
    }

    Item {
        id: teamNameClipper

        height: parent.height - playerNameClipper.height
        width: playerNameClipper.width
        clip: true

        anchors.top: playerNameClipper.bottom
        anchors.left: playerNameClipper.left

        BoxedText {
            id: teamName

            text.text: component.teamName + "    "
            size: parent.height
            alignWidth: playerName.width
            backgroundOpacity: 0.9
            style: internal.teamNameStyle

            text.anchors.centerIn: null
            text.anchors.left: textParent.left
            text.anchors.leftMargin: style.hPadding
        }
    }
}
