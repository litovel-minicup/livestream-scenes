import QtQuick 2.0

Rectangle {
    property string sideAnchor: ""

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
