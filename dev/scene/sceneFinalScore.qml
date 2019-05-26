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
        onShowFinalScoreReq: {
            var matchState = matchDataManager.matchData.state
            // TODO uncomment
//            if(matchState !== "end" && matchState !=="pause" && matchState !=="init")
//                return
            matchDataManager.hideScoreBoardReq()
            finalScore.state = "full"
        }
        onHideFinalScoreReq: finalScore.state = "hidden"
    }


    ScoreStrip {
        id: finalScore
        width: parent.width

        state: "hidden"
    }

    function updateData(data) {
        finalScore.teamHome = data.home_team_name;
        finalScore.teamHomeSlug = data.home_team_slug
        finalScore.teamHomeColor = data.home_team_color_secondary
        finalScore.teamHomeBackgroundColor = data.home_team_color_primary

        finalScore.teamAway = data.away_team_name;
        finalScore.teamAwaySlug = data.away_team_slug
        finalScore.teamAwayColor = data.away_team_color_secondary
        finalScore.teamAwayBackgroundColor = data.away_team_color_primary

        if(data.score[0] !== null) {
            finalScore.teamHomeScore = data.score[0];
            finalScore.teamAwayScore = data.score[1];
        }

        else {
            finalScore.teamHomeScore = 0;
            finalScore.teamAwayScore = 0;
        }

        var matchStates = {
            "end": "KONEC",
            "pause": "POLOČAS",
            "init": "ZAČÁTEK"
        }

        if(data.state in matchStates)
            finalScore.matchState = matchStates[data.state];
        else
            finalScore.matchState = "";
    }
}
