import QtQuick 2.12

Item {
    id: component

    property string teamHome: "DUKla praha"
    property string teamAway: "horka nad moravou"
    property int teamHomeScore: 0
    property int teamAwayScore: 0
    property alias teamHomeColor: teamHomeText.color
    property alias teamAwayColor: teamAwayText.color

    property string teamHomeSlug: ""
    property string teamAwaySlug: ""

    property color teamHomeBackgroundColor: "#631427"
    property color teamAwayBackgroundColor: "#00339c"

    property int animationsDuration: 250 * 1
    property int textAnimationsDuration: 120 * 1
    property int sideAnimationDelay: 150* 1

    property string matchState: "POLOČAS"

    height: component.width * 0.1325
    state: "full"

    QtObject {
        id: internal
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
                target: teamAwayClipper.mask
                sideAnchor: "left"
                width: teamAwayBox.width
            }
            PropertyChanges { target: teamAwayContainer; opacity: 1 }

            PropertyChanges {
                target: teamHomeClipper.mask
                sideAnchor: "right"
                width: teamHomeBox.width
            }
            PropertyChanges { target: teamHomeContainer; opacity: 1 }

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
                target: teamHomeClipper.mask
                sideAnchor: "left"
                width: 0
            }
            PropertyChanges { target: teamHomeContainer; opacity: 0 }

            PropertyChanges {
                target: teamAwayClipper.mask
                sideAnchor: "right"
                width: 0
            }
            PropertyChanges { target: teamAwayContainer; opacity: 0 }

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
                        duration: component.animationsDuration; easing.type: Easing.OutQuad }
                }
                SequentialAnimation {
                    NumberAnimation { duration: component.sideAnimationDelay}
                    NumberAnimation { target: teamHomeContainer; property: "opacity";
                        duration: component.textAnimationsDuration }
                    NumberAnimation { target: teamHomeClipper.mask; property: "width";
                        duration: component.animationsDuration; easing.type: Easing.OutQuad }
                }

                SequentialAnimation {
                    NumberAnimation { duration: 2 * component.sideAnimationDelay}
                    NumberAnimation { target: teamAwayContainer; property: "opacity";
                        duration: component.textAnimationsDuration }
                    NumberAnimation { target: teamAwayClipper.mask; property: "width";
                        duration: component.animationsDuration; easing.type: Easing.OutQuad }
                }


                SequentialAnimation {
                    NumberAnimation { duration: component.animationsDuration
                                                + 2 * component.sideAnimationDelay
                                                - component.textAnimationsDuration }
                    NumberAnimation { target: scoreBox.text; property: "opacity";
                        duration: component.textAnimationsDuration }
                    NumberAnimation { target: scoreBox.mask; property: "height";
                        duration: component.animationsDuration; easing.type: Easing.OutQuad }
                }
            }
        },

        Transition {
            from: "hidden"; to: "full"
            ParallelAnimation {
                SequentialAnimation {
                    NumberAnimation { target: scoreBox.mask; property: "height";
                        duration: component.animationsDuration; easing.type: Easing.OutQuad }
                    NumberAnimation { target: scoreBox.text; property: "opacity";
                        duration: component.textAnimationsDuration }
                }

                SequentialAnimation {
                    NumberAnimation { duration: component.animationsDuration }
                    NumberAnimation { target: teamHomeClipper.mask; property: "width";
                        duration: component.animationsDuration; easing.type: Easing.OutQuad }
                    NumberAnimation { target: teamHomeContainer; property: "opacity";
                        duration: component.textAnimationsDuration }
                }

                SequentialAnimation {
                    NumberAnimation { duration: component.sideAnimationDelay
                                                + component.animationsDuration }
                    NumberAnimation { target: teamAwayClipper.mask; property: "width";
                        duration: component.animationsDuration; easing.type: Easing.OutQuad }
                    NumberAnimation { target: teamAwayContainer; property: "opacity";
                        duration: component.textAnimationsDuration }
                }

                SequentialAnimation {
                    NumberAnimation { duration: component.animationsDuration
                                                + 2 * component.sideAnimationDelay }
                    NumberAnimation { target: timeBox.mask; property: "height";
                        duration: component.animationsDuration; easing.type: Easing.OutQuad }
                    NumberAnimation { target: timeBox.text; property: "opacity";
                        duration: component.textAnimationsDuration }
                }
            }
        }
    ]

    Item {
        id: scorePanel

        height: component.height * 0.5959

        anchors.left: component.left
        anchors.right: component.right
        anchors.top: component.top

        Rectangle {
            id: teamHomeBox

            width: parent.width * 0.39
            height: parent.height
            visible: false
            color: component.teamHomeBackgroundColor

            anchors.left: parent.left

            Item {
                id: teamHomeContainer
                anchors.fill: parent

                Image {
                    id: teamHomeLogo

                    source: (component.teamHomeSlug)
                            ?"../mc-club-logos-2019/2019/" + component.teamHomeSlug + ".png"
                            :""
                    width: height
                    height: 0.573 * parent.height
                    mipmap: true
                    fillMode: Image.PreserveAspectFit

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: parent.width * 0.054
                }

                Text {
                    id: teamHomeText

                    text: component.teamHome.toUpperCase()
                    font.family: "High School USA Sans"
                    font.pixelSize: 0.344 * teamHomeBox.height
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignRight

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.right: teamHomeLogo.left
                    anchors.rightMargin: teamHomeLogo.anchors.rightMargin
                    anchors.leftMargin: anchors.rightMargin
                }
            }
        }

        Rectangle {
            id: teamAwayBox

            width: parent.width * 0.39
            height: parent.height
            visible: false
            color: component.teamAwayBackgroundColor

            anchors.left: scoreBox.right

            Item {
                id: teamAwayContainer
                anchors.fill: parent

                Image {
                    id: teamAwayLogo

                    source: (component.teamAwaySlug)
                            ?"../mc-club-logos-2019/2019/" + component.teamAwaySlug + ".png"
                            :""
                    width: height
                    height: 0.573 * parent.height
                    mipmap: true
                    fillMode: Image.PreserveAspectFit

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.054
                }

                Text {
                    id: teamAwayText

                    text: component.teamAway.toUpperCase()
                    font.family: "High School USA Sans"
                    font.pixelSize: 0.344 * teamAwayBox.height
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignLeft

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.left: teamAwayLogo.right
                    anchors.leftMargin: teamAwayLogo.anchors.leftMargin
                    anchors.rightMargin: anchors.leftMargin
                }
            }
        }



        WrappedText {
            id: scoreBox

            width: scorePanel.width - teamAwayBox.width - teamHomeBox.width
            height: teamAwayBox.height

            text.text: ('0' + component.teamHomeScore).slice(-2)
                       + "-" + ('0' + component.teamAwayScore).slice(-2)
            text.font.pixelSize: height * 0.7
            style: internal.scoreStyle

            anchors.horizontalCenter: parent.horizontalCenter
        }

        MaskedClipper {
            id: teamHomeClipper

            source: teamHomeBox
            anchors.fill: teamHomeBox
        }

        MaskedClipper {
            id: teamAwayClipper

            source: teamAwayBox
            anchors.fill: teamAwayBox
        }
    }

    WrappedText {
        id: timeBox

        width: scoreBox.width
        height: component.height - scorePanel.height

        text.text: component.matchState
        text.font.pixelSize: height * 0.49
        style: internal.timeStyle

        anchors.top: scorePanel.bottom
        anchors.horizontalCenter: scorePanel.horizontalCenter
    }
}
