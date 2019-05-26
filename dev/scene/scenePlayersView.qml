import QtQuick 2.9
import QtQuick.Window 2.2
import "../component"


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
        onMatchDataChanged: component.updateData(matchDataManager.matchData)
        onShowPlayersReq: {
            if(homePlayersView.state == "hidden" && awayPlayersView.state == "hidden")
                homePlayersView.state = "full"
            else if(homePlayersView.state == "full" && awayPlayersView.state == "hidden")
                homePlayersView.state = "hidden"
        }

        onHidePlayersReq: {
            homePlayersView.state = "hidden"
            awayPlayersView.state = "hidden"
        }
    }

    PlayersList {
        id: homePlayersView

        height: parent.height
        maxRowCount: 7
        state: "hidden"
        anchors.horizontalCenter: parent.horizontalCenter

        onHided: awayPlayersView.state = "full"
    }

    PlayersList {
        id: awayPlayersView

        height: parent.height
        maxRowCount: 7
        state: "hidden"
        anchors.horizontalCenter: parent.horizontalCenter
    }

    function updateData(data) {
        homePlayersView.teamName = data.home_team_name
        homePlayersView.teamPrimaryColor = data.home_team_color_primary
        homePlayersView.teamSecondaryColor = data.home_team_color_secondary
        homePlayersView.teamTextColor = data.home_team_color_text
        homePlayersView.teamSlug = data.home_team_slug
        homePlayersView.datas = data.players.home.players
        homePlayersView.getLongestNames()

        awayPlayersView.teamName = data.away_team_name
        awayPlayersView.teamPrimaryColor = data.away_team_color_primary
        awayPlayersView.teamSecondaryColor = data.away_team_color_secondary
        awayPlayersView.teamTextColor = data.away_team_color_text
        awayPlayersView.teamSlug = data.away_team_slug
        awayPlayersView.datas = data.players.away.players
        awayPlayersView.getLongestNames()
    }
}
