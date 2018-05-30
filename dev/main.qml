import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    id: component

    visible: true
    width: 800
    height: 300

    PlayersView {
        id: playerView

        width: parent.width / 1.3
        height: parent.height /1.3
    }

    MouseArea {
        anchors.fill: parent
        onClicked: playerView.show()
    }


}
