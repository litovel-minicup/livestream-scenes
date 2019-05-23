import QtQuick 2.12

Item {
    id: component

    property alias logoPath: logo.source
    property alias logoBackgroundColor: logoBackground.color
    property alias textBackgroundColor: textBackground.color
    property alias textColor: text.color
    property int padding: 20
    property alias font: text.font
    property alias text: text.text
    property int animationsDuration: 250
    property int animationsDelay: 0
    property int sideAnimationsDelay: 120
    property int textAnimationsDuration: 120 * 1

    state: "hidden"
    width: logoContainer.width + textContainer.width

    states: [
        State {
            name: "hidden"
            PropertyChanges { target: logo; opacity: 0 }
            PropertyChanges { target: text; opacity: 0 }
            PropertyChanges {
                target: logoBackground
                sideAnchor: "top"
                height: 0
            }

            PropertyChanges {
                target: textBackground
                sideAnchor: "right"
                width: 0
            }
        },

        State {
            name: "full"
            PropertyChanges { target: logo; opacity: 1 }
            PropertyChanges { target: text; opacity: 1 }
            PropertyChanges {
                target: logoBackground
                sideAnchor: "bottom"
                height: logoContainer.height
            }

            PropertyChanges {
                target: textBackground
                sideAnchor: "left"
                width: textContainer.width
            }
        }
    ]

    transitions: [
        Transition {
            from: "full"; to: "hidden"
            ParallelAnimation {
                SequentialAnimation {
                    NumberAnimation { duration: component.animationsDelay }
                    NumberAnimation { target: logo; property: "opacity";
                        duration: component.textAnimationsDuration }
                    NumberAnimation { target: logoBackground; property: "height";
                        duration: component.animationsDuration; easing.type: Easing.OutCubic }
                }

                SequentialAnimation {
                    NumberAnimation { duration: component.animationsDelay
                                                + component.sideAnimationsDelay }
                    NumberAnimation { target: text; property: "opacity";
                        duration: component.textAnimationsDuration }
                    NumberAnimation { target: textBackground; property: "width";
                        duration: component.animationsDuration; easing.type: Easing.OutCubic }
                }
            }
        },

        Transition {
            from: "hidden"; to: "full"
            ParallelAnimation {
                SequentialAnimation {
                    NumberAnimation { duration: component.animationsDelay }
                    NumberAnimation { target: logoBackground; property: "height";
                        duration: component.animationsDuration; easing.type: Easing.OutCubic }
                    NumberAnimation { target: logo; property: "opacity";
                        duration: component.textAnimationsDuration }
                }

                SequentialAnimation {
                    NumberAnimation { duration: component.animationsDelay
                                                + component.sideAnimationsDelay }
                    NumberAnimation { target: textBackground; property: "width";
                        duration: component.animationsDuration; easing.type: Easing.OutCubic }
                    NumberAnimation { target: text; property: "opacity";
                        duration: component.textAnimationsDuration }
                }
            }
        }
    ]

    Item {
        id: logoContainer

        width: height
        height: parent.height

        SideAnchoredRect {
            id: logoBackground

            width: parent.width
            height: parent.height

            Image {
                id: logo

                width: height
                height: parent.height * 0.6
                mipmap: true

                anchors.centerIn: parent
            }
        }
    }

    Item {
        id: textContainer

        width: text.width + 2 * component.padding
        height: parent.height
        anchors.left: logoContainer.right

        SideAnchoredRect {
            id: textBackground

            width: parent.width
            height: parent.height

            Text {
                id: text

                font.pixelSize: parent.height * 0.55
                anchors.centerIn: parent
            }
        }
    }
}
