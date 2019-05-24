import QtQuick 2.12

BaseTable {
    id: table

    readonly property int textPixelSize: table.height * 0.125 * 0.384
    readonly property int spacing: table.height * 0.125 * 0.384
    property var datas: []
    property int longestFirstName: 0
    property int longestLastName: 0
    property int maxRowCount: 1

    property string teamName: ""
    property string teamSlug: ""
    property color teamPrimaryColor: "white"
    property color teamSecondaryColor: "black"
    property color teamTextColor: "black"

    function getLongestNames() {
        var longestFirstName = ""
        var longestLastName = ""

        for(var i = 0; i < datas.length; i++) {
            var data = table.datas[i]

            if(longestFirstName.length < data.firstname.length)
                longestFirstName = data.firstname
            if(longestLastName.length < data.lastname.length)
                longestLastName = data.lastname
        }

        table.longestFirstName = longestFirstName.length
        table.longestLastName = longestLastName.length
    }

    FontMetrics {
        id: lastNameFm

        font.pixelSize: table.rowHeight * 0.382
        font.family: "High School USA Sans"
    }

    FontMetrics {
        id: firstNameFm

        font.pixelSize: table.rowHeight * 0.208
        font.family: "High School USA Sans"
    }

    function computeWidth() {
        var res = (1.43 * table.rowHeight)
                + firstNameFm.advanceWidth("H".repeat(table.longestFirstName))
                + lastNameFm.advanceWidth("H".repeat(table.longestLastName))
        return res * 2
    }

    rowCount: visibleRowCount
    visibleRowCount: Math.ceil(table.datas.length / 2.)
    titleHeight:  table.height * 0.1398
    state: "hidden"

    width: computeWidth()
    rowHeight: (height - titleHeight) / maxRowCount

    titleComponent: PlayersListTitle {
        slug: table.teamSlug
        color: table.teamPrimaryColor
        teamName: table.teamName
        teamTextColor: table.teamSecondaryColor
    }

    rowComponent: PlayersListRow {
        readonly property var player1Data: table.datas[rowIndex]
        readonly property var player2Data: table.datas[
            rowIndex + Math.ceil(table.datas.length / 2.)]

        longestPlayerFirstName: table.longestFirstName
        longestPlayerLastName: table.longestLastName
        color: "white"

        player1FirstName: (player1Data) ?player1Data.firstname :""
        player1LastName: (player1Data) ?player1Data.lastname :""
        player1Number: (player1Data) ?player1Data.number :-1

        player2FirstName: (player2Data) ?player2Data.firstname :""
        player2LastName: (player2Data) ?player2Data.lastname :""
        player2Number: (player2Data) ?player2Data.number :-1
        teamTextColor: table.teamTextColor

    }

    Component.onCompleted: table.getLongestNames()
}
