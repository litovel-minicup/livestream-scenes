import QtQuick 2.0

Item {
    id: component

    state: "hidden"

    QtObject {
        id: internal

        readonly property var datas: [
            {
                "logoPath": "res/ig-logo.png",
                "logoBackgroundColor": "#af2765",
                "textBackgroundColor": "#e02c76"
            },

            {
                "logoPath": "res/fb-logo.png",
                "logoBackgroundColor": "#2b4066",
                "textBackgroundColor": "#3e5a99"
            },

            {
                "logoPath": "res/yt-logo.png",
                "logoBackgroundColor": "#ce0505",
                "textBackgroundColor": "#ff0000"
            }
        ]
    }

    states: [
        State { name: "hidden" },
        State { name: "full" }
    ]

    Row {
        height: parent.height
        spacing: component.width / 16

        anchors.horizontalCenter: parent.horizontalCenter

        Repeater {
            model: 3

            SocialMediaItem {
                state: component.state
                height: parent.height
                logoPath: internal.datas[index].logoPath
                logoBackgroundColor: internal.datas[index].logoBackgroundColor
                padding: height * 0.4
                animationsDelay: index * 200

                text: "LITOVEL.MINICUP"
                textColor: "white"
                textBackgroundColor: internal.datas[index].textBackgroundColor
                font.family: "High School USA Sans"
            }
        }
    }
}
