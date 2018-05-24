import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    visible: true
    width: 640
    height: 480
    // TODO make from engine

    FontLoader {
        // TODO to relative path
        source: "qrc:/montserrat-light.ttf"
    }

    FontLoader {
        // TODO to relative path
        source: "qrc:/montserrat-regular.ttf"
    }

    Item {
        width: parent.width
        height: parent.height

        ScoreBoard {
            size: 130
        }
    }

    Component.onCompleted: {
        var start = 1527122504
        console.log((Date.now() / 1000 - start))
    }
}
