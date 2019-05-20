import QtQuick 2.12
import QtQuick.Layouts 1.12


Rectangle {
    id: component

    property int spacing: 0
    property int titleTextPixelSize: 0

    color: "white"

    // Bottom Line
    Rectangle {
        z: 1
        width: parent.width
        height: 2
        color: "#4a52a4"

        anchors.bottom: parent.bottom
    }

    QtObject {
        id: internal

        readonly property Component textComponent: PosLinkedText {
            font.family: "Saira Black"
            font.pixelSize: component.height * 0.322

            linkedTextFont.family: "Saira"
            linkedTextFont.pixelSize: component.titleTextPixelSize
        }
    }

    RowLayout {
        id: layout

        spacing: component.spacing

        height: parent.height
        width: parent.width

        anchors.left: parent.left
        anchors.right: parent.right

        anchors.leftMargin: layout.spacing * 1.5
        anchors.rightMargin: layout.spacing

        Loader {
            sourceComponent: internal.textComponent
            height: component.height

            onLoaded: {
                item.linkedText = "#"
                item.text.text = rowIndex + 5 + "."
                item.text.anchors.right = item.text.parent.right
                item.text.anchors.rightMargin = -item.fm.advanceWidth(".")
            }
        }

        Item {
            width: height
            height: component.height * 0.74
            Layout.leftMargin: layout.spacing

            Image {
                source: "mc-club-logos-2019/2019/" + "dukla-praha" + ".png"

                fillMode: Image.PreserveAspectFit
                mipmap: true
                anchors.fill: parent
            }
        }

        Text {
            text: "horka nad moravou"
            font.family: "High School USA Sans"
            font.pixelSize: parent.height * 0.462
        }

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        Loader {
            sourceComponent: internal.textComponent
            height: parent.height
            onLoaded: {
                item.linkedText = "V"
                item.text.text = "12"
                item.text.anchors.horizontalCenter = item.text.parent.horizontalCenter
            }
        }

        Loader {
            sourceComponent: internal.textComponent
            height: parent.height
            onLoaded: {
                item.linkedText = "P"
                item.text.text = "12"
                item.text.anchors.horizontalCenter = item.text.parent.horizontalCenter
            }
        }

        Loader {
            sourceComponent: internal.textComponent
            height: parent.height
            onLoaded: {
                item.linkedText = "R"
                item.text.text = "12"
                item.text.anchors.horizontalCenter = item.text.parent.horizontalCenter
            }
        }

        Loader {
            sourceComponent: internal.textComponent
            height: parent.height
            Layout.leftMargin: layout.spacing
            onLoaded: {
                item.linkedText = "skóre"
                item.text.text = "12"
                item.text.anchors.horizontalCenter = item.text.parent.horizontalCenter
            }
        }

        Loader {
            sourceComponent: internal.textComponent
            height: parent.height
            Layout.leftMargin: layout.spacing
            onLoaded: {
                item.linkedText = "body"
                item.text.text = "12"
                item.text.anchors.horizontalCenter = item.text.parent.horizontalCenter
            }
        }
    }
}
