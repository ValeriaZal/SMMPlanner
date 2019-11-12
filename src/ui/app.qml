/*
import QtQuick 2.0
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2
import QtQuick.Templates 2.5


ApplicationWindow
{
	id: applicationWindow
	//title of the application
	title: qsTr("SMMPlanner_test")
	width: 1440
	height: 900
	color: "#e7fffb"

	//Welcome text
	Text {
		id: element
		x: 117
		y: 20
		text: qsTr("Welcome to SMM Planner!")
		font.pixelSize: 35
	}

	//A button in the middle of the content area
	Button {
		id: button
		text: qsTr("Log in")
		anchors.verticalCenterOffset: -206
		anchors.horizontalCenterOffset: 267
		checkable: true
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		onClicked:
		{
			print("Reloading ", loader.path);
			loader.setSource(loader.path);

		}
	}

	// Version number
	Text {
		id: element1
		x: 572
		y: 458
		text: qsTr("Version 0.1")
		font.pixelSize: 12
	}


	Loader
	{
		id: loader
		property string path: "log_in_page.qml"
		anchors.rightMargin: 0
	  anchors.bottomMargin: 0
	  anchors.leftMargin: 0
	  anchors.topMargin: 0
		anchors.fill: parent

		source: path

		TabButton {
			id: tabButton
			x: 190
			y: 227
			text: qsTr("Tab Button")
		}

		TabButton {
			id: tabButton1
			x: 271
			y: 227
			text: qsTr("Tab Button")
		}

  TabButton {
	  id: tabButton2
	  x: 352
	  y: 227
	  text: qsTr("Tab Button")
  }

  TabBar {
	  id: tabBar
	  x: 190
	  y: 273
	  width: 240
	  height: 57
  }
	}
}
*/
