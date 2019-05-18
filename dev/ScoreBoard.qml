import QtQuick 2.0

Item {
    id: component

    property alias size: component.height

    // TODO change defaults
    property string teamHome: "LIT"
    property string teamAway: "DUK"
    property int teamHomeScore: 0
    property int teamAwayScore: 0
    property color teamHomeColor: "black"
    property color teamAwayColor: "red"
    property int animationsDuration: 350

    property int half: 1
    property string time: "00:00"

    width: teamHomeBox.width + scoreBox.width + teamAwayBox.width
    state: "compact"

    QtObject {
        id: internal

        readonly property BoxedTextStyle homeTeamStyle: BoxedTextStyle {
            hPadding: component.size / 11.8
            vPadding: hPadding
            textColor: "white"
            color: component.teamHomeColor
            font.family: "Cairo Light"
        }

        readonly property BoxedTextStyle awayTeamStyle: BoxedTextStyle {
            hPadding: component.size / 11.8
            vPadding: hPadding
            textColor: "white"
            color: component.teamAwayColor
            font.family: "Cairo Light"
        }

        readonly property StyledTextStyle scoreStyle: StyledTextStyle {
            textColor: "black"
            color: "white"
            font.family: "Cairo Black"
        }

        readonly property StyledTextStyle timeStyle: StyledTextStyle {
            textColor: "white"
            color: "#1df276"
            font.family: "Montserrat"
        }
    }

    states: [
        State {
            name: "_compact"
            PropertyChanges {
                target: teamHomeBox
                anchors.rightMargin: -scoreBox.width / 2
            }
            PropertyChanges {
                target: teamAwayBox
                anchors.leftMargin: -scoreBox.width / 2
            }
            PropertyChanges { target: timeBox;
                anchors.topMargin: -timeBox.height; opacity: 0 }
        },

        State {
            name: "compact"
            extend: "_compact"

            PropertyChanges { target: component; opacity: 1 }
            PropertyChanges { target: scoreBox; opacity: 1 }
        },

        State {
            name: "full"
            PropertyChanges { target: component; opacity: 1 }
            PropertyChanges { target: scoreBox; opacity: 1 }
            PropertyChanges { target: teamHomeBox; anchors.rightMargin: 0 }
            PropertyChanges { target: teamAwayBox; anchors.rightMargin: 0 }
            PropertyChanges { target: timeBox; anchors.topMargin: 0; opacity: 1}
        },

        State {
            name: "hidden"
            extend: "_compact"
            PropertyChanges { target: scoreBox; opacity: 0 }
            PropertyChanges { target: component; opacity: 0 }
        }

    ]

    transitions: [
        Transition {
            from: "compact"; to: "full"
            SequentialAnimation {
                ParallelAnimation {
                    NumberAnimation { target: teamHomeBox; property: "anchors.rightMargin"
                        duration: component.animationsDuration; easing.type: Easing.InOutQuad }
                    NumberAnimation { target: teamAwayBox; property: "anchors.leftMargin"
                        duration: component.animationsDuration; easing.type: Easing.InOutQuad }
                }
                NumberAnimation { target: timeBox; property: "opacity"; duration: 0 }
                NumberAnimation { target: timeBox; property: "anchors.topMargin";
                    duration: component.animationsDuration; easing.type: Easing.InOutQuad }
            }
        },

        Transition {
            from: "full"; to: "compact"
            SequentialAnimation {
                NumberAnimation { target: timeBox; property: "anchors.topMargin";
                    duration: component.animationsDuration; easing.type: Easing.InOutQuad }
                NumberAnimation { target: timeBox; property: "opacity"; duration: 0 }
                ParallelAnimation {
                    NumberAnimation { target: teamHomeBox; property: "anchors.rightMargin"
                        duration: component.animationsDuration; easing.type: Easing.InOutQuad }
                    NumberAnimation { target: teamAwayBox; property: "anchors.leftMargin"
                        duration: component.animationsDuration; easing.type: Easing.InOutQuad }
                }
            }
        },

        Transition {
            from: "full"; to: "hidden"
            SequentialAnimation {
                NumberAnimation { target: timeBox; property: "anchors.topMargin";
                    duration: component.animationsDuration; easing.type: Easing.InOutQuad }
                NumberAnimation { target: timeBox; property: "opacity"; duration: 0 }
                ParallelAnimation {
                    NumberAnimation { target: teamHomeBox; property: "anchors.rightMargin"
                        duration: component.animationsDuration; easing.type: Easing.InOutQuad }
                    NumberAnimation { target: teamAwayBox; property: "anchors.leftMargin"
                        duration: component.animationsDuration; easing.type: Easing.InOutQuad }
                }
                NumberAnimation { target: scoreBox; property: "opacity"; duration : 0 }
                NumberAnimation { target: component; property: "opacity"; duration : 250 }
            }
        },

        Transition {
            from: "hidden"; to: "full"
            SequentialAnimation {
                NumberAnimation { target: component; property: "opacity"; duration : 250 }
                NumberAnimation { target: scoreBox; property: "opacity"; duration : 0 }
                ParallelAnimation {
                    NumberAnimation { target: teamHomeBox; property: "anchors.rightMargin"
                        duration: component.animationsDuration; easing.type: Easing.InOutQuad }
                    NumberAnimation { target: teamAwayBox; property: "anchors.leftMargin"
                        duration: component.animationsDuration; easing.type: Easing.InOutQuad }
                }
                NumberAnimation { target: timeBox; property: "opacity"; duration: 0 }
                NumberAnimation { target: timeBox; property: "anchors.topMargin";
                    duration: component.animationsDuration; easing.type: Easing.InOutQuad }
            }
        },

        Transition {
            from: "compact"; to: "hidden"
            SequentialAnimation {
                ParallelAnimation {
                    NumberAnimation { target: scoreBox; property: "opacity"; duration : 250 }
                }
                NumberAnimation { target: component; property: "opacity"; duration : 250 }
            }
        },

        Transition {
            from: "hidden"; to: "compact"
            SequentialAnimation {
                NumberAnimation { target: component; property: "opacity"; duration : 250 }
                ParallelAnimation {
                    NumberAnimation { target: scoreBox; property: "opacity"; duration : 250 }
                }
            }
        }
    ]

    Item {
        id: scorePanel

        z: 1
        height: component.height * 0.5

        anchors.left: component.left
        anchors.right: component.right
        anchors.top: component.top

        BoxedText {
            id: teamHomeBox

            z: 1
            size: parent.height
            text.text: component.teamHome
            monospaceHack: true
            style: internal.homeTeamStyle

            anchors.right: scoreBox.left
        }

        BoxedText {
            id: teamAwayBox

            z: 1
            size: parent.height
            text.text: component.teamAway
            monospaceHack: true
            style: internal.awayTeamStyle

            anchors.left: scoreBox.right
        }

        WrappedText {
            id: scoreBox

            // TODO set width
            x: teamHomeBox.width
            width: 200
            height: teamAwayBox.height
            text.font.pixelSize: teamAwayBox.text.font.pixelSize
            text.text: ('0' + component.teamHomeScore).slice(-2)
                       + "-" + ('0' + component.teamAwayScore).slice(-2)
            style: internal.scoreStyle
        }
    }

    WrappedText {
        id: timeBox

        text.text: component.time
        width: scoreBox.width
        height: component.height - scorePanel.height
        style: internal.timeStyle

        anchors.top: scorePanel.bottom
        anchors.horizontalCenter: scorePanel.horizontalCenter
    }
}
