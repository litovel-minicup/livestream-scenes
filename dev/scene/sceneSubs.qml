import QtQuick 2.9
import QtQuick.Window 2.2
import "../component"


Item {
    id: component

    visible: true
    width: engine.width
    height: engine.height

    FontLoader {
        // High School USA Sans
        source: "../font/mc_font.otf"
    }


    FontLoader {
        // Saira Black
        source: "../font/Saira-Black.ttf"
    }


    FontLoader {
        // Saira
        source: "../font/Saira-Regular.ttf"
    }

    Connections {
        target: matchDataManager

        onShowSubsReq: subs.state = "full"
        onHideSubsReq: subs.state = "hidden"
    }

    //    786 x 1080
    Item {
        id: subs

        width: height  * (786. / 1080.)
        height: parent.height
        state: "hidden"

        states: [
            State {
                name: "full"
                PropertyChanges {
                    target: subsClipper.mask; width: subs.width; sideAnchor: "right"
                }
                PropertyChanges { target: subsText; opacity: 1 }
            },

            State {
                name: "hidden"
                PropertyChanges { target: subsClipper.mask; width: 0; sideAnchor: "left" }
                PropertyChanges { target: subsText; opacity: 0 }
            }
        ]

        transitions: [
            Transition {
                from: "full"; to: "hidden"
                SequentialAnimation {
                    NumberAnimation { target: subsText; property: "opacity";
                        duration: 120 }
                    NumberAnimation { target: subsClipper.mask; property: "width";
                        duration: 450; easing.type: Easing.OutQuad }
                }
            },

            Transition {
                from: "hidden"; to: "full"
                SequentialAnimation {
                    NumberAnimation { target: subsClipper.mask; property: "width";
                        duration: 450; easing.type: Easing.OutQuad }
                    NumberAnimation { target: subsText; property: "opacity";
                        duration: 120 }
                }
            }
        ]

        Image {
            id: subsBg
            source: "../res/subs_bg.png"
            visible: false
            anchors.fill: parent
        }

        MaskedClipper {
            id: subsClipper

            mask.sideAnchor: "right"
            anchors.fill: parent
            source: subsBg
        }


        Image {
            id: subsText
            source: "../res/subs_text.png"
//            anchors.fill: parent
            width: 786
            height: 1080
        }
    }
}
