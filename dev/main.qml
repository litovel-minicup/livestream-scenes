import QtQuick 2.12
import QtQuick.Window 2.2
import QtQuick.Layouts 1.12


Window {
    visible: true
    width: 1280
    height: 800
    title: qsTr("Hello World")


        Rectangle {
        anchors.fill: parent
        color: "gray"
    }

    FontLoader {
        // High School USA Sans
        source: "font/mc_font.otf"
    }

    FontLoader {
        // Saira Black
        source: "font/Saira-Black.ttf"
    }

    FontLoader {
        // Saira
        source: "font/Saira-Regular.ttf"
    }


//    ShooterView {
//        id: shooterView
//        width: 600
//        height: 100
//        state: "full"
//    }

//    TeamTiles {
//        id: socialMedias
//        anchors.fill: parent

//    }

//    SocialMedias {
//        id: socialMedias

//        width: parent.width
//        height: width / 28.5

//        y: 200
//    }


    PlayersList {
        id: table

        x: 20
        y: 20
        height: 600
        maxRowCount: 7
//        rowCount: visibleRowCount
//        visibleRowCount: Math.ceil(table.datas.length / 2.)

        teamSlug: "dukla-praha"
        teamPrimaryColor: "#69121b"
        teamTextColor: "#69121b"
        teamName: "Dukla praha"
        teamSecondaryColor: "#faf327"

        datas: [
            { "firstname": "Jan", "lastname": "HHHHHHHHHHH", "number": 1},
            { "firstname": "Jan", "lastname": "HHHHHHHHHHH", "number": 12},
            { "firstname": "Jan", "lastname": "HHHHHHHHHHH", "number": 3},
            { "firstname": "Jan", "lastname": "HHHHHHHHHHH", "number": 4},
            { "firstname": "Jafgn", "lastname": "HHHHHHHHHHH", "number": 44},
            { "firstname": "Jan", "lastname": "HHHHHHHHHHH", "number": 6},
            { "firstname": "Jan", "lastname": "HHHHHHHHHHH", "number": 7},
        ]
        onHided: console.log("fdf")
    }


    Shortcut {
        sequence: "A"
        onActivated: table.state = "full"
    }

    Shortcut {
        sequence: "S"
//        onActivated: table.nextPage()
    }

    Shortcut {
        sequence: "D"
        onActivated: table.state = "hidden"
    }
}
