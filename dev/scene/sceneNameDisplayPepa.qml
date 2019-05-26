import QtQuick 2.9
import QtQuick.Window 2.2
import "../component"


Item {
    id: component

    visible: true
    width: engine.width
    height: engine.height

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
        onShowNameDisplayReq: nameView.state = "full"
        onHideNameDisplayReq: nameView.state = "hidden"
    }

    ShooterView {
        id: nameView

        playerName: "Josef Kolář"
        primaryColor: "#04339b"
        secondaryColor: "#01e35d"
        textColor: "#04339b"
        teamName: "Komentátor"
        slug: "litovel-minicup"

        anchors.fill: parent

        Component.onCompleted: nameView.updateMaxWidth()
    }
}
