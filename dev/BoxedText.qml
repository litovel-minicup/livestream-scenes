import QtQuick 2.4

Rectangle {
    id: component

    property alias text: text
    property real hPadding: 5
    property real vPadding: 5
    property alias size: component.height
    property BoxedTextStyle style

    QtObject {
        id: internal

        function stretchComponentWithText() {
            fm.font = component.text.font
            component.width = 2 * component.hPadding + fm.advanceWidth(text.text)
        }
    }

    FontMetrics {
        id: fm
    }

    Text {
        id: text

        font.pixelSize: component.height - 2 * component.vPadding
        anchors.centerIn: parent

        onTextChanged: internal.stretchComponentWithText()
        onFontChanged: internal.stretchComponentWithText()
    }

    Component.onCompleted: internal.stretchComponentWithText()
    onHPaddingChanged: internal.stretchComponentWithText()
    onStyleChanged: {
        if(!component.style)
            return

        component.vPadding = Qt.binding(function() { return component.style.vPadding })
        component.hPadding = Qt.binding(function() { return component.style.hPadding })
        component.text.font.family = Qt.binding(function() { return component.style.font.family })
        component.text.color = Qt.binding(function() { return component.style.textColor })
        component.color = Qt.binding(function() { return component.style.color })
        internal.stretchComponentWithText()
    }
}
