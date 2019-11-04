import QtQuick 2.0
import QtQuick.Controls 2.5

import QtQuick.Window 2.13
import QtQuick.Layouts 1.3

Rectangle
{
	id: postsWindow
	width: 1440
	height: 900
	color: "#f3f3f4"

	RowLayout {
		id: rowLayout1
		x: 410
		y: 20
		width: 619
		height: 84
		anchors.horizontalCenterOffset: 0
		anchors.topMargin: 96
		anchors.top: parent.top
		anchors.horizontalCenter: parent.horizontalCenter
		Rectangle {
			id: rectangle1
			x: 0
			y: 0
			width: 90
			height: 50
			color: "#d0d0d0"
			Layout.fillHeight: true
			Layout.fillWidth: false
		}

		Text {
			id: element1
			text: qsTr("Default")
			Layout.leftMargin: 10
			font.pixelSize: 25
			Layout.fillHeight: true
			horizontalAlignment: Text.AlignLeft
			Layout.fillWidth: true
			verticalAlignment: Text.AlignVCenter
		}
	}

	RowLayout {
		id: rowLayout3
		x: 413
		y: 11
		width: 619
		height: 84
		anchors.topMargin: 6
		anchors.top: parent.top
		anchors.horizontalCenter: parent.horizontalCenter
		Rectangle {
			id: rectangle3
			x: 0
			y: 0
			width: 90
			height: 50
			color: "#000000"
			Layout.fillHeight: true
			Layout.fillWidth: false
		}

		Text {
			id: element3
			text: qsTr("Название шаблона поста")
			Layout.leftMargin: 10
			Layout.fillHeight: true
			font.pixelSize: 25
			horizontalAlignment: Text.AlignLeft
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
			Layout.fillWidth: true
			verticalAlignment: Text.AlignVCenter
		}
		anchors.horizontalCenterOffset: 0
	}

	RowLayout {
		id: rowLayout5
		x: 395
		y: 23
		width: 619
		height: 84
		anchors.topMargin: 276
		anchors.top: parent.top
		anchors.horizontalCenter: parent.horizontalCenter
		Rectangle {
			id: rectangle5
			x: 0
			y: 0
			width: 90
			height: 50
			color: "#4981dc"
			Layout.fillHeight: true
			Layout.fillWidth: false
		}

		Text {
			id: element5
			text: qsTr("Info")
			Layout.leftMargin: 10
			Layout.fillHeight: true
			font.pixelSize: 25
			horizontalAlignment: Text.AlignLeft
			Layout.fillWidth: true
			verticalAlignment: Text.AlignVCenter
		}
		anchors.horizontalCenterOffset: 1
	}

	RowLayout {
		id: rowLayout2
		x: 415
		y: 15
		width: 619
		height: 84
		anchors.topMargin: 186
		anchors.top: parent.top
		anchors.horizontalCenter: parent.horizontalCenter
		Rectangle {
			id: rectangle2
			x: 0
			y: 0
			width: 90
			height: 50
			color: "#ed3d3d"
			Layout.fillHeight: true
			Layout.fillWidth: false
		}

		Text {
			id: element2
			text: qsTr("Music")
			Layout.leftMargin: 10
			Layout.fillHeight: true
			font.pixelSize: 25
			horizontalAlignment: Text.AlignLeft
			Layout.fillWidth: true
			verticalAlignment: Text.AlignVCenter
		}
		anchors.horizontalCenterOffset: 0
	}

	RowLayout {
		id: rowLayout6
		x: 390
		y: 16
		width: 619
		height: 84
		anchors.topMargin: 366
		anchors.top: parent.top
		anchors.horizontalCenter: parent.horizontalCenter

		RoundButton {
			id: roundButton
			width: 90
			height: 50
			text: "+"
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
			Layout.fillWidth: false
			Layout.fillHeight: false
		}

  Text {
	  id: element6
	  text: qsTr("Добавить новый шаблон поста")
	  font.pixelSize: 25
	  Layout.fillHeight: true
	  horizontalAlignment: Text.AlignLeft
	  Layout.fillWidth: true
	  verticalAlignment: Text.AlignVCenter
	  Layout.leftMargin: 60
  }
		anchors.horizontalCenterOffset: 0
	}


}
