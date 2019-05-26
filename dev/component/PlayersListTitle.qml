import QtQuick 2.12
import QtQuick.Layouts 1.12


Item {
    id: component

    property alias color: background.color
    property alias teamName: teamName.text
    property alias teamTextColor: teamName.color
    property int animationsDuration: 250
    property int animationsDelay: 0
    property int textAnimationsDuration: 120 * 1
    property string slug: ""

    state: "hidden"
    states: [
        State {
            name: "full"
            PropertyChanges {
                target: background
                sideAnchor: "bottom"
                height: component.height
            }
            PropertyChanges { target: rowContent; opacity: 1 }
        },

        State {
            name: "hidden"
            PropertyChanges { target: background; sideAnchor: "top"; height: 0 }
            PropertyChanges { target: rowContent; opacity: 0 }
        }
    ]

    transitions: [
        Transition {
            from: "full"; to: "hidden"
            SequentialAnimation {
                NumberAnimation { duration: component.animationsDelay }
                NumberAnimation { target: rowContent; property: "opacity";
                    duration: component.textAnimationsDuration }
                NumberAnimation { target: background; property: "height";
                    duration: component.animationsDuration; easing.type: Easing.OutCubic }
            }
        },

        Transition {
            from: "hidden"; to: "full"
            SequentialAnimation {
                NumberAnimation { duration: component.animationsDelay }
                NumberAnimation { target: background; property: "height";
                    duration: component.animationsDuration; easing.type: Easing.OutCubic }
                NumberAnimation { target: rowContent; property: "opacity";
                    duration: component.textAnimationsDuration }
            }
        }

    ]

    SideAnchoredRect {
        id: background
        width: parent.width
        height: parent.height
    }

    Item {
        id: rowContent

        width: parent.width
        height: parent.height

        Row {
            height: parent.height
            spacing: height / 3
            anchors.centerIn: parent

            Image {
                width: height
                height: parent.height * 0.75
                source: (component.slug)
                        ?"../mc-club-logos-2019/2019/" + component.slug + ".png" :""
                mipmap: true
                fillMode: Image.PreserveAspectFit

                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                id: teamName

                font.family: "High School USA Sans"
                font.pixelSize: parent.height * 0.4

                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
