import QtQuick 2.0
import QtQuick.Controls 2.5

import QtQuick.Window 2.13
import QtQuick.Layouts 1.3


Rectangle
{
	id: templatesWindow

	width: 1440
	height: 900
	color: "#f3f3f4"

	property bool openDialogWindow: false
	property string template_name: "Default"
	property var template_idx: 0


	Component.onCompleted: {
		console.log("templatesWindow: db_manager.get_templates()", db_manager.get_templates());

		var res_get_templates = db_manager.get_templates()
		for (var i = 0; i < res_get_templates.length; ++i) {
			var template = db_manager.get_template(res_get_templates[i])
			templateListModel.append({name: template[0], colorCode: template[1]})
		}
	}

	RowLayout {
		id: rowLayout

		x: 550
		width: 400
		height: 60
		anchors.top: parent.top
		anchors.topMargin: 18
		anchors.horizontalCenter: parent.horizontalCenter

		RoundButton {
			id: newTemplateButton

			text: "+"

			onClicked: {
				console.log("newTemplateButton clicked")
				template_name = "Default"
				template_idx = 0
				var component = Qt.createComponent("EditTemplate.qml");
				win = component.createObject(applicationWindow);
				win.show();
			}
		}

		Text {
			id: element

			text: qsTr("Добавить новый шаблон поста")
			elide: Text.ElideLeft
			font.pixelSize: 18
		}
	}


	Rectangle {
		id: listViewRectangle

		width: 400
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 6
		anchors.horizontalCenterOffset: 0
		anchors.top: rowLayout.bottom
		anchors.topMargin: 6
		anchors.horizontalCenter: parent.horizontalCenter
		color: "transparent"

		ListView {
			id: templateListView
			snapMode: ListView.SnapToItem
			keyNavigationWraps: true
			clip: true
			anchors.fill: parent
			focus: true

			// example
			model: ListModel {
				id: templateListModel
		   }

			delegate: Component {
				id: listItemDelegate

				Rectangle {
					width: listViewRectangle.width;
					height: 40
					color: "transparent"
					radius: 1
					border.color: "#d3d2d2"

					RowLayout {
						id: rowLayoutItemDelegate
						Layout.fillWidth: listViewRectangle.width
						spacing: 20

						Row {
							id: rowItemDelegate
							Layout.preferredWidth: 350
							Layout.fillWidth: true
							spacing: 20

							Rectangle {
								width: 40
								height: 40
								color: colorCode
								radius: 5
							}

							Text {
								text: name
								anchors.verticalCenter: parent.verticalCenter
								font.bold: true
							}
						}

						Button {
							id: deleteTemplateButton
							x: 350
							text: qsTr("x")
							clip: true
							Layout.preferredWidth: 20
							Layout.preferredHeight: 20
							Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
							visible: model.name !== "Default"
							onClicked: {
								console.log(name + " removed from list")
								templateListModel.remove(index)

								var res_delete_template = db_manager.delete_template(name)
								console.log("GeneralPage:", "db_manager.delete_template():", res_delete_template)
							}

						}

						MouseArea {
							anchors.fill: rowItemDelegate
							onClicked: {
								templateListView.currentIndex = index
							}

							onDoubleClicked: {
								console.log("openDialogWindow ", templateListModel.get(templateListView.currentIndex).name + ' template selected')
								template_name = templateListModel.get(templateListView.currentIndex).name
								template_idx = templateListView.currentIndex
								openDialogWindow = true;

								var component = Qt.createComponent("EditTemplate.qml");
								win = component.createObject(applicationWindow);
								win.show();
							}
						}
					}
				}
			}

		   highlight: Rectangle {
			   color: "lightsteelblue";
			   radius: 2
		   }

		   onCurrentItemChanged: {
			   console.log(templateListModel.get(templateListView.currentIndex).name + ' template selected')
		   }
	   }
	}
}

