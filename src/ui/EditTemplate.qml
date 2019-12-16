import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQml 2.13
import QtQuick.Window 2.13

import QtQuick.Layouts 1.4
import QtQuick.Dialogs 1.3


ApplicationWindow
{
	id: editTemplateWindow

	width: 600
	height: 600
	color: "#f3f3f4"
	title: qsTr("SMMPlanner: Редактирование шаблона поста")

	function find(model, criteria)
	{
		for(var i = 0; i < model.count; ++i)
		{
			if (criteria(model.get(i)))
			{
				return model.get(i)
			}
		}
		return -1
	}


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

			onClicked: {
				console.log("templateColorButton clicked")

				colorDialog.open()
			}

			Image {
				id: startIcon
				anchors.fill: parent
				source: "../icons/color_picker.jpg"
				fillMode: Image.Stretch
			}


		}

		ComboBox {
			id: templateComboBox

			Layout.fillWidth: true
			displayText: qsTr("Выбранный шаблон: " + currentText)
			font.bold: true
			Layout.fillHeight: true
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

			// example
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

			// example
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
					text: "#info"
					checked: false
				}
				ListElement
				{
					text: "#tag"
					checked: false
				}
			}

			onAccepted: {
				if (find(model, function(ListElement) { return ListElement.text === editText }) === -1)
				{
					model.append({text: editText, checked: false})
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
			anchors.leftMargin: -10
			anchors.topMargin: -6
			anchors.rightMargin: -446
			anchors.bottomMargin: -358
			anchors.fill: parent
			wrapMode: Text.WrapAtWordBoundaryOrAnywhere
			textFormat: Text.RichText
			verticalAlignment: Text.AlignTop
			placeholderText: qsTr("Что у Вас нового?")
			selectByMouse: true
			focus: true

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

				onClicked: {
					console.log("imageButton clicked")

					imageDialog.open()
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

							spacing: 10

							Button {
								width: 20
								height: 20
								text: qsTr("X")

								onClicked: {
									console.log(delegateItemName.text + " removed from list")
									imageListModel.remove(index)
								}

							}

							Text {
								id: delegateItemName

								text: name
								anchors.verticalCenter: parent.verticalCenter
							}
						}
					}

					model: ListModel {
						id: imageListModel
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

			onClicked: {
				console.log("publishButton clicked")
                // --- EXAMPLE ---
                var res_get_template = db_manager.get_template(["Default"])
                console.log("EditTemplate:", "db_manager.get_template():", res_get_template)
                // ---------------
                editTemplateWindow.close()
			}
		}
	}


	ColorDialog {
		id: colorDialog
		title: qsTr("Выберите цвет шаблона поста")

		onAccepted: {
			console.log("Chosen color: " + colorDialog.color)

			startIcon.visible = false
			templateColorButtonBackground.color = colorDialog.color
		}

		onRejected: {
			console.log("Canceled color")
		}
	}

	function updateImageListModel(fileUrls, model)
	{
		for(var i = 0; i < fileUrls.length; i++)
		{
			model.append({name: fileUrls[i]})
		}
	}

	FileDialog {
		id: imageDialog
		title: "Выберите изображение"
		folder: shortcuts.home
		nameFilters: [ "Image files (*.jpg *.png *.bmp)" ]
		selectMultiple: true

		onAccepted: {
			console.log("You chose: " + imageDialog.fileUrls + "\tcount: " + imageDialog.fileUrls.length)

			updateImageListModel(imageDialog.fileUrls, imageListModel)
		}

		onRejected: {
			console.log("Canceled")
		}
	}
}


/*##^##
Designer {
	D{i:6;anchors_height:16;anchors_width:582}D{i:5;anchors_height:0}
}
##^##*/
