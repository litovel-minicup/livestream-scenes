import QtQuick 2.9

Item {
    id: component

    signal showed()
    signal hided()

    property alias teamName: teamNameText.text
    property var players: []
    property color titleBarColor: "#1C70B7"
    property color contentBackgroundColor: "#E7E7E7"
    property color titleBarTextColor: "white"
    property color contentTextColor: "#4E4A49"
    property color bracketsColor: "#F8CF00"

    state: "hidden"

    QtObject {
        id: internal

        readonly property real componentWidth: Math.max(grid.width,
                                                        teamNameText.width + 2 * teamNameText.font.pixelSize)
    }

    states: [
        State {
            name: "hidden"
            PropertyChanges { target: titleBar; width: 0 }
            PropertyChanges { target: content; height: 0 }
        },
        State {
            name: "visible"
            PropertyChanges { target: titleBar; width: internal.componentWidth }
            PropertyChanges { target: content; height: grid.height }
        }
    ]

    transitions: [
        Transition {
            from: "hidden"; to: "visible"
            SequentialAnimation {
                NumberAnimation { target: titleBar; property: "width"; duration: 700
                    easing.type: Easing.InOutQuad }
                NumberAnimation { target: content; property: "height"; duration: 700
                    easing.type: Easing.InOutQuad }
                ScriptAction { script: component.showed() }
            }
        },

        Transition {
            from: "visible"; to: "hidden"
            SequentialAnimation {
                NumberAnimation { target: content; property: "height"; duration: 700
                    easing.type: Easing.InOutQuad }
                NumberAnimation { target: titleBar; property: "width"; duration: 700
                    easing.type: Easing.InOutQuad }
                ScriptAction { script: component.hided() }
            }
        }
    ]

    // TITLE
    Item {
        id: titleBar

        height: parent.height * 0.133
        clip: true
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {
            color: component.titleBarColor
            anchors.fill: parent
        }

        Text {
            id: teamNameText

            color: component.titleBarTextColor
            antialiasing: true

            font.family: "Montserrat"
            font.pixelSize: parent.height * 0.8

            anchors.centerIn: parent
        }
    }

    Item {
        id: content

        clip: true
        width: internal.componentWidth

        anchors.top: titleBar.bottom
        anchors.left: titleBar.left

        Rectangle {
            color: component.contentBackgroundColor
            opacity: 0.9
            anchors.fill: parent
        }

        Grid {
            id: grid

            columns: 2
            columnSpacing: component.height / 3.59
            leftPadding: component.height / 26.9
            rightPadding: leftPadding
            topPadding: component.height / 53.8
            bottomPadding: topPadding
            flow: Grid.TopToBottom

            Repeater {
                model: component.players

                Rectangle {
                    color: "transparent"
                    height: playerName.font.pixelSize * 1.2
                    width: row.width

                    Row {
                        id: row

                        Text { text: "["; font: playerName.font; color: component.bracketsColor; antialiasing: true }
                        MonospacedText {
                            id: playerNumber

                            text: modelData.number.toString()
                            color: playerName.color
                            font: playerName.font
                        }
                        Text { text: "]"; font: playerName.font; color: component.bracketsColor; antialiasing: true }
                        Text {      // Align with monospaced hack
                            text: (modelData.number < 10 ) ?
                                      playerNumber.monospaceEndReference :""
                            font: playerName.font
                            color: component.bracketsColor
                            opacity: 0
                            antialiasing: true
                        }

                        Text {
                            id: playerName

                            text: " " + modelData.name
                            color: component.contentTextColor
                            antialiasing: true

                            font.family: "Montserrat"
                            font.pixelSize: component.height / 12
                        }
                    }
                }
            }
        }
    }
}
