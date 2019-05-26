import QtQuick 2.12
import QtGraphicalEffects 1.12

Item {
    property alias text: styledText.text
    property alias background: styledText.background
    property alias style: styledText.style
    property alias mask: clipper.mask

    StyledText {
        id: styledText

        visible: false

        text.wrapMode: Text.WordWrap
        text.horizontalAlignment: Text.AlignHCenter
        text.verticalAlignment: Text.AlignVCenter

        anchors.fill: parent
    }

    MaskedClipper {
        id: clipper

        source: styledText
        anchors.fill: styledText
    }
}
