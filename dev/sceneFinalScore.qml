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
        onShowFinalScoreReq: {
            var matchState = matchDataManager.matchData.state
            if(matchState !== "end" && matchState !=="pause")
                return
            finalScore.state = "visible"
        }
        onHideFinalScoreReq: finalScore.state = "hidden"
    }

    FinalScore {
        id: finalScore

        state: "hidden"
        width: height * 5
        height: parent.height

        anchors.centerIn: parent
    }

    function updateData(data) {
        finalScore.homeTeamName = data.home_team_name;
        finalScore.awayTeamName = data.away_team_name;
        if(data.score !== null) {
            finalScore.homeTeamScore = data.score[0];
            finalScore.awayTeamScore = data.score[1];
        }

        else {
            finalScore.homeTeamScore = 0;
            finalScore.awayTeamScore = 0;
        }

        var matchStates = {
            "end": "KONEC ZÁPASU",
            "pause": "POLOČAS"
        }

        if(data.state in matchStates)
            finalScore.matchState = matchStates[data.state];
    }
}
