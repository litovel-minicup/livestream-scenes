import QtQuick 2.0

Item {
    id: component

    property alias size: component.height

    // TODO change defaults
    property string teamHome: "LIT"
    property string teamAway: "DUK"
    property int teamHomeScore: 30
    property int teamAwayScore: 22
    property int animationsDuration: 350

    property int half: 1
    property string time: "13:25"

    width: teamHomeBox.width + teamHomeScoreBox.width + teamAwayBox.width + teamAwayScoreBox.width
    state: "compact"

    QtObject {
        id: internal

        readonly property BoxedTextStyle teamsStyle: BoxedTextStyle {
            hPadding: component.size / 11.8
            vPadding: hPadding
            textColor: "white"
            color: "#1a75bc"
            font.family: "Montserrat Light"
        }

        readonly property BoxedTextStyle scoreStyle: BoxedTextStyle {
            hPadding: component.size / 11.8
            vPadding: hPadding
            textColor: "black"
            color: "#cecece"
            font.family: "Montserrat"
        }

        readonly property BoxedTextStyle halfStyle: BoxedTextStyle {
            hPadding: component.size / 7.2
            vPadding: component.size / 11.8
            textColor: "white"
            color: "#636363"
            font.family: "Montserrat Light"
        }

        readonly property BoxedTextStyle timeStyle: BoxedTextStyle {
            hPadding: component.size / 7.2
            vPadding: component.size / 11.8
            textColor: "white"
            color: "#474747"
            font.family: "Montserrat Light"
        }
    }

    states: [
        State {
            name: "_compact"
            PropertyChanges {
                target: teamHomeBox
                anchors.rightMargin: -teamHomeScoreBox.width + internal.scoreStyle.hPadding / 5 }
            PropertyChanges {
                target: teamAwayBox
                anchors.leftMargin: -teamAwayScoreBox.width + internal.scoreStyle.hPadding / 5 }
            PropertyChanges { target: timePanel;
                anchors.topMargin: -timePanel.height; opacity: 0 }
        },

        State {
            name: "compact"
            extend: "_compact"

            PropertyChanges { target: component; opacity: 1 }
            PropertyChanges { target: teamAwayScoreBox; opacity: 1 }
            PropertyChanges { target: teamHomeScoreBox; opacity: 1 }
        },

        State {
            name: "full"
            PropertyChanges { target: component; opacity: 1 }
            PropertyChanges { target: teamAwayScoreBox; opacity: 1 }
            PropertyChanges { target: teamHomeScoreBox; opacity: 1 }
            PropertyChanges { target: teamHomeBox; anchors.rightMargin: 0 }
            PropertyChanges { target: teamAwayBox; anchors.rightMargin: 0 }
            PropertyChanges { target: timePanel; anchors.topMargin: 0; opacity: 1}
        },

        State {
            name: "hidden"
            extend: "_compact"
            PropertyChanges { target: teamAwayScoreBox; opacity: 0 }
            PropertyChanges { target: teamHomeScoreBox; opacity: 0 }
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
                NumberAnimation { target: timePanel; property: "opacity"; duration: 0 }
                NumberAnimation { target: timePanel; property: "anchors.topMargin";
                    duration: component.animationsDuration; easing.type: Easing.InOutQuad }
            }
        },

        Transition {
            from: "full"; to: "compact"
            SequentialAnimation {
                NumberAnimation { target: timePanel; property: "anchors.topMargin";
                    duration: component.animationsDuration; easing.type: Easing.InOutQuad }
                NumberAnimation { target: timePanel; property: "opacity"; duration: 0 }
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
                NumberAnimation { target: timePanel; property: "anchors.topMargin";
                    duration: component.animationsDuration; easing.type: Easing.InOutQuad }
                NumberAnimation { target: timePanel; property: "opacity"; duration: 0 }
                ParallelAnimation {
                    NumberAnimation { target: teamHomeBox; property: "anchors.rightMargin"
                        duration: component.animationsDuration; easing.type: Easing.InOutQuad }
                    NumberAnimation { target: teamAwayBox; property: "anchors.leftMargin"
                        duration: component.animationsDuration; easing.type: Easing.InOutQuad }
                }
                NumberAnimation { target: teamAwayScoreBox; property: "opacity"; duration : 0 }
                NumberAnimation { target: teamHomeScoreBox; property: "opacity"; duration : 0 }
                NumberAnimation { target: component; property: "opacity"; duration : 250 }
            }
        },

        Transition {
            from: "hidden"; to: "full"
            SequentialAnimation {
                NumberAnimation { target: component; property: "opacity"; duration : 250 }
                NumberAnimation { target: teamAwayScoreBox; property: "opacity"; duration : 0 }
                NumberAnimation { target: teamHomeScoreBox; property: "opacity"; duration : 0 }
                ParallelAnimation {
                    NumberAnimation { target: teamHomeBox; property: "anchors.rightMargin"
                        duration: component.animationsDuration; easing.type: Easing.InOutQuad }
                    NumberAnimation { target: teamAwayBox; property: "anchors.leftMargin"
                        duration: component.animationsDuration; easing.type: Easing.InOutQuad }
                }
                NumberAnimation { target: timePanel; property: "opacity"; duration: 0 }
                NumberAnimation { target: timePanel; property: "anchors.topMargin";
                    duration: component.animationsDuration; easing.type: Easing.InOutQuad }
            }
        },

        Transition {
            from: "compact"; to: "hidden"
            SequentialAnimation {
                ParallelAnimation {
                    NumberAnimation { target: teamAwayScoreBox; property: "opacity"; duration : 250 }
                    NumberAnimation { target: teamHomeScoreBox; property: "opacity"; duration : 250 }
                }
                NumberAnimation { target: component; property: "opacity"; duration : 250 }
            }
        },

        Transition {
            from: "hidden"; to: "compact"
            SequentialAnimation {
                NumberAnimation { target: component; property: "opacity"; duration : 250 }
                ParallelAnimation {
                    NumberAnimation { target: teamAwayScoreBox; property: "opacity"; duration : 250 }
                    NumberAnimation { target: teamHomeScoreBox; property: "opacity"; duration : 250 }
                }
            }
        }
    ]

    Item {
        id: scorePanel

        z: 1
        height: component.height / 1.8

        anchors.left: component.left
        anchors.right: component.right
        anchors.top: component.top

        BoxedText {
            id: teamHomeBox

            z: 1
            size: parent.height
            text.text: component.teamHome
            style: internal.teamsStyle

            anchors.right: teamHomeScoreBox.left
        }

        BoxedText {
            id: teamAwayBox

            z: 1
            size: parent.height
            text.text: component.teamAway
            style: internal.teamsStyle

            anchors.left: teamAwayScoreBox.right
        }

        BoxedText {
            id: teamHomeScoreBox

            x: teamHomeBox.width
            size: parent.height
            monospaceHack: true
            text.text: component.teamHomeScore
            style: internal.scoreStyle
        }

        BoxedText {
            id: teamAwayScoreBox

            size: parent.height
            monospaceHack: true
            text.text: component.teamAwayScore
            style: internal.scoreStyle

            anchors.left: teamHomeScoreBox.right
        }
    }

    Item {
        id: timePanel

        x: teamHomeScoreBox.x + (teamHomeScoreBox.width + teamAwayScoreBox.width) / 2 - width / 2
        width: halfBox.width + timeBox.width
        height: component.height - scorePanel.height

        anchors.top: scorePanel.bottom

        BoxedText {
            id: halfBox

            text.text: component.half.toString() + "/2"
            monospaceHack: true
            size: parent.height
            style: internal.halfStyle
        }

        BoxedText {
            id: timeBox

            text.text: component.time
            monospaceHack: true
            size: parent.height
            style: internal.timeStyle

            anchors.left: halfBox.right
        }
    }
}
