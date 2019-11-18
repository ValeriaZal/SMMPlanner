import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Window 2.13

import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3

ApplicationWindow
{
	id: editTemplateWindow
	width: 600
	height: 600
	color: "#f3f3f4"
	title: qsTr("SMMPlanner: Edit template")

	RowLayout {
		id: nameRowLayout
		height: 60
		anchors.right: parent.right
		anchors.rightMargin: 6
		anchors.left: parent.left
		anchors.leftMargin: 6
		anchors.top: parent.top
		anchors.topMargin: 6

		Text {
			id: namePostText
			text: qsTr("Название шаблона поста:")
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
			verticalAlignment: Text.AlignVCenter
			Layout.fillHeight: true
			Layout.fillWidth: false
			font.pixelSize: 18
		}

		TextField {
			id: namePostTextEdit
			width: 80
			height: 20
			font.weight: Font.Bold
			clip: true
			horizontalAlignment: Text.AlignLeft
			cursorVisible: false
			Layout.fillHeight: false
			Layout.fillWidth: true
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
			font.pixelSize: 25

			background: Rectangle {
				implicitWidth: namePostTextEdit.width
				implicitHeight: namePostTextEdit.height
			}
		}
	}

	ScrollView {
		id: textAreaScrollView
		anchors.right: parent.right
		anchors.rightMargin: 6
		anchors.left: parent.left
		anchors.leftMargin: 6
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 70
		anchors.top: templatesRowLayout.bottom
		anchors.topMargin: 6
		clip: true

		TextArea {
			id: textArea
			clip: true
			text: qsTr("")
			anchors.rightMargin: -446
			anchors.bottomMargin: -364
			anchors.fill: parent
			wrapMode: Text.WrapAtWordBoundaryOrAnywhere
			textFormat: Text.RichText
			verticalAlignment: Text.AlignTop
			placeholderText: "Что у Вас нового?"

		}

		background: Rectangle {
			implicitWidth: textAreaScrollView.width
			implicitHeight: textAreaScrollView.height
		}
	}

	RowLayout {
		id: settingsRowLayout
		anchors.right: parent.right
		anchors.rightMargin: 6
		anchors.left: parent.left
		anchors.leftMargin: 6
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 6
		anchors.top: textAreaScrollView.bottom
		anchors.topMargin: 6
		parent: editTemplateWindow

		RowLayout {
			id: imageRowLayout
			width: 303

			Button {
				id: imageButton
				Layout.preferredHeight: 32
				Layout.preferredWidth: 32
				Layout.fillHeight: false
				Layout.fillWidth: false

				background: Rectangle {
					id: imageRoundButtonBackground
					width: imageButton.width
					height: imageButton.height
					color: "transparent"
				}

				Image {
					sourceSize.height: 60
					sourceSize.width: 60
					anchors.fill: parent
					source: "../icons/camera128.png"
					fillMode: Image.Stretch
				}
			}

			Rectangle {
				id: attachedImageListViewBackground
				width: 200
				height: 200
				color: "#ffffff"
				Layout.preferredHeight: 75
				Layout.fillHeight: true
				Layout.preferredWidth: 300
				Layout.fillWidth: true

				ListView {
					id: listView
					anchors.rightMargin: 6
					anchors.leftMargin: 6
					anchors.bottomMargin: 6
					anchors.topMargin: 6
					highlightFollowsCurrentItem: true
					snapMode: ListView.SnapToItem
					boundsMovement: Flickable.StopAtBounds
					boundsBehavior: Flickable.StopAtBounds
					highlightRangeMode: ListView.NoHighlightRange
					contentHeight: 30
					contentWidth: 250
					clip: true
					parent: attachedImageListViewBackground
					anchors.fill: parent


					delegate: Item {
						x: 1
						width: listView.width
						height: 30

						Row {
							id: rowListView

							Button {
								width: 20
								height: 20
								text: qsTr("x")
							}

							Text {
								text: name
								anchors.verticalCenter: parent.verticalCenter
							}

							spacing: 10
						}
					}

					model: ListModel {
						ListElement {
							name: "image1"
						}

						ListElement {
							name: "image2"
						}

						ListElement {
							name: "image3"
						}

						ListElement {
							name: "image4"
						}
					}
				}
			}
		}

		Button {
			id: publishButton
			text: qsTr("Закончить создание шаблона")
			Layout.fillHeight: true
			Layout.fillWidth: true
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
		}
	}

	RowLayout {
		id: templatesRowLayout
		x: 0
		y: 0
		height: 60
		anchors.topMargin: 72
		anchors.top: parent.top
		anchors.leftMargin: 6
		anchors.rightMargin: 6
		anchors.left: parent.left
		anchors.right: parent.right

		Button {
			id: templateColorButton
			Layout.preferredHeight: 60
			Layout.preferredWidth: 60
			Layout.fillHeight: true
			Layout.fillWidth: false

			background: Rectangle {
				id: templateColorButtonBackground
				width: templateColorButton.width
				height: templateColorButton.height
				color: "transparent"
			}

			Image {
				id: startIcon
				anchors.fill: parent
				source: "../icons/color_picker.jpg"
				fillMode: Image.Stretch
			}

			onClicked: {
				colorDialog.open()
			}

		}

		ComboBox {
			id: templateComboBox
			Layout.fillWidth: true
			displayText: qsTr("Выбранный шаблон: " + currentText)
			font.bold: true
			Layout.fillHeight: true
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

			model:
			[
				"Default",
				"Music",
				"Info"
			]
		}


		ComboBox
		{
			id: tagComboBox
			focusPolicy: Qt.ClickFocus
			wheelEnabled: false
			clip: true
			editable: true
			Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
			displayText: qsTr("Tags")
			font.bold: true
			Layout.fillHeight: true

			function find(model, criteria) {
			  for(var i = 0; i < model.count; ++i)
				  if (criteria(model.get(i)))
					  return model.get(i)
			  return -1
			}

			model: ListModel
			{
				id: tagsModel

				ListElement
				{
					text: "#music"
					checked: false
				}
				ListElement
				{
					text: "#info"
					checked: false
				}
				ListElement
				{
					text: "#magic"
					checked: false
				}
			}

			delegate: Item
			{
				width: parent.width
				implicitHeight: checkDelegate.implicitHeight

				CheckDelegate
				{
					id: checkDelegate
					width: parent.width
					text: model.text
					checked: model.checked
					highlighted: comboBox.highlightedIndex === index
					onCheckedChanged: model.checked = checked
				}
			}

			onAccepted: {
				if (find(model, function(ListElement) { return ListElement.text === editText }) === -1)
				{
					model.append({text: editText, checked: false})
				}
			}

		}

	}

	ColorDialog {
		id: colorDialog
		title: "Выберите цвет шаблона поста"
		onAccepted: {
			console.log("Chosen color: " + colorDialog.color)
			startIcon.visible = false
			templateColorButtonBackground.color = colorDialog.color
		}
		onRejected: {
			console.log("Canceled color")
		}
	}

}



/*##^##
Designer {
	D{i:6;anchors_height:16;anchors_width:582}D{i:5;anchors_height:0}
}
##^##*/
