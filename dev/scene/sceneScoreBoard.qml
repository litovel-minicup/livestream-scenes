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
        onShowFullScoreBoardReq: {
            matchDataManager.hideFinalScoreReq()
            scoreBoard.state = "full"
        }
        onHideScoreBoardReq: scoreBoard.state = "hidden"
    }

    Item {
        id: offset
        width: scoreBoard.width * 0.3062
        height: scoreBoard.height / 2.
    }

    ScoreBoard {
        id: scoreBoard

        size: parent.height * 0.66
        state: "full"

        anchors.left: offset.right
        anchors.top: offset.bottom
    }

    Timer {
        id: matchTimer
        property var startTime: null

        interval: 1000
        running: false
        triggeredOnStart: false
        onTriggered: {
            scoreBoardSetTime()
        }
    }

    function scoreBoardSetTime() {
        var data = matchDataManager.matchData
        var matchState = data.state
        var halfDuration = data.half_length
        var time = new Date()
        var passedSecs = 0

        if(matchState === "end" || matchState === "init" || matchState === "pause") {
            passedSecs = (matchState === "end") ?halfDuration :0
            //scoreBoard.half = (matchState === "end" || matchState == "pause") ?2 :1
            matchTimer.running = false
        }

        else if(matchState === "half_first" || matchState === "half_second") {
            var start = data[(matchState === "half_first") ?"first_half_start"
                                                           :"second_half_start"]
            passedSecs = Date.now() / 1000 - (start + data.time_diff)
            passedSecs = (passedSecs < 0) ?0 :passedSecs
            passedSecs = (passedSecs > halfDuration) ?halfDuration :passedSecs
            //scoreBoard.half = (matchState === "half_second") ?2 :1
            if(!matchTimer.running)
                matchTimer.running = true

        }

        time.setMinutes(Math.floor(passedSecs / 60))
        time.setSeconds(passedSecs % 60)
        scoreBoard.time = Qt.formatTime(time, "mm:ss")
    }

    function updateData(data) {
        // setting team names
        scoreBoard.teamHome = data.home_team_abbr
        scoreBoard.teamHomeColor = data.home_team_color_text

        scoreBoard.teamAway = data.away_team_abbr
        scoreBoard.teamAwayColor = data.away_team_color_text

        // setting score
        if(data.score[0] !== null && data.score[1] !== null) {
            scoreBoard.teamAwayScore = data.score[1]
            scoreBoard.teamHomeScore = data.score[0]
        }

        else {
            scoreBoard.teamAwayScore = 0
            scoreBoard.teamHomeScore = 0
        }

        // setting time
        scoreBoardSetTime()

    }
}
