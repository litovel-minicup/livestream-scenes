import QtQuick 2.9

Item {
    id: component

    property int homeTeamScore: 0
    property int awayTeamScore: 0
    property string homeTeamName: "Kostelec na Hané"
    property string awayTeamName: "Dub nad Moravou"
    property string matchState: "POLOČAS"

    state: "hidden"

    QtObject {
        id: internal

        readonly property int animationsDuration: 450 * 1.2
        readonly property int opacityAnimationsDuration: 250 * 1.2
        readonly property color matchStateColor: "#2F2C29"
        readonly property color matchStateTextColor: "white"
        readonly property BoxedTextStyle scoreStyle: BoxedTextStyle {
            hPadding: component.height / 7.75
            vPadding: component.height / 10.3
            textColor: "white"
            color: "#4B4B4B"
            font.family: "Montserrat"
        }

        property StyledTextStyle teamNamesStyle: StyledTextStyle {
            color: "#686868"
            textColor: "white"
            backgroundOpacity: 0.9
            font.family: "Montserrat"
        }

        property StyledTextStyle winTeamNameStyle: StyledTextStyle {
            color: "#F8CF00"
            textColor: "#8A6D1D"
            backgroundOpacity: 0.9
            font.family: "Montserrat"
        }
    }

    states: [
        State {
            name: "hidden"
            PropertyChanges { target: homeTeamScore; opacity: 0 }
            PropertyChanges { target: awayTeamScore; opacity: 0 }
            PropertyChanges { target: homeTeamName; x: width }
            PropertyChanges { target: awayTeamName; x: -width }
            PropertyChanges { target: matchStateBar; y: -height }
        },
        State {
            name: "visible"
            PropertyChanges { target: homeTeamScore; opacity: 1 }
            PropertyChanges { target: awayTeamScore; opacity: 1 }
            PropertyChanges { target: homeTeamName; x: 0 }
            PropertyChanges { target: awayTeamName; x: 0 }
            PropertyChanges { target: matchStateBar; y: 0 }
        }
    ]

    transitions: [
        Transition {
            from: "hidden"; to: "visible"
            SequentialAnimation {
                ParallelAnimation {
                    NumberAnimation { target: homeTeamScore; property: "opacity"
                        duration: internal.opacityAnimationsDuration }
                    NumberAnimation { target: awayTeamScore; property: "opacity"
                        duration: internal.opacityAnimationsDuration }
                }
                ParallelAnimation {
                    NumberAnimation { target: homeTeamName; property: "x"
                        duration: internal.animationsDuration; easing.type: Easing.InOutQuad }
                    NumberAnimation { target: awayTeamName; property: "x"
                        duration: internal.animationsDuration; easing.type: Easing.InOutQuad }
                }
                NumberAnimation { target: matchStateBar; property: "y"
                    duration: internal.animationsDuration; easing.type: Easing.InOutQuad }
            }
        },
        Transition {
            from: "visible"; to: "hidden"
            SequentialAnimation {
                NumberAnimation { target: matchStateBar; property: "y"
                    duration: internal.animationsDuration; easing.type: Easing.InOutQuad }
                ParallelAnimation {
                    NumberAnimation { target: homeTeamName; property: "x"
                        duration: internal.animationsDuration; easing.type: Easing.InOutQuad }
                    NumberAnimation { target: awayTeamName; property: "x"
                        duration: internal.animationsDuration; easing.type: Easing.InOutQuad }
                }
                ParallelAnimation {
                    NumberAnimation { target: homeTeamScore; property: "opacity"
                        duration: internal.opacityAnimationsDuration }
                    NumberAnimation { target: awayTeamScore; property: "opacity"
                        duration: internal.opacityAnimationsDuration }
                }
            }
        }
    ]

    Row {
        id: row

        readonly property real remainingWidth: row.width -  homeTeamScore.width - awayTeamScore.width

        width: component.width
        height: component.height / 1.35

        Item {  // clipper
            id: clippedHomeTeamName

            width: Math.ceil(row.remainingWidth / 2)
            height: parent.height
            clip: true

            WrappedText {
                id: homeTeamName

                width: parent.width
                height: parent.height
                style: (component.homeTeamScore > component.awayTeamScore)
                       ?internal.winTeamNameStyle :internal.teamNamesStyle

                text.text: component.homeTeamName
                text.font.pixelSize: component.height / 4.43
            }
        }

        BoxedText {
            id: homeTeamScore

            text.text: component.homeTeamScore
            monospaceHack: true
            backgroundOpacity: 0.9
            size: parent.height
            style: internal.scoreStyle
        }

        BoxedText {
            id: awayTeamScore

            text.text: component.awayTeamScore
            backgroundOpacity: 0.9
            monospaceHack: true
            size: parent.height
            style: internal.scoreStyle
        }

        Item {  // clipper
            width: component.width -
                   (clippedHomeTeamName.width + homeTeamScore.width + awayTeamScore.width)
            height: parent.height
            clip: true

            WrappedText {
                id: awayTeamName

                width: parent.width
                height: parent.height
                style: (component.awayTeamScore > component.homeTeamScore)
                       ?internal.winTeamNameStyle :internal.teamNamesStyle

                text.text: component.awayTeamName
                text.font.pixelSize: component.height / 4.43
            }
        }
    }

    // MATCH STATE
    Item {      // clipper
        width: component.width
        height: component.height - row.height
        clip: true

        anchors.top: row.bottom

        Item {
            id: matchStateBar

            width: parent.width
            height: parent.height

            Rectangle {
                opacity: 0.9
                color: internal.matchStateColor
                anchors.fill: parent
            }

            Text {
                text: component.matchState
                color: "white"
                font.family: "Montserrat Light"
                font.pixelSize: parent.height * 0.65

                anchors.centerIn: parent
            }
        }
    }
}
