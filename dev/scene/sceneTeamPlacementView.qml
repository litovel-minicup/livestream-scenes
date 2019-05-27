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

    FontLoader {
        // Saira Medium
        source: "../font/Saira-Medium.ttf"
    }

    Connections {
        target: matchDataManager
        onMatchDataChanged: component.updateData(matchDataManager.matchData)
        onShowTeamPlacementReq: teamPlacement.state = "full"
        onHideTeamPlacementReq: teamPlacement.state = "hidden"
        onNextPageTeamPlacementReq: teamPlacement.nextPage()
    }


    TeamPlacementView {
        id: teamPlacement
        height: parent.height

        state: "hidden"
    }

    function updateData(data) {
        var names = []
        var slugs = []
        var places = []
        var textColors = []

        for(var i = 0; i < data.category_table.length; i++) {
            var teamData = data.category_table[i]

            names.unshift(teamData.name)
            slugs.unshift(teamData.slug)
            textColors.unshift(teamData.color_text)
            places.unshift(i + 1)
        }

        teamPlacement.categoryName = (data.category_id == 13) ?"mladší" :"starší"
        teamPlacement.names = names
        teamPlacement.slugs = slugs
        teamPlacement.places = places
        teamPlacement.textColors = textColors
    }
}
