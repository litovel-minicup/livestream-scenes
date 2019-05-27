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
        onShowShooterReq: {
            if(matchDataManager.matchData.last_shooter.team_name !== null &&
                    matchDataManager.matchData.last_shooter.team_name !== undefined) {
                shooterView.state = "full"
                timer.start()
            }
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
        interval: 3000
        triggeredOnStart: false
        onTriggered: {
            timer.stop()
            shooterView.state = "hidden"
        }
    }

    function updateData(data) {
        if(data.last_shooter.team_name !== null &&
                data.last_shooter.team_name !== undefined) {
            if(data.last_shooter.player_name !== null &&
                    data.last_shooter.player_name !== undefined) {
                shooterView.playerName = data.last_shooter.player_name
            }

            else
                shooterView.playerName = ""

            shooterView.primaryColor = data.last_shooter.team_color_primary
            shooterView.secondaryColor = data.last_shooter.team_color_secondary
            shooterView.textColor = data.last_shooter.team_color_text
            shooterView.teamName = data.last_shooter.team_name
            shooterView.slug = data.last_shooter.team_slug

            shooterView.updateMaxWidth()

        }
    }
}
