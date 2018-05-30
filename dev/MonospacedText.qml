import QtQuick 2.0

Item {
    id: component

    property font font
    property alias color: content.color
    property alias text: content.text

    width: monospaced.width
    height: monospaced.height

    // Monospace hack
    Text {
        id: monospaced

        text: repeat("9", component.text.length)
        opacity: 0
        font: component.font

        function repeat(str, count) {
            var res = ""
            for(var i = 0; i < count; i++)
                res += (i == 0) ?str :"1"
            return res
        }
    }

    Text {
        id: content

        x: (parent.width - width) / 2 + font.pixelSize / 10
        font: component.font
        anchors.verticalCenter: parent.verticalCenter
    }
}
