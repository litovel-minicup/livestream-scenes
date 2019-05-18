import QtQuick 2.12
import QtGraphicalEffects 1.12

Item {
    property alias text: styledText.text
    property alias background: styledText.background
    property alias style: styledText.style
    property alias mask: mask
    property alias maskWrapper: maskWrapper

    StyledText {
        id: styledText

        visible: false

        text.wrapMode: Text.WordWrap
        text.horizontalAlignment: Text.AlignHCenter
        text.verticalAlignment: Text.AlignVCenter

        anchors.fill: parent
    }

    Item {
        id: maskWrapper
        anchors.fill: parent

        Rectangle {
            id: mask

            property string sideAnchor: ""

            width: parent.width
            height: parent.height
            color: "red"

            onSideAnchorChanged: {
                // need to null first
                anchors.left = undefined
                anchors.right = undefined
                anchors.top = undefined
                anchors.bottom = undefined

                if(sideAnchor == "left")
                    anchors.left = parent.left
                else if(sideAnchor == "right")
                    anchors.right = parent.right
                else if(sideAnchor == "top")
                    anchors.top = parent.top
                else if(sideAnchor == "bottom")
                    anchors.bottom = parent.bottom
            }
        }
    }

    OpacityMask {
        source: styledText
        maskSource: maskWrapper

        cached: false

        anchors.fill: styledText
    }
}
