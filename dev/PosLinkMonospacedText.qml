import QtQuick 2.12


Item {
    id: component

    property alias fm: fm
    property string text: ""
    property color textColor
    property font font
    property alias linkedTextFont: fm.font
    property string linkedText: ""

    width: fm.advanceWidth(component.linkedText)

    FontMetrics {
        id: fm
    }

    Item {
        width: fm.advanceWidth("#".repeat(component.text.length))
        anchors.right: component.right
        anchors.verticalCenter: parent.verticalCenter

        Row {
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter

            Repeater {
                model: component.text.length

                Item {
                    width: fm.advanceWidth("0")
                    height: text.height
                    anchors.verticalCenter: parent.verticalCenter

                    Text {
                        id: text

                        text: component.text[index]
                        font: component.font
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: -fm.advanceWidth("#")
                    }
                }
            }
        }
    }
}
