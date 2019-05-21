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
        onShowShooterReq: {
            if(matchDataManager.matchData.last_shooter.team_name !== null &&
                    matchDataManager.matchData.last_shooter.team_name !== undefined)
                shooterView.state = "full"
            timer.start()
        }
        onHideShooterReq: shooterView.state = "hidden"
    }

    ShooterView {
        id: shooterView
        anchors.fill: parent
    }

    Timer {
        id: timer

        running: false
        interval: 5000
        triggeredOnStart: false
        onTriggered: {
            timer.stop()
            shooterView.state = "hidden"
        }
    }

    function updateData(data) {
        if(data.last_shooter.team_name !== null &&
                data.last_shooter.team_name !== undefined) {
            if(data.last_shooter.player_number !== null &&
                    data.last_shooter.player_number !== undefined) {
                shooterView.playerNumber = data.last_shooter.player_number
                shooterView.playerName = data.last_shooter.player_name
                shooterView.teamName = data.last_shooter.team_name
            }

            else {
                shooterView.teamName = data.last_shooter.team_name
                shooterView.playerNumber = " "
                shooterView.playerName = ""
            }

        }
    }
}
