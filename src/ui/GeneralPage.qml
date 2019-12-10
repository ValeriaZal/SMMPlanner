import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import QtQuick.Window 2.13


ApplicationWindow
{
	id: applicationWindow

	//title of the application
	title: qsTr("SMMPlanner")
	width: 1440
	height: 900
	color: "#f3f3f4"

	property var access_token: ""
	property variant win;  // for newButtons

<<<<<<< Updated upstream
	//onClosing: authentication.logout()
=======
	onClosing: authentication.close()
>>>>>>> Stashed changes

	Loader {
		id: loader

		property string path: ""

		anchors.top: topWindowContainer.bottom
		anchors.bottom: bottomWindowContainer.top
		anchors.left: parent.left
		anchors.right: parent.right
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
<<<<<<< Updated upstream
            width: 123
			anchors.rightMargin: 10
			horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignTop
=======
			width: 123
			anchors.rightMargin: 10
			horizontalAlignment: Text.AlignRight
			verticalAlignment: Text.AlignTop
>>>>>>> Stashed changes
			anchors.top: parent.top
			anchors.bottom: parent.bottom
			anchors.right: parent.right
			font.pixelSize: 15

<<<<<<< Updated upstream
            Component.onCompleted: fileReader.getVersion();
=======
			Component.onCompleted: fileReader.getVersion();
>>>>>>> Stashed changes
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

			x: 946
			width: 494
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
<<<<<<< Updated upstream
				id: comboBox
				width: 200
				displayText: "Selected Group"
=======
				id: groupComboBox
				property bool ready: false;

				width: 500
				Layout.fillWidth: true
				Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
				textRole: "group_name"
				model: ListModel {
					id: groupListModel

					ListElement { group_name: "SelectedGroup"; value: 0 }
					ListElement { group_name: "Long---Long---Long---Long---Long---Name(48chars)"; value: 11111 }
					ListElement { group_name: "First group"; value: 123 }
					ListElement { group_name: "Second group"; value: 456 }
					ListElement { group_name: "Third group"; value: 789 }
				}

				// groupListModel.append({group_name: editText, value: false})

				onCurrentTextChanged: {
					console.log("Selected Group clicked")
					console.log("currentIndex = ", model.get(currentIndex).value)

					if (ready === true && groupListModel.get(0).group_name === "SelectedGroup")
					{
						groupListModel.remove(0);
					}

					//db_manager.choose_group("124653069") // test group id
				}

				Component.onCompleted: {
					console.log("groupComboBox: Component.onCompleted")
					ready = true;
				}

				onModelChanged: {
					console.log("groupComboBox: onModelChanged")
				}
>>>>>>> Stashed changes
			}

			Button {
				id: logOutButton
<<<<<<< Updated upstream
				text: qsTr("Log Out")
=======
				text: qsTr("Выйти")
>>>>>>> Stashed changes
				Layout.rightMargin: 6
				Layout.bottomMargin: 6
				Layout.leftMargin: 6
				Layout.topMargin: 6
				Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
				font.pixelSize: 18

				onClicked: {
					console.log("logOutButton clicked")
					authentication.logout()
					applicationWindow.close()
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
<<<<<<< Updated upstream

=======
					db_manager.update()
>>>>>>> Stashed changes
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

						width: 12
						height: 32
						text: "+"
						Layout.preferredHeight: 32
						Layout.preferredWidth: 32
						Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
						Layout.fillHeight: false
						Layout.fillWidth: false

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

<<<<<<< Updated upstream

    Connections {
        target: fileReader

        onVersion: {
            versionText.text = qsTr("Version " + version)
        }
    }
=======
	Connections {
			target: fileReader

			onVersion: {
				versionText.text = qsTr("Version " + version)
			}
		}
>>>>>>> Stashed changes
}
