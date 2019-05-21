import QtQuick 2.9
import QtQuick.Window 2.2

Item {
    id: component

    visible: true
    width: engine.width
    height: engine.height

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

    Connections {
        target: matchDataManager
        onMatchDataChanged: component.updateData(matchDataManager.matchData)
        onShowCategoryTableReq: table.state = "full"
        onNextPageCategoryTableReq: table.state = table.nextPage()
        onHideCategoryTableReq: table.state = "hidden"
    }

    BaseTable {
        id: table

        readonly property int textPixelSize: table.height * 0.125 * 0.384
        readonly property int spacing: table.height * 0.125 * 0.384
        property var datas: [
            { "name": "foo", "slug": "dukla-praha", "wins": 0, "loses": 0, "ties": 0, "score": "",
                "points": 0, "background_color": "white", "text_color": "black" },
            { "name": "", "slug": "dukla-praha", "wins": 0, "loses": 0, "ties": 0, "score": "",
                "points": 0, "background_color": "white", "text_color": "black" },
            { "name": "", "slug": "dukla-praha", "wins": 0, "loses": 0, "ties": 0, "score": "",
                "points": 0, "background_color": "white", "text_color": "black" },
            { "name": "", "slug": "dukla-praha", "wins": 0, "loses": 0, "ties": 0, "score": "",
                "points": 0, "background_color": "white", "text_color": "black" },
            { "name": "", "slug": "dukla-praha", "wins": 0, "loses": 0, "ties": 0, "score": "",
                "points": 0, "background_color": "white", "text_color": "black" },
            { "name": "", "slug": "dukla-praha", "wins": 0, "loses": 0, "ties": 0, "score": "",
                "points": 0, "background_color": "white", "text_color": "black" },
            { "name": "", "slug": "dukla-praha", "wins": 0, "loses": 0, "ties": 0, "score": "",
                "points": 0, "background_color": "white", "text_color": "black" },
            { "name": "", "slug": "dukla-praha", "wins": 0, "loses": 0, "ties": 0, "score": "",
                "points": 0, "background_color": "white", "text_color": "black" },
            { "name": "", "slug": "dukla-praha", "wins": 0, "loses": 0, "ties": 0, "score": "",
                "points": 0, "background_color": "white", "text_color": "black" },
            { "name": "", "slug": "dukla-praha", "wins": 0, "loses": 0, "ties": 0, "score": "",
                "points": 0, "background_color": "white", "text_color": "black" },
            { "name": "", "slug": "dukla-praha", "wins": 0, "loses": 0, "ties": 0, "score": "",
                "points": 0, "background_color": "white", "text_color": "black" },
            { "name": "", "slug": "dukla-praha", "wins": 0, "loses": 0, "ties": 0, "score": "",
                "points": 0, "background_color": "white", "text_color": "black" },
        ]

        titleHeight:  table.height * 0.125
        visibleRowCount: 6
        rowCount: 12
        state: "hidden"

        width: height * 1.8
        height: parent.height

        titleComponent: CategoryTableTitle {
            labels: ["#", "tým", "V", "P", "R", "skóre", "body"]
            textPixelSize: table.textPixelSize
            spacing: table.spacing
            color: "#01e35d"
        }

        rowComponent: CategoryTableRow {
            spacing: table.spacing
            titleTextPixelSize: table.textPixelSize

            teamName: table.datas[rowIndex].name
            teamSlug: table.datas[rowIndex].slug
            teamWins: table.datas[rowIndex].wins
            teamLoses: table.datas[rowIndex].loses
            teamTies: table.datas[rowIndex].ties
            teamScore: table.datas[rowIndex].score
            teamPoints: table.datas[rowIndex].points
            textColor: table.datas[rowIndex].text_color
            color: table.datas[rowIndex].background_color
        }

        Component.onCompleted: {
            if(matchDataManager.hasAllData())
                component.updateData(matchDataManager.matchData)
        }
    }

    function updateData(data) {
        // setting team names
        var teamHomeId = data.home_team_id
        var teamAwayId = data.away_team_id

        for(var i = 0; i < data.category_table.length; i++) {
            var teamData = data.category_table[i]

            if(table.datas[i] === undefined)
                continue
            table.datas[i].name = teamData.name
            table.datas[i].slug = teamData.slug
            table.datas[i].wins = teamData.wins
            table.datas[i].loses = teamData.loses
            table.datas[i].ties = teamData.draws
            table.datas[i].points = teamData.points
            table.datas[i].score = ('0' + teamData.scored).slice(-2) + ":"
                    + ('0' + teamData.received).slice(-2)
            if(teamData.id == teamHomeId || teamData.id == teamAwayId) {
                table.datas[i].text_color = teamData.secondary_color
                table.datas[i].background_color = teamData.primary_color
            }

            else {
                table.datas[i].text_color = teamData.primary_color
                table.datas[i].background_color = "white"

            }
        }

        table.rowCount = data.category_table.length
        table.datasChanged()
    }
}
