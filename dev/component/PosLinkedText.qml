import QtQuick 2.12


Item {
    id: component

    property alias fm: fm
    property string text: ""
    property alias textComponent: text
    property alias font: text.font
    property alias linkedTextFont: fm.font
    property string linkedText: ""

    width: fm.advanceWidth(component.linkedText)

    FontMetrics {
        id: fm
    }

    Text {
        id: text

        text: component.text
        anchors.verticalCenter: parent.verticalCenter
    }
}
