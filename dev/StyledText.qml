import QtQuick 2.0

Item {
    id: component

    property StyledTextStyle style
    property alias text: internalText
    property alias background: internalBackground

    Rectangle {
        id: internalBackground
        anchors.fill: parent
    }

    Text {
        id: internalText
        anchors.fill: parent
    }

    onStyleChanged: {
        if(!component.style)
            return

        internalText.color = Qt.binding(function() { return component.style.textColor })
        internalText.font.family = Qt.binding(function() { return component.style.font.family })
        internalBackground.color = Qt.binding(function() { return component.style.color })
        internalBackground.opacity = Qt.binding(function() {
            return component.style.backgroundOpacity })
    }
}
