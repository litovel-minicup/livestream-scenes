import QtQuick 2.0
import QtGraphicalEffects 1.12

Item {
    property alias mask: mask
    property alias source: opacityMask.source

    Item {
        id: maskWrapper
        anchors.fill: parent

        SideAnchoredRect {
            id: mask

            width: parent.width
            height: parent.height
            color: "red"
        }
    }

    OpacityMask {
        id: opacityMask

        maskSource: maskWrapper
        cached: false

        anchors.fill: parent
    }
}
