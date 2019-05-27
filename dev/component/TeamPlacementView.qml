import QtQuick 2.12

Item {
    id: component

    signal nextPage

    property string categoryName: "mladší"
    property var slugs: ["dukla-praha", "dukla-praha", "dukla-praha"]
    property var names: ["Telnice", "foo", "Horna nad Moravou"]
    property var textColors: ["#69121b", "red", "blue"]
    property int nameMaxLen: 17
    property var places: [1, 2, 3]

    property int animationsDuration: 250 * 1
    property int textAnimationsDuration: 120 * 1
    property int sideAnimationDelay: 150 * 1

    width: teamPlacementContainer.width
    state: "full"
    onNextPage: {
        if(internal.currentPage < component.names.length - 1 && component.state == "full")
            internal.animateNextPage()
    }

    QtObject {
        id: internal

        signal animateNextPage
        property int currentPage: 0

        onAnimateNextPage: SequentialAnimation {
            ScriptAction { script: {
                teamPlacementClipper.mask.sideAnchor = "right"
            }}

            SequentialAnimation {
                NumberAnimation { targets: [place, teamInfoWrapper]; property: "opacity";
                    to: 0 ;duration: component.textAnimationsDuration }
                NumberAnimation { target: teamPlacementClipper.mask; property: "width";
                    to: 0;
                    duration: component.animationsDuration * 2; easing.type: Easing.OutQuad }
            }

            ScriptAction { script: {
                internal.currentPage++;
                teamPlacementClipper.mask.sideAnchor = "left"
            }}


            SequentialAnimation {
                NumberAnimation { target: teamPlacementClipper.mask; property: "width";
                    to: teamPlacementClipper.width;
                    duration: component.animationsDuration * 2; easing.type: Easing.OutQuad }
                NumberAnimation { targets: [place, teamInfoWrapper]; property: "opacity";
                    to:1; duration: component.textAnimationsDuration }
            }
        }
    }

    states: [
        State {
            name: "full"
            PropertyChanges {
                target: labelBackground
                sideAnchor: "bottom"
                height: labelContainer.height
            }

            PropertyChanges { target: labelContent; opacity: 1 }
            PropertyChanges { target: place; opacity: 1 }
            PropertyChanges { target: teamInfoWrapper; opacity: 1 }
            PropertyChanges {
                target: teamPlacementClipper.mask;
                sideAnchor: "left"
                width: teamPlacementClipper.width
            }
        },

        State {
            name: "hidden"
            PropertyChanges { target: labelBackground; sideAnchor: "top"; height: 0 }
            PropertyChanges { target: teamPlacementClipper.mask; sideAnchor: "right";width: 0 }
            PropertyChanges { target: labelContent; opacity: 0 }
            PropertyChanges { target: place; opacity: 0 }
            PropertyChanges { target: teamInfoWrapper; opacity: 0 }
        }
    ]

    transitions: [
        Transition {
            from: "hidden"; to: "full"
            SequentialAnimation {
                ScriptAction { script: internal.currentPage = 0 }
                ParallelAnimation {
                    SequentialAnimation {
                        NumberAnimation { target: labelBackground; property: "height";
                            duration: component.animationsDuration; easing.type: Easing.OutQuad }
                        NumberAnimation { target: labelContent; property: "opacity";
                            duration: component.textAnimationsDuration }
                    }

                    SequentialAnimation {
                        NumberAnimation { duration: component.sideAnimationDelay }
                        NumberAnimation { target: teamPlacementClipper.mask; property: "width";
                            duration: component.animationsDuration; easing.type: Easing.OutQuad }
                        NumberAnimation { targets: [place, teamInfoWrapper]; property: "opacity";
                            duration: component.textAnimationsDuration }
                    }
                }
            }
        },

        Transition {
            from: "full"; to: "hidden"
            ParallelAnimation {
                SequentialAnimation {
                    NumberAnimation { target: labelContent; property: "opacity";
                        duration: component.textAnimationsDuration }
                    NumberAnimation { target: labelBackground; property: "height";
                        duration: component.animationsDuration; easing.type: Easing.OutQuad }
                }

                SequentialAnimation {
                    NumberAnimation { duration: component.sideAnimationDelay }
                    NumberAnimation { targets: [place, teamInfoWrapper]; property: "opacity";
                        duration: component.textAnimationsDuration }
                    NumberAnimation { target: teamPlacementClipper.mask; property: "width";
                        duration: component.animationsDuration; easing.type: Easing.OutQuad }
                }
            }
        }
    ]

    Item {
        id: labelContainer

        width: parent.width
        height: component.height * 0.625

        SideAnchoredRect {
            id: labelBackground

            width: parent.width
            height: parent.height
            color: "#01e35d"
        }

        Item {
            id: labelContent

            height: label.height + category.height + category.anchors.topMargin

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: parent.height * 0.3

            Text {
                id: label

                text: "VYHLÁŠENÍ VÝSLEDKŮ"
                color: "white"
                font.family: "High School USA Sans"
                font.pixelSize: labelContainer.height * 0.26
            }

            Text {
                id: category

                text: "Kategorie " + component.categoryName
                color: "white"
                font.family: "Saira Medium"
                font.pixelSize: labelContainer.height * 0.23

                anchors.top: label.bottom
            }
        }
    }

    Item {
        id: teamPlacementContainer

        visible: false
        height: component.height - labelContainer.height
        width: placeContainer.width + logo.width + teamInfoContainer.anchors.leftMargin
               + logo.width + mockupTeamName.width + logo.anchors.leftMargin * 2

        anchors.top: labelContainer.bottom

        Rectangle {
            id: placeContainer

            color: teamPlacementContainer.placementColor()

            width: height * 1.29
            height: parent.height

            Text {
                id: place

                text: component.places[internal.currentPage] + "."
                color: "black"

                font.family: "Saira Black"
                font.pixelSize: parent.height * 0.348

                anchors.centerIn: parent
            }
        }

        Rectangle {
            id: teamInfoContainer

            height: parent.height
            color: "white"

            anchors.left: placeContainer.right
            anchors.leftMargin: 3
            // TODO dynamic width
            anchors.right: parent.right

            Item {
                id: teamInfoWrapper
                anchors.fill: parent

                Image {
                    id: logo

                    source: (component.slugs[internal.currentPage])
                            ?"../mc-club-logos-2019/2019/" + component.slugs[internal.currentPage] + ".png"
                            :""
                    width: height
                    height: 0.756 * parent.height
                    mipmap: true
                    fillMode: Image.PreserveAspectFit

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: parent.height * 0.3
                }

                Text {
                    text: component.names[internal.currentPage].toUpperCase()
                    color: component.textColors[internal.currentPage]

                    font: mockupTeamName.font

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: mockupTeamName.left
                }

                Text {
                    id: mockupTeamName

                    text: "H".repeat(component.nameMaxLen + 1)
                    font.pixelSize: parent.height * 0.465
                    font.family: "High School USA Sans"
                    visible: false

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: logo.right
                    anchors.leftMargin: parent.height * 0.3
                }
            }
        }

        function placementColor() {
            if(component.places[internal.currentPage] == 1)
                return "#FFDA00"
            else if(component.places[internal.currentPage] == 2)
                return "#c6c6c6"
            else if(component.places[internal.currentPage] == 3)
                return "#ff8500"
            return "white"
        }
    }

    MaskedClipper {
        id: teamPlacementClipper
        source: teamPlacementContainer
        anchors.fill: teamPlacementContainer
    }
}
