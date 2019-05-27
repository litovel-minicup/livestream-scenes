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
        onShowTeamTilesReq: teamTiles.state = "full"
        onHideTeamTilesReq: teamTiles.state = "hidden"
    }

    TeamTiles {
        id: teamTiles

        state: "hidden"
//        sideAnimationDelay: 0
        anchors.fill: parent
    }

    function updateData(data) {
        // setting team names
        teamTiles.teamHome = data.home_team_abbr.toUpperCase()
        teamTiles.teamHomeColor = data.home_team_color_primary
        teamTiles.teamHomeTextColor = data.home_team_color_secondary
        teamTiles.teamHomeSlug = data.home_team_slug

        teamTiles.teamAway = data.away_team_abbr.toUpperCase()
        teamTiles.teamAwayColor = data.away_team_color_primary
        teamTiles.teamAwayTextColor = data.away_team_color_secondary
        teamTiles.teamAwaySlug = data.away_team_slug
    }
}
