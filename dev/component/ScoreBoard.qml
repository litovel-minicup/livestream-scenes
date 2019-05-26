import QtQuick 2.0

Item {
    id: component

    property alias size: component.height

    // TODO change defaults
    property string teamHome: "DUK"
    property string teamAway: "TEL"
    property int teamHomeScore: 0
    property int teamAwayScore: 0
    property color teamHomeColor: "#631427"
    property color teamAwayColor: "#00339c"
    property int animationsDuration: 350 * 1
    property int textAnimationsDuration: 120 * 1
    property int sideAnimationDelay: 200 * 1

    property int half: 1
    property string time: "00:00"

    width: component.size * 3.6
    state: "full"

    QtObject {
        id: internal

        readonly property StyledTextStyle homeTeamStyle: StyledTextStyle {
            textColor: "white"
            color: component.teamHomeColor
            font.family: "High School USA Sans"
        }

        readonly property StyledTextStyle awayTeamStyle: StyledTextStyle {
            textColor: "white"
            color: component.teamAwayColor
            font.family: "High School USA Sans"
        }

        readonly property StyledTextStyle scoreStyle: StyledTextStyle {
            textColor: "black"
            color: "white"
            font.family: "Saira Black"
        }

        readonly property StyledTextStyle timeStyle: StyledTextStyle {
            textColor: "black"
            color: "#1df276"
            font.family: "Saira"
        }
    }

    states: [
        State {
            name: "full"
            PropertyChanges {
                target: scoreBox.mask
                sideAnchor: "bottom"
                height: scoreBox.height
            }
            PropertyChanges { target: scoreBox.text; opacity: 1 }

            PropertyChanges {
                target: teamAwayBox.mask
                sideAnchor: "left"
                width: teamAwayBox.width
            }
            PropertyChanges { target: teamAwayBox.text; opacity: 1 }

            PropertyChanges {
                target: teamHomeBox.mask
                sideAnchor: "right"
                width: teamHomeBox.width
            }
            PropertyChanges { target: teamHomeBox.text; opacity: 1 }

            PropertyChanges {
                target: timeBox.mask
                sideAnchor: "bottom"
                height: timeBox.height
            }
            PropertyChanges { target: timeBox.text; opacity: 1 }
        },

        State {
            name: "hidden"
            PropertyChanges {
                target: scoreBox.mask
                sideAnchor: "top"
                height: 0
            }
            PropertyChanges { target: scoreBox.text; opacity: 0 }

            PropertyChanges {
                target: teamHomeBox.mask
                sideAnchor: "left"
                width: 0
            }
            PropertyChanges { target: teamHomeBox.text; opacity: 0 }

            PropertyChanges {
                target: teamAwayBox.mask
                sideAnchor: "right"
                width: 0
            }
            PropertyChanges { target: teamAwayBox.text; opacity: 0 }

            PropertyChanges {
                target: timeBox.mask
                sideAnchor: "top"
                height: 0
            }
            PropertyChanges { target: timeBox.text; opacity: 0 }
        }

    ]

    transitions: [
        Transition {
            from: "full"; to: "hidden"
            ParallelAnimation {
                SequentialAnimation {
                    NumberAnimation { target: timeBox.text; property: "opacity";
                        duration: component.textAnimationsDuration }
                    NumberAnimation { target: timeBox.mask; property: "height";
                        duration: component.animationsDuration; easing.type: Easing.OutCubic }
                }
                SequentialAnimation {
                    NumberAnimation { duration: component.sideAnimationDelay}
                    NumberAnimation { target: teamHomeBox.text; property: "opacity";
                        duration: component.textAnimationsDuration }
                    NumberAnimation { target: teamHomeBox.mask; property: "width";
                        duration: component.animationsDuration; easing.type: Easing.OutCubic }
                }

                SequentialAnimation {
                    NumberAnimation { duration: 2 * component.sideAnimationDelay}
                    NumberAnimation { target: teamAwayBox.text; property: "opacity";
                        duration: component.textAnimationsDuration }
                    NumberAnimation { target: teamAwayBox.mask; property: "width";
                        duration: component.animationsDuration; easing.type: Easing.OutCubic }
                }


                SequentialAnimation {
                    NumberAnimation { duration: component.animationsDuration
                                                + 2 * component.sideAnimationDelay }
                    NumberAnimation { target: scoreBox.text; property: "opacity";
                        duration: component.textAnimationsDuration }
                    NumberAnimation { target: scoreBox.mask; property: "height";
                        duration: component.animationsDuration; easing.type: Easing.OutCubic }
                }
            }
        },

        Transition {
            from: "hidden"; to: "full"
            ParallelAnimation {
                SequentialAnimation {
                    NumberAnimation { target: scoreBox.mask; property: "height";
                        duration: component.animationsDuration; easing.type: Easing.OutCubic }
                    NumberAnimation { target: scoreBox.text; property: "opacity";
                        duration: component.textAnimationsDuration }
                }

                SequentialAnimation {
                    NumberAnimation { duration: component.animationsDuration }
                    NumberAnimation { target: teamHomeBox.mask; property: "width";
                        duration: component.animationsDuration; easing.type: Easing.OutCubic }
                    NumberAnimation { target: teamHomeBox.text; property: "opacity";
                        duration: component.textAnimationsDuration }
                }

                SequentialAnimation {
                    NumberAnimation { duration: component.sideAnimationDelay
                                                + component.animationsDuration }
                    NumberAnimation { target: teamAwayBox.mask; property: "width";
                        duration: component.animationsDuration; easing.type: Easing.OutCubic }
                    NumberAnimation { target: teamAwayBox.text; property: "opacity";
                        duration: component.textAnimationsDuration }
                }

                SequentialAnimation {
                    NumberAnimation { duration: component.animationsDuration
                                                + 2 * component.sideAnimationDelay }
                    NumberAnimation { target: timeBox.mask; property: "height";
                        duration: component.animationsDuration; easing.type: Easing.OutCubic }
                    NumberAnimation { target: timeBox.text; property: "opacity";
                        duration: component.textAnimationsDuration }
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

        WrappedText {
            id: teamHomeBox

            width: parent.width * 0.3062
            height: parent.height

            text.text: component.teamHome
            text.font.pixelSize: height * 0.6
            style: internal.homeTeamStyle

            anchors.right: scoreBox.left
        }

        WrappedText {
            id: teamAwayBox

//            x: scoreBox.x + scoreBox.width
            width: parent.width * 0.3062
            height: parent.height

            text.text: component.teamAway
            text.font.pixelSize: teamHomeBox.text.font.pixelSize
            style: internal.awayTeamStyle

            anchors.left: scoreBox.right
        }

        WrappedText {
            id: scoreBox

            width: scorePanel.width - teamAwayBox.width - teamHomeBox.width
            height: teamAwayBox.height

            text.text: ('0' + component.teamHomeScore).slice(-2)
                       + " - " + ('0' + component.teamAwayScore).slice(-2)
            text.font.pixelSize: height * 0.579
            style: internal.scoreStyle

            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    WrappedText {
        id: timeBox

        width: scoreBox.width
        height: component.height - scorePanel.height

        text.text: component.time
        text.font.pixelSize: height * 0.530
        style: internal.timeStyle

        anchors.top: scorePanel.bottom
        anchors.horizontalCenter: scorePanel.horizontalCenter
    }
}
