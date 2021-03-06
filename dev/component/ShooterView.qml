import QtQuick 2.12

Item {
    id: component

    property string playerName: "Pepa kolo"
    property string teamName: "Litovel"
    property string slug: "dukla-praha"
    property color primaryColor: "#670f1b"
    property color secondaryColor: "#fcc824"
    property color textColor: "black"
    property alias teamNameTextColor: teamName.color

    property int animationsDuration: 250 * 1.5
    property int textAnimationsDuration: 120 * 1.5
    property int sideAnimationDelay: 150* 1.5

    state: "hidden"

    QtObject {
        id: internal

        property int maxTextWidth: 0
    }

    function updateMaxWidth() {
        if(!playerName || !teamName)
            return 0

        var maxWidth;
        if(component.playerName == "") {
            maxWidth = playerName.width + playerName.anchors.leftMargin
            internal.maxTextWidth = maxWidth
            return maxWidth
        }

        maxWidth = Math.max(teamName.width + teamName.anchors.leftMargin,
                                playerName.width + playerName.anchors.leftMargin)

        internal.maxTextWidth = maxWidth
        return maxWidth
    }

    states: [
        State {
            name: "hidden"
            PropertyChanges { target: logo; opacity: 0 }
            PropertyChanges { target: teamName; opacity: 0 }
            PropertyChanges { target: playerName; opacity: 0 }
            PropertyChanges {
                target: teamNameBackground
                sideAnchor: "right"
                width: 0
            }
            PropertyChanges {
                target: playerNameBackground
                sideAnchor: "right"
                width: 0
            }
            PropertyChanges {
                target: logoBackground
                sideAnchor: "left"
                width: 0
            }
        },
        State {
            name: "full"
            PropertyChanges { target: logo; opacity: 1 }
            PropertyChanges { target: teamName; opacity: 1 }
            PropertyChanges { target: playerName; opacity: 1 }
            PropertyChanges {
                target: teamNameBackground
                sideAnchor: "left"
                width: teamNameContainer.width //component.updateMaxWidth()
            }
            PropertyChanges {
                target: playerNameBackground
                sideAnchor: "left"
                width: playerNameContainer.width// component.updateMaxWidth()
            }
            PropertyChanges {
                target: logoBackground
                sideAnchor: "right"
                width: logoContainer.width
            }
        }
    ]

    transitions: [
        Transition {
            from: "full"; to: "hidden"
            ParallelAnimation {
                SequentialAnimation {
                    NumberAnimation { target: logo; property: "opacity";
                        duration: component.textAnimationsDuration }
                    NumberAnimation { target: logoBackground; property: "width";
                        duration: component.animationsDuration; easing.type: Easing.OutCubic }
                }
                SequentialAnimation {
                    NumberAnimation { duration: component.sideAnimationDelay * 1}
                    NumberAnimation { target: playerName; property: "opacity";
                        duration: component.textAnimationsDuration }
                    NumberAnimation { target: playerNameBackground; property: "width";
                        duration: component.animationsDuration; easing.type: Easing.OutCubic }
                }

                SequentialAnimation {
                    NumberAnimation { duration: component.sideAnimationDelay * 2 }
                    NumberAnimation { target: teamName; property: "opacity";
                        duration: component.textAnimationsDuration }
                    NumberAnimation { target: teamNameBackground; property: "width";
                        duration: component.animationsDuration; easing.type: Easing.OutCubic }
                }
            }
        },
        Transition {
            from: "hidden"; to: "full"
            ParallelAnimation {
                SequentialAnimation {
                    NumberAnimation { target: logoBackground; property: "width";
                        duration: component.animationsDuration; easing.type: Easing.OutQuad }
                    NumberAnimation { target: logo; property: "opacity";
                        duration: component.textAnimationsDuration }
                }

                SequentialAnimation {
                    NumberAnimation { duration: component.sideAnimationDelay * 1 }
                    NumberAnimation { target: playerNameBackground; property: "width";
                        duration: component.animationsDuration; easing.type: Easing.OutCubic }
                    NumberAnimation { target: playerName; property: "opacity";
                        duration: component.textAnimationsDuration }
                }

                SequentialAnimation {
                    NumberAnimation { duration: component.sideAnimationDelay * 2 }
                    NumberAnimation { target: teamNameBackground; property: "width";
                        duration: component.animationsDuration; easing.type: Easing.OutCubic }
                    NumberAnimation { target: teamName; property: "opacity";
                        duration: component.textAnimationsDuration }
                }

            }
        }
    ]

    Item {
        id: logoContainer

        height: parent.height
        width: height * 1.14

        SideAnchoredRect {
            id: logoBackground

            color: component.primaryColor
            width: parent.width
            height: parent.height
        }

        Image {
            id: logo

            source: (component.slug)
                    ?"../mc-club-logos-2019/2019/" + component.slug + ".png" :""
            width: 0.725 * parent.width
            height: width
            mipmap: true
            fillMode: Image.PreserveAspectFit

            anchors.centerIn: parent
        }
    }

    Item {
        id: playerNameContainer

        height: parent.height - teamNameContainer.height
        width: internal.maxTextWidth

        anchors.left: logoContainer.right

        SideAnchoredRect {
            id: playerNameBackground

            width: parent.width
            height: parent.height
            color: "white"
        }

        Item {
            width: parent.width
            height: parent.height
            y: parent.height * 0.05

            Text {
                id: playerName

                text: (((component.playerName == "")
                            ?component.teamName :component.playerName)+ "   ").toUpperCase()
                color: component.textColor

                font.pixelSize: parent.height * 0.45
                font.family: "High School USA Sans"

                anchors.left: parent.left
                anchors.leftMargin: component.height * 0.2
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Item {
        id: teamNameContainer

        height: (component.playerName == "") ?0 :(parent.height * 0.38)
        width: internal.maxTextWidth

        anchors.top: playerNameContainer.bottom
        anchors.left: playerNameContainer.left


        SideAnchoredRect {
            id: teamNameBackground

            width: parent.width
            height: parent.height
            color: component.secondaryColor
        }

        Text {
            id: teamName

            text: component.teamName + "   "
            color: (teamNameBackground.color.hslLightness < 0.5) ?"white" :"black"
            visible: (component.playerName != "")

            font.pixelSize: parent.height * 0.518
            font.family: "Saira"

            anchors.left: parent.left
            anchors.leftMargin: component.height * 0.2
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
