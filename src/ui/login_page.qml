import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls 2.13
// pip3 install pywebview
import QtWebSockets 1.1

ApplicationWindow
{
	id: loginWindow

	//title of the application
	title: qsTr("SMMPlanner_test")
	width: 1440
	height: 900
	color: "#f3f3f4"

	Rectangle {
		id: bottomWindowContainer
		y: 595
		height: 25
		color: "#d0d0d0"
		anchors.right: parent.right
		anchors.left: parent.left
		anchors.bottom: parent.bottom

		Text {
			id: versionText
			x: 1317
			width: 123
			text: qsTr("Version 0.1")
			anchors.rightMargin: 10
			horizontalAlignment: Text.AlignRight
			verticalAlignment: Text.AlignVCenter
			anchors.top: parent.top
			anchors.bottom: parent.bottom
			anchors.right: parent.right
			font.pixelSize: 15
		}
	}

	Text {
		id: welcomeText
		x: 404
		width: 632
		height: 70
		text: qsTr("Welcome to SMM Planner!")
		anchors.topMargin: 100
		anchors.horizontalCenterOffset: 0
		verticalAlignment: Text.AlignVCenter
		horizontalAlignment: Text.AlignHCenter
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.top: parent.top
		font.pixelSize: 32
	}

	Rectangle {
		id: webViewContainer
		anchors.top: welcomeText.bottom
		anchors.bottom: bottomWindowContainer.top
		anchors.left: parent.left
		anchors.right: parent.right

		anchors.leftMargin: 6
		anchors.rightMargin: 6
		anchors.topMargin: 6
		anchors.bottomMargin: 6


	}


}

/*##^##
Designer {
	D{i:3;anchors_height:91;anchors_width:632;anchors_x:404;anchors_y:161}
}
##^##*/
