import QtQuick 2.0

Item {
    id: component

    signal nextPage

    property Component rowComponent
    property Component titleComponent: Item {}
    property int visibleRowCount: 6
    property int rowCount: 12
    property alias title: title
    property real titleHeight: height * 0.125
    property int animationDuration: 250 * 3

    readonly property real rowHeight: (component.height - component.titleHeight)
                                     / component.visibleRowCount
    readonly property alias currentPage: internal.currentPage

    QtObject {
        id: internal

        signal animateNextPage
        property int currentPage: 0

        onAnimateNextPage:
            NumberAnimation {
            target: content
            property: "y"
            duration: component.animationDuration
            to: -((component.currentPage) * component.visibleRowCount * component.rowHeight)
            easing.type: Easing.InOutQuad
        }
    }

    state: "hidden"
    onNextPage: {
        if((currentPage + 1) * visibleRowCount < rowCount)  {
            internal.currentPage++
            internal.animateNextPage()
        }
    }

    states: [
        State { name: "full" },
        State { name: "hidden" }
    ]

    transitions: [
        Transition {
            from: "full"
            to: "hidden"
            ScriptAction { script: internal.currentPage = 0 }
        },

        Transition {
            from: "hidden"
            to: "full"
            ScriptAction { script: content.y = 0 }
        }
    ]


    Column{
        anchors.fill: parent

        Loader {
            id: title

            sourceComponent: component.titleComponent
            width: parent.width
            height: component.titleHeight
            onLoaded: title.item.state = Qt.binding(function() { return component.state })
        }

        Item {  // wrapper
            clip: true
            width: parent.width
            height: component.height - component.titleHeight

            Column {
                id: content

                width: parent.width
                height: component.rowCount * component.rowHeight

                Repeater {
                    model: component.rowCount

                    Loader {
                        readonly property int rowIndex: index

                        sourceComponent: component.rowComponent

                        width: component.width
                        height: component.rowHeight
                        onLoaded: {
                            item.animationsDelay = Qt.binding(function() {
                                return Math.max(0,
                                            (index - component.currentPage
                                             * component.visibleRowCount) * 60 + 250);
                            })
                            item.state = Qt.binding(function() {
                                return component.state
                            })
                        }
                    }
                }
            }
        }
    }
}
