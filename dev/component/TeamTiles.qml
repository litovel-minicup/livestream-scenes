import QtQuick 2.12

Item {
    id: component

    property alias teamAwayColor: teamAwayTile.color
    property alias teamHomeColor: teamHomeTile.color
    property string teamAwaySlug: ""
    property string teamHomeSlug: ""
    property alias teamHome: teamHomeText.text
    property alias teamAway: teamAwayText.text
    property alias teamHomeTextColor: teamHomeText.color
    property alias teamAwayTextColor: teamAwayText.color
    property int animationsDuration: 600
    property int textAnimationsDuration: 200 * 1
    property int sideAnimationDelay: 300 * 1

    state: "hidden"
    states: [
        State {
            name: "hidden"
            PropertyChanges {
                target: teamHomeTileClipper.mask
                sideAnchor: "right"
                width: 0
            }
            PropertyChanges {
                target: teamAwayTileClipper.mask
                sideAnchor: "left"
                width: 0
            }
            PropertyChanges {
                target: teamAwayContainer
                opacity: 0
            }
            PropertyChanges {
                target: teamHomeContainer
                opacity: 0
            }
        },

        State {
            name: "full"
            PropertyChanges {
                target: teamHomeTileClipper.mask
                sideAnchor: "left"
                width: teamHomeTile.width
            }
            PropertyChanges {
                target: teamAwayTileClipper.mask
                sideAnchor: "right"
                width: teamAwayTile.width
            }
            PropertyChanges {
                target: teamAwayContainer
                opacity: 1
            }
            PropertyChanges {
                target: teamHomeContainer
                opacity: 1
            }
        }
    ]

    transitions: [
        Transition {
            from: "hidden"; to: "full"
            ParallelAnimation {
                SequentialAnimation {
                    NumberAnimation { target: teamHomeTileClipper.mask; property: "width";
                        duration: component.animationsDuration; easing.type: Easing.OutCubic }
                    NumberAnimation { target: teamHomeContainer; property: "opacity";
                        duration: component.textAnimationsDuration }
                }


                SequentialAnimation {
                    NumberAnimation { duration: component.sideAnimationDelay }
                    NumberAnimation { target: teamAwayTileClipper.mask; property: "width";
                        duration: component.animationsDuration; easing.type: Easing.OutCubic }
                    NumberAnimation { target: teamAwayContainer; property: "opacity";
                        duration: component.textAnimationsDuration }
                }
            }
        },

        Transition {
            from: "full"; to: "hidden"
            ParallelAnimation {
                SequentialAnimation {
                    NumberAnimation { target: teamHomeContainer; property: "opacity";
                        duration: component.textAnimationsDuration }
                    NumberAnimation { target: teamHomeTileClipper.mask; property: "width";
                        duration: component.animationsDuration; easing.type: Easing.OutCubic }
                }


                SequentialAnimation {
                    NumberAnimation { duration: component.sideAnimationDelay }
                    NumberAnimation { target: teamAwayContainer; property: "opacity";
                        duration: component.textAnimationsDuration }
                    NumberAnimation { target: teamAwayTileClipper.mask; property: "width";
                        duration: component.animationsDuration; easing.type: Easing.OutCubic }
                }
            }
        }
    ]

    Rectangle {
        id: teamHomeTile

        width: parent.width / 2
        height: parent.height * 0.567
        visible: false

        anchors.top: parent.top
        anchors.left: parent.left

        Item {
            id: teamHomeContainer

            width: Math.max(teamHomeLogo.width, teamHomeText.width)
            height: teamHomeLogo.height + teamHomeText.height
                    + 2 * teamHomeLogo.anchors.topMargin - teamHomeText.font.pixelSize * 0.1

            anchors.centerIn: parent

            Image {
                id: teamHomeLogo

                source: (teamHomeSlug)
                        ?"../mc-club-logos-2019/2019/" + teamHomeSlug + ".png" :""
                width: height
                height: 0.3 * teamHomeTile.height
                mipmap: true
                fillMode: Image.PreserveAspectFit

                anchors.top: parent.top
                anchors.topMargin: (paintedHeight - height) / 2
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: teamHomeText

                font.family: "High School USA Sans"
                font.pixelSize: 0.4 * teamHomeTile.height

                anchors.top: teamHomeLogo.bottom
                anchors.topMargin: teamHomeTile.height * 0.05903
                                   + teamHomeLogo.anchors.topMargin
                                   - font.pixelSize * 0.1
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }


    Rectangle {
        id: teamAwayTile

        height: teamHomeTile.height
        visible: false

        anchors.left: teamHomeTile.right
        anchors.bottom: component.bottom
        anchors.right: parent.right

        Item {
            id: teamAwayContainer

            width: Math.max(teamAwayLogo.width, teamAwayText.width)
            height: teamAwayLogo.height + teamAwayText.height
                    + 2 * teamAwayLogo.anchors.topMargin - teamAwayText.font.pixelSize * 0.1

            anchors.centerIn: parent

            Image {
                id: teamAwayLogo

                source: (teamAwaySlug)
                        ?"../mc-club-logos-2019/2019/" + teamAwaySlug + ".png" :""
                width: height
                height: 0.3 * teamAwayTile.height
                mipmap: true
                fillMode: Image.PreserveAspectFit

                anchors.top: parent.top
                anchors.topMargin: (paintedHeight - height) / 2
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: teamAwayText

                font.family: "High School USA Sans"
                font.pixelSize: 0.4 * teamAwayTile.height

                anchors.top: teamAwayLogo.bottom
                anchors.topMargin: teamAwayTile.height * 0.05903
                                   + teamAwayLogo.anchors.topMargin
                                   - font.pixelSize * 0.1
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    MaskedClipper {
        id: teamHomeTileClipper

        source: teamHomeTile
        anchors.fill: teamHomeTile
    }

    MaskedClipper {
        id: teamAwayTileClipper

        source: teamAwayTile
        anchors.fill: teamAwayTile
    }
}
