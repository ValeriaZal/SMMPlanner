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
	property var list_posts: []

	onClosing: authentication.close()

	Component.onCompleted: {
		console.log("ApplicationWindow onCompleted")

		loader.path = "Posts.qml"
		componentCache.trim();
		loader.setSource(loader.path);
	}


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

			width: 123
			anchors.rightMargin: 10
			horizontalAlignment: Text.AlignRight
			verticalAlignment: Text.AlignTop
			anchors.top: parent.top
			anchors.bottom: parent.bottom
			anchors.right: parent.right
			font.pixelSize: 15

			Component.onCompleted: fileReader.getVersion();
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
				id: comboBox

				width: 500
				currentIndex: 0
				Layout.fillWidth: true
				Layout.alignment: Qt.AlignRight | Qt.AlignVCenter

				textRole: "group_name"
				model: ListModel {
					id: groupListModel
				}

				onCurrentIndexChanged: {
					console.log("groupComboBox: onCurrentIndexChanged: ", currentIndex, "\t", groupListModel.get(currentIndex).value)
					db_manager.choose_group(groupListModel.get(currentIndex).value)

					if (loader.path !== "PostTemplates.qml") {
						console.log("reload loaded component")
						componentCache.trim();
						loader.setSource(loader.path);
					}

				}

				Component.onCompleted: {
					console.log("groupComboBox: Component.onCompleted")
					var res_get_groups = db_manager.get_groups()
					console.log("GeneralPage:", "db_manager.get_groups():", res_get_groups)

					if (groupListModel.count === 0) {
						for (var i = 0; i < res_get_groups.length; ++i)
						{
							console.log("[i]:", i, "res_get_groups[i][0]:", res_get_groups[i][0], "res_get_groups[i][1]:", res_get_groups[i][1])
							groupListModel.append({group_name: res_get_groups[i][0], value:res_get_groups[i][1] })
						}
					}
				}
			}

			Button {
				id: logOutButton
				text: qsTr("Выйти")
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
					db_manager.update()
					// --- EXAMPLE ---
					list_posts = db_manager.load_posts()
					console.log("calendarWindow:", "db_manager.load_posts():", list_posts)
					// ---------------
                    // --- EXAMPLE ---
                    list_posts = db_manager.get_posts_by_time(1576972801, 1577059199) // 22.12.2019
                    console.log("calendarWindow:", "db_manager.get_posts_by_time():", list_posts)
                    // ---------------
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

						var component = Qt.createComponent("NewPost.qml");
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
						visible: false
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

	Connections {
		target: fileReader

		onVersion: {
			versionText.text = qsTr("Version " + version)
		}
	}
}
