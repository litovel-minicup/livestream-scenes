import QtQuick 2.0

Item {
    id: component
    state: "hidden"

    signal show()

    Rectangle {
        id: bar
        color: "red"
        width: 0
        height: 25
    }

    Rectangle {
        id: content
        color: "blue"
        width: parent.width
//        height: component.height - bar.height
        height: 0

        anchors.top: bar.bottom
    }

    onShow: SequentialAnimation {
        NumberAnimation {
            target: bar
            property: "width"
            to: component.width
            duration: 500
            easing.type: Easing.InOutQuad
        }

        NumberAnimation {
            target: content
            property: "height"
            to: component.height - bar.height
            duration: 500
            easing.type: Easing.InOutQuad
        }
    }
}
