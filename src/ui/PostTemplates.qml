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

	property variant win;  // for newButtons

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

			model: ListModel {
				id: templateListModel

				// example
				ListElement { name: "Default"; colorCode: "grey" }
				ListElement { name: "News"; colorCode: "red" }
				ListElement { name: "Music"; colorCode: "blue" }
				ListElement { name: "Art"; colorCode: "green" }
			}

			Component.onCompleted: {
				// load templates from db
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

							onClicked: {
								console.log(listItemDelegate.text + " removed from list")
								templateListModel.remove(index)
								// sync with db
							}

						}

						MouseArea {
							anchors.fill: rowItemDelegate
							onClicked: {
								templateListView.currentIndex = index
							}

							onDoubleClicked: {
								// open EditTemplate with prefilled fields

								// open editPost with templateId
								var component = Qt.createComponent("EditPost.qml");
								win = component.createObject(applicationWindow);
								win.show();
							}
						}
					}
				}
			}

			highlight: Rectangle {
				color: "lightsteelblue"
				radius: 2
				//width: rowLayoutItemDelegate.width;
			}

			onCurrentItemChanged: {
				console.log(templateListModel.get(templateListView.currentIndex).name + ' template selected')
			}
		}
	}
}
