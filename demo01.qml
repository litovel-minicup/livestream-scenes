import QtQuick 2.7;
import QtQuick.Window 2.2;

Item {
	width: engine.width;
	height: engine.height;

	focus: true;

	Window {
		visible: true;
		width: 200;
		height: 200;
	}

	Rectangle {
        id: rect
        color: "red";
        opacity: 0.8;
        width: 50;
        height: 50;

        SequentialAnimation {
            loops: Animation.Infinite
            running: true
            NumberAnimation {
                duration: 400;
                target: rect
                property: "y";
                from: 0;
                to: 200;
            }

            NumberAnimation {
                duration: 400;
                target: rect
                property: "y";
                from: 200;
                to: 0;
            }
        }
    }
}