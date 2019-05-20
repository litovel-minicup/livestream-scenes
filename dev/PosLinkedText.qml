import QtQuick 2.12


Rectangle {
    id: component

    color: "transparent"
    property alias fm: fm
    property alias text: text
    property alias font: text.font
    property alias linkedTextFont: fm.font
    property string linkedText: ""

    width: fm.advanceWidth(component.linkedText)

    FontMetrics {
        id: fm
    }

    Text {
        id: text

        anchors.verticalCenter: parent.verticalCenter
    }
}
