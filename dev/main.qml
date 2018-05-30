import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    id: component

    visible: true
    width: 1600
    height: 700

    PlayersView {
        id: playerView
        state: "hidden"
//        x: 100
//        y: 100
        width: parent.width / 1
        height: parent.height /1

        teamName: "LITOVEL"
        players: [
            {"name": "Sony Bobman", "number": 1},
            {"name": "Sony BobFman", "number": 11},
            {"name": "Sony Foo", "number": 3},
            {"name": "Sony man", "number": 14},
            {"name": "Sony Bobman", "number": 5},
            {"name": "Sony kamaaaa", "number": 6},
            {"name": "Sony Bobman", "number": 7}
        ]
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if(playerView.state == "hidden")
                playerView.state = "visible"
            else
                playerView.state = "hidden"
        }
    }


}
