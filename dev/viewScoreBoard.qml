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
        onShowCompactScoreBoardReq: scoreBoard.state = "compact"
        onShowFullScoreBoardReq: scoreBoard.state = "full"
        onHideScoreBoardReq: scoreBoard.state = "hidden"
    }

    Item {
        id: offset
        width: height
        height: parent.height * 0.25
    }

    ScoreBoard {
        id: scoreBoard

        size: parent.height * 0.75
        state: "compact"

        anchors.left: offset.right
        anchors.top: offset.bottom
    }

    Component.onCompleted: {
        if(matchDataManager.hasAllData())
            component.updateData(matchDataManager.matchData)
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
            passedSecs = halfDuration
            scoreBoard.half = (matchState === "end") ?2 :1
            matchTimer.running = false
        }

        else if(matchState === "half_first" || matchState === "half_second") {
            var start = data[(matchState === "half_first") ?"first_half_start"
                                                           :"second_half_start"]
            passedSecs = Date.now() / 1000 - start
            passedSecs = (passedSecs < 0) ?0 :passedSecs
            scoreBoard.half = (matchState === "half_second") ?2 :1
            if(!matchTimer.running)
                matchTimer.running = true

        }

        time.setMinutes(Math.floor(passedSecs / 60))
        time.setSeconds(passedSecs % 60)
        scoreBoard.time = Qt.formatTime(time, "m:ss")

    }

    function updateData(data) {
        // setting team names
        scoreBoard.teamHome = data.home_team_abbr
        scoreBoard.teamAway = data.away_team_abbr

        // setting score
        if(data.score[0] !== null && data.score[1] !== null) {
            scoreBoard.state = "full"
            scoreBoard.teamAwayScore = data.score[1]
            scoreBoard.teamHomeScore = data.score[0]
        }

        else
            scoreBoard.state = "compact"

        // setting time
        scoreBoardSetTime()

    }
}
