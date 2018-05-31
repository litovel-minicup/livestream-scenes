import QtQuick 2.9
import QtQuick.Window 2.2

Item {
    id: component

    visible: true
    width: engine.width
    height: engine.height

    Component.onCompleted: {
        if(matchDataManager.hasAllData())
            component.updateData(matchDataManager.matchData)
    }

    FontLoader {
        source: "montserrat-light.ttf"
    }

    FontLoader {
        source: "montserrat-regular.ttf"
    }

    Connections {
        target: matchDataManager
        onMatchDataChanged: component.updateData(matchDataManager.matchData)
        onShowPlayersReq: {
            if(homePlayersView.state == "hidden" && awayPlayersView.state == "hidden")
                homePlayersView.state = "visible"
            else if(homePlayersView.state == "visible" && awayPlayersView.state == "hidden")
                homePlayersView.state = "hidden"
        }

        onHidePlayersReq: {
            homePlayersView.state = "hidden"
            awayPlayersView.state = "hidden"
        }
    }

    PlayersView {
        id: homePlayersView

        state: "hidden"
        anchors.fill: parent

        onHided: awayPlayersView.state = "visible"
    }

    PlayersView {
        id: awayPlayersView

        state: "hidden"
        anchors.fill: parent
    }

    function updateData(data) {
        homePlayersView.teamName = data.home_team_name
        homePlayersView.players = data.players.home.players

        awayPlayersView.teamName = data.away_team_name
        awayPlayersView.players = data.players.away.players
    }
}
