import QtQuick 2.0
import QtQuick.Controls 1.0

ApplicationWindow {

    //title of the application
    title: qsTr("SMMPlanner_test")
    width: 640
    height: 480
    color: "#e7fffb"

    //Welcome text
    Text {
        id: element
        x: 117
        y: 163
        text: qsTr("Welcome to SMM Planner!")
        font.pixelSize: 35
    }

    //A button in the middle of the content area
    Button {
        id: button
        text: qsTr("Log in")
        checkable: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        onClicked: console.log("Log in activated.");
    }

    // Version number
    Text {
        id: element1
        x: 572
        y: 458
        text: qsTr("Version 0.0")
        font.pixelSize: 12
    }
}
