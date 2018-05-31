import QtQuick 2.4

Item {
    id: component

    property alias text: text
    property real hPadding: 5
    property real vPadding: 5
    property alias size: component.height
    property bool monospaceHack: false
    property BoxedTextStyle style
    property alias color: background.color
    property alias backgroundOpacity: background.opacity
    property real alignWidth: 0
    readonly property Item textParent: component

    QtObject {
        id: internal

        function stretchComponentWithText() {
            var patt = /([0-8])/
            var str = text.text
            if(monospaceHack) {
                while(str.match(patt))
                    str = str.replace(patt, "9" + "$2")
            }

            fm.font = component.text.font
            component.width = Math.max(2 * component.hPadding + fm.advanceWidth(str),
                                       component.alignWidth)
        }
    }

    Rectangle {
        id: background
        anchors.fill: parent
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
    onAlignWidthChanged: internal.stretchComponentWithText()
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
