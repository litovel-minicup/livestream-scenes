import QtQuick 2.0
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
        source: "montserrat-regular.ttf"
    }

    Connections {
        target: matchDataManager
        onMatchDataChanged: component.updateData(matchDataManager.matchData)
    }

    Rectangle {
        anchors.fill: parent
        color: "white"
    }

    Image {
        id: logo

        readonly property real scale: 0.5
        readonly property size originalSize: Qt.size(957, 720)

        z: 1
        source: "logo.svg"

        width: originalSize.width * scale
        height: originalSize.height * scale
        anchors.centerIn: parent

        fillMode: Image.PreserveAspectFit

        sourceSize: Qt.size(
                        originalSize.width * scale,
                        originalSize.height * scale)
    }

    Item {
        id: loadingAnmation

        z:66
        y: 570
        height: leftRect.height
        anchors.horizontalCenter: parent.horizontalCenter

        Behavior on opacity {
            NumberAnimation { duration: 400 }
        }

        Rectangle {
            id: leftRect

            width: 20
            radius: width
            height: width
            color: "lightGray"

            anchors.left: parent.left
        }

        Rectangle {
            id: rightRect

            width: leftRect.width
            radius: width
            height: width
            color: "lightGray"

            anchors.right: parent.right
        }


        SequentialAnimation {
           running: true
           loops: Animation.Infinite

           NumberAnimation {
                target: leftRect
                property: "anchors.leftMargin"
                to: 100
                duration: 400
                easing.type: Easing.OutQuad
           }

           NumberAnimation {
                target: leftRect
                property: "anchors.leftMargin"
                to: 0
                duration: 400
                easing.type: Easing.InQuad
           }

           NumberAnimation {
                target: rightRect
                property: "anchors.rightMargin"
                to: 100
                duration: 400
                easing.type: Easing.OutQuad
           }

           NumberAnimation {
                target: rightRect
                property: "anchors.rightMargin"
                to: 0
                duration: 400
                easing.type: Easing.InQuad
           }
        }
    }

    Rectangle {
        id: splitter

        width: 8
        height: 55
        color: "#1D70B7"

        anchors.top: loadingAnmation.bottom
        anchors.topMargin: 25
        anchors.horizontalCenter: loadingAnmation.horizontalCenter
    }

    Text {
        id: homeTeam

        text: "Tatran Litovel"
        color: "#5B5B5B"

        font.family: "Montserrat"
        font.pixelSize: 45

        anchors.right: splitter.left
        anchors.rightMargin: 13
        anchors.verticalCenter: splitter.verticalCenter
    }

    Text {
        id: awayTeam

        text: "Dukla Praha"
        color: "#5B5B5B"

        font.family: "Montserrat"
        font.pixelSize: 45

        anchors.left: splitter.right
        anchors.leftMargin: 13
        anchors.verticalCenter: splitter.verticalCenter
    }

    function updateData(data) {
        // setting team names
        homeTeam.text = data.home_team_name
        awayTeam.text = data.away_team_name

    }
}
