import QtQuick 2.9
import QtQuick.Window 2.2

Item {
    id: component

    visible: true
    width: engine.width
    height: engine.height

    FontLoader {
        source: "montserrat-light.ttf"
    }

    FontLoader {
        source: "montserrat-regular.ttf"
    }

    Connections {
        target: matchDataManager
        onMatchDataChanged: component.updateData(matchDataManager.matchData)
    }

    ScoreBoard {
        id: scoreBoard

        height: parent.height * 0.75
        state: "full"       // TODO change

        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }

    Component.onCompleted: {
        if(matchDataManager.hasAllData())
            component.updateData(matchDataManager.matchData)
    }

    function updateData(data) {
//        var start = 1527122504
//        console.log((Date.now() / 1000 - start))
        console.log(data.away_team_abbr)
    }
}
