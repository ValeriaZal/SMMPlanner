import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import QtQuick.Window 2.13


import QtQuick.Layouts 1.1

ApplicationWindow
{
	id: applicationWindow

	//title of the application
	title: qsTr("SMMPlanner_test")
	width: 1440
	height: 900
	color: "#f3f3f4"
/*
	Loader {
		id: calendarLoader
		anchors.top: topWindowContainer.bottom
		anchors.bottom: bottomWindowContainer.top
		anchors.left: parent.left
		anchors.right: parent.right

		property string path: "calendar.qml"

		source: path
	}

	Loader {
		id: postLoader
		anchors.top: topWindowContainer.bottom
		anchors.bottom: bottomWindowContainer.top
		anchors.left: parent.left
		anchors.right: parent.right

		property string path: "posts.qml"

		source: path
	}

	Loader {
		id: templateLoader

		anchors.top: topWindowContainer.bottom
		anchors.bottom: bottomWindowContainer.top
		anchors.left: parent.left
		anchors.right: parent.right

		property string path: "templates.qml"

		source: path
	}
*/
	Loader {
		id: loader

		anchors.top: topWindowContainer.bottom
		anchors.bottom: bottomWindowContainer.top
		anchors.left: parent.left
		anchors.right: parent.right

		property string path: ""

		source: path
	}


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
			text: qsTr("Version 0.2")
			anchors.rightMargin: 10
			horizontalAlignment: Text.AlignRight
			verticalAlignment: Text.AlignVCenter
			anchors.top: parent.top
			anchors.bottom: parent.bottom
			anchors.right: parent.right
			font.pixelSize: 15
		}
	}

	Rectangle {
		id: topWindowContainer
		x: 6
		height: 50
		color: "#d0d0d0"
		anchors.top: parent.top
		anchors.rightMargin: 0
		anchors.leftMargin: 0
		anchors.left: parent.left
		clip: true
		anchors.right: parent.right

		RowLayout {
			id: userRowLayout
			x: 1025
			width: 415
			anchors.bottom: parent.bottom
			anchors.top: parent.top
			anchors.right: parent.right
			Layout.rightMargin: 1
			Layout.bottomMargin: 1
			Layout.leftMargin: 1
			Layout.topMargin: 1
			Layout.preferredWidth: -1
			Layout.fillHeight: true
			Layout.fillWidth: false
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

			ComboBox {
				id: comboBox
				width: 200
				displayText: "Selected Group"
			}

			Button {
				id: logOutButton
				text: qsTr("Log Out")
				Layout.rightMargin: 6
				Layout.bottomMargin: 6
				Layout.leftMargin: 6
				Layout.topMargin: 6
				Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
				font.pixelSize: 18
			}
		}


		RowLayout {
			id: generalRowLayout
			width: 500
			height: parent.height
			anchors.top: parent.top
			anchors.left: parent.left

			Button {
				id: calendarButton
				text: qsTr("Calendar")
				Layout.rightMargin: 6
				Layout.bottomMargin: 6
				Layout.leftMargin: 6
				Layout.topMargin: 6
				Layout.preferredWidth: -1
				Layout.fillHeight: true
				Layout.fillWidth: false
				Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
				checkable: true

				onClicked: {
					loader.path = "calendar.qml"
					componentCache.trim();
					loader.setSource(loader.path);
				}
			}

			RowLayout {
				id: templatesRowLayout
				width: 200
				height: parent.height

				Button {
					id: postButton
					text: qsTr("Posts")
					Layout.rightMargin: 6
					Layout.bottomMargin: 6
					Layout.leftMargin: 6
					Layout.topMargin: 6
					Layout.preferredWidth: -1
					Layout.fillHeight: true
					Layout.fillWidth: false
					Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
					checkable: true

					onClicked: {
						loader.path = "posts.qml"
						componentCache.trim();
						loader.setSource(loader.path);
					}
				}

				RoundButton {
					id: newPostButton
					text: qsTr("+")
					height: 16
					width: height
					Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
					checkable: true
				}

				RowLayout {
					id: postsRowLayout
					width: 200
					height: parent.height

					Button {
						id: templateButton
						text: qsTr("Templates")
						Layout.rightMargin: 6
						Layout.bottomMargin: 6
						Layout.leftMargin: 6
						Layout.topMargin: 6
						Layout.preferredWidth: -1
						Layout.fillHeight: true
						Layout.fillWidth: false
						Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
						checkable: true

						onClicked: {
							loader.path = "templates.qml"
							componentCache.trim();
							loader.setSource(loader.path);
						}
					}

					RoundButton {
						id: newTemplateButton
						width: 24
						text: qsTr("+")
						height: 24
						Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
						checkable: true
					}
				}
			}
		}
	}

}


/*##^##
Designer {
	D{i:2;anchors_width:200;anchors_x:347}D{i:5;anchors_x:83;anchors_y:93}D{i:6;anchors_x:121;anchors_y:161}
D{i:4;anchors_width:200;anchors_x:347;anchors_y:422}D{i:3;anchors_x:83;anchors_y:93}
}
##^##*/
