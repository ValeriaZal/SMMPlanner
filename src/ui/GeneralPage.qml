import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import QtQuick.Window 2.13

import QtQuick.Layouts 1.1

ApplicationWindow
{
	id: applicationWindow

	//title of the application
	title: qsTr("SMMPlanner")
	width: 1440
	height: 900
	color: "#f3f3f4"

	property variant win;  // you can hold this as a reference..
	property var access_token: ""

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
			text: qsTr("Version 0.11") // load from version file
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

				onClicked: {
					console.log("logOutButton clicked")
					applicationWindow.close()
					/*applicationWindow.hide()
					var component = Qt.createComponent("login_page.qml");
					win = component.createObject(logOutButton);
					win.show();*/
					/*loader.path = "login_browser.qml"
					componentCache.trim();
					loader.setSource(loader.path);*/
				}
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
				text: qsTr("Календарь")
				Layout.rightMargin: 6
				Layout.bottomMargin: 6
				Layout.leftMargin: 6
				Layout.topMargin: 6
				Layout.preferredWidth: -1
				Layout.fillHeight: true
				Layout.fillWidth: false
				Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

				onClicked: {
					console.log("calendarButton clicked")
					loader.path = "Calendar.qml"
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
					text: qsTr("Посты")
					Layout.rightMargin: 6
					Layout.bottomMargin: 6
					Layout.leftMargin: 6
					Layout.topMargin: 6
					Layout.preferredWidth: -1
					Layout.fillHeight: true
					Layout.fillWidth: false
					Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

					onClicked: {
						console.log("postButton clicked")
						loader.path = "Posts.qml"
						componentCache.trim();
						loader.setSource(loader.path);
					}
				}

				RoundButton {
					id: newPostButton
					width: 12
					height: 32
					text: "+"
					Layout.preferredHeight: 32
					Layout.preferredWidth: 32
					Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
					Layout.fillHeight: false
					Layout.fillWidth: false

					onClicked: {
						console.log("newPostButton clicked")
						var component = Qt.createComponent("EditPost.qml");
						win = component.createObject(applicationWindow);
						win.show();
					}
				}

				RowLayout {
					id: postsRowLayout
					width: 200
					height: parent.height

					Button {
						id: templateButton
						text: qsTr("Шаблоны")
						Layout.rightMargin: 6
						Layout.bottomMargin: 6
						Layout.leftMargin: 6
						Layout.topMargin: 6
						Layout.preferredWidth: -1
						Layout.fillHeight: true
						Layout.fillWidth: false
						Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

						onClicked: {
							console.log("templateButton clicked")
							loader.path = "PostTemplates.qml"
							componentCache.trim();
							loader.setSource(loader.path);
						}
					}

					RoundButton {
						id: newTemplateButton
						width: 24
						height: 24
						text: "+"
						Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

						onClicked: {
							console.log("newTemplateButton clicked")
							var component = Qt.createComponent("EditTemplate.qml");
							win = component.createObject(applicationWindow);
							win.show();
						}
					}
				}
			}
		}
	}
}