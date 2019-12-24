import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQml 2.13
import QtQuick.Window 2.13

import QtQuick.Layouts 1.4
import QtQuick.Controls 1.4 as Old
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Private 1.0
import QtQuick.Dialogs 1.3 as OldDialog


ApplicationWindow
{
	id: newPostWindow

	width: 600
	height: 600

	color: "#f3f3f4"
	title: qsTr("SMMPlanner: Создание поста")

	property var post_date: new Date()

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

	function updateWindow(template_name) {
		var res_get_template = db_manager.get_template(template_name)
		console.log("||| db_manager.get_template:", res_get_template)
		//namePostTextEdit.text = res_get_template[0]
		textArea.text = res_get_template[3]

		var template_tags = res_get_template[4]
		console.log("template_tags:", template_tags)
		for (var i = 0; i < template_tags.length; ++i) {
			var tmp_idx = find(tagsListModel, function(ListElement) { return ListElement.tag === template_tags[i].toString() })
			tagsListModel.get(tmp_idx).checked = true
		}
	}


	Component.onCompleted: {
		console.log("newPostWindow.onCompleted")
		// get_post(post_id, db) -> ["title","template_name","colour",[<tags>],"date","text"]

		var list_templates = db_manager.get_templates() // [<Names of templates>]
		//console.log(list_templates, list_templates.count, list_templates.length)
		for (var i = 0; i < list_templates.length; ++i) {
			templateComboBoxModel.append({template: list_templates[i]})
		}
		templateComboBox.currentIndex = 0

		var res_get_tags = db_manager.get_tags()
		for (var k = 0; k < res_get_tags.length; ++k) {
			tagsListModel.append({tag: res_get_tags[k], checked: false})
		}

		updateWindow(template_name)
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
			text: qsTr("Название поста:")
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
			verticalAlignment: Text.AlignVCenter
			Layout.fillHeight: true
			Layout.fillWidth: false
			font.pixelSize: 25
		}

		TextField {
			id: namePostTextEdit
			width: 80
			height: 20
			font.weight: Font.Bold
			clip: true
			horizontalAlignment: Text.AlignLeft
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

		ComboBox {
			id: templateComboBox
			font.bold: true
			editable: false
			Layout.fillWidth: true
			displayText: qsTr("Выбранный шаблон: " + currentText)
			textRole: template
			Layout.fillHeight: true
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

			model: ListModel {
				id: templateComboBoxModel
				//ListElement { template: "Default" } // temporary
			}

			onCurrentIndexChanged: {
				console.log("onCurrentIndexChanged: updateWindow", templateComboBoxModel.get(templateComboBox.currentIndex).template.toString())
				updateWindow(templateComboBoxModel.get(templateComboBox.currentIndex).template)
			}
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
				id: tagsListModel
				//ListElement { tag: "#music"; checked: false }
			}

			onAccepted: {
				var editTextTmp = tagComboBox.editText
				if (editTextTmp.charAt(0) !== '#') {
					editTextTmp = "#" + editTextTmp;
				}
				console.log(tagsListModel, editTextTmp)

				if (find(tagsListModel, function(ListElement) { return ListElement.tag === editTextTmp }) === -1)
				{
					tagsListModel.append({tag: editTextTmp, checked: true})
					db_manager.add_tag(editTextTmp)
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
					text: model.tag
					checked: model.checked
					highlighted: comboBox.highlightedIndex === index
					onCheckedChanged: model.checked = checked
				}
			}
		}
	}


	ScrollView {
		id: textAreaScrollView

		height: 325
		anchors.right: parent.right
		anchors.rightMargin: 6
		anchors.left: parent.left
		anchors.leftMargin: 6
		anchors.bottom: imageRowLayout.top
		anchors.bottomMargin: 6
		anchors.top: templatesRowLayout.bottom
		anchors.topMargin: 6

		clip: true

		TextArea {
			id: textArea
			clip: true
			text: qsTr("")
			anchors.leftMargin: -4
			anchors.topMargin: -1
			anchors.rightMargin: -446
			anchors.bottomMargin: -284
			anchors.fill: parent
			wrapMode: Text.WrapAtWordBoundaryOrAnywhere
			textFormat: Text.AutoText
			verticalAlignment: Text.AlignTop
			placeholderText: "Что у Вас нового?"
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

		anchors.bottom: parent.bottom
		anchors.bottomMargin: 6
		anchors.top: textAreaScrollView.bottom
		anchors.topMargin: 6
		anchors.right: parent.right
		anchors.rightMargin: 6
		anchors.left: parent.left
		anchors.leftMargin: 6

		RowLayout {
			id: imageRowLayout

			width: 303

			Button {
				id: imageButton
				enabled: false

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
				color: "#d3d2d2"

				Layout.preferredHeight: 75
				Layout.fillHeight: true
				Layout.preferredWidth: 300
				Layout.fillWidth: true

				ListView {
					id: listView
					parent: attachedImageListViewBackground

					clip: true
					anchors.rightMargin: 6
					anchors.leftMargin: 6
					anchors.bottomMargin: 6
					anchors.topMargin: 6
					anchors.fill: parent

					contentHeight: 30
					contentWidth: 250
					snapMode: ListView.SnapToItem

					highlightFollowsCurrentItem: true
					highlightRangeMode: ListView.NoHighlightRange

					boundsMovement: Flickable.StopAtBounds
					boundsBehavior: Flickable.StopAtBounds

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
								text: qsTr("x")

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


		ColumnLayout {
			id: saveButtonsColumnLayout

			RowLayout {
				id: dateTimeRowLayout
				width: 100
				height: 100

				Button {
					id: dateButton

					Layout.preferredHeight: 32
					Layout.preferredWidth: 32
					Layout.fillHeight: false
					Layout.fillWidth: false

					background: Rectangle {
						id: newPostButtonBackground

						width: dateButton.width
						height: dateButton.height
						color: "transparent"
					}

					Image {
						anchors.fill: parent
						source: "../icons/date.png"
						fillMode: Image.Stretch
					}


					onClicked: {
						console.log("dateButton clicked")

						dateTimePickerDialog.open()
					}
				}


				Text {
					id: dateTimeText

					verticalAlignment: Text.AlignVCenter
					horizontalAlignment: Text.AlignLeft
					font.pixelSize: 12
					text: qsTr(new Date(new Date().getTime() + 86400000).toLocaleString(Qt.locale("ru_RU"), "ddd dd.MM.yyyy hh:mm"))
				}
			}

			Button {
				id: savePostButton
				text: qsTr("Сохранить пост")
				Layout.fillHeight: true
				Layout.fillWidth: true
				Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

				onClicked: {
					console.log("savePostButton clicked")

					imageListModel.clear()
					var is_valid = post_field_is_valid()

					if (is_valid) {
						var tagList = [];
						for (var i = 0; i < tagsListModel.count; ++i) {
							if (tagsListModel.get(i).checked === true) {
								tagList.push(tagsListModel.get(i).tag.toString());
							}
						}

						var post_date = Date.fromLocaleString(Qt.locale("ru_RU"), dateTimeText.text, "ddd dd.MM.yyyy hh:mm")
						var timestamp = (post_date.getTime()/1000).toString()

						// save_post(["title","template_name",[<tags>],"date","text"]) -> True/False
						var res_save_post = db_manager.publish_post(
									[namePostTextEdit.text.toString(),
									 templateComboBoxModel.get(templateComboBox.currentIndex),
									tagList,
									timestamp,
									textArea.text.toString()]
									)
						console.log("EditPost:", "db_manager.save_post():", res_save_post)
						imageListModel.append({name: "Post saved successfully"})
					}
				}

			}

			Button {
				id: publishPostButton

				text: qsTr("Опубликовать пост")
				Layout.fillHeight: true
				Layout.fillWidth: true
				Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

				onClicked: {
					console.log("publishPostButton clicked")

					imageListModel.clear()
					var is_valid = post_field_is_valid()

					if (is_valid) {
						var tagList = [];
						for (var i = 0; i < tagsListModel.count; ++i) {
							if (tagsListModel.get(i).checked === true) {
								tagList.push(tagsListModel.get(i).text);
							}
						}

						var post_date = Date.fromLocaleString(Qt.locale("ru_RU"), dateTimeText.text, "ddd dd.MM.yyyy hh:mm")
						var timestamp = (post_date.getTime()/1000).toString()


						// publish_post(["title",[<tags>],"date","text"]) -> True/False
						var res_publish_post = db_manager.publish_post(
									[namePostTextEdit.text.toString(),
									tagList,
									timestamp,
									textArea.text.toString()]
									)
						console.log("EditPost:", "db_manager.publish_post():", res_publish_post)
						newPostWindow.close()
					}
				}
			}
		}
	}


	function post_field_is_valid()
	{
		if (namePostTextEdit.text.toString() === "") {
			imageListModel.append({name: "Error: Name is empty"})
		}

		var post_date = Date.fromLocaleString(Qt.locale("ru_RU"), dateTimeText.text, "ddd dd.MM.yyyy hh:mm")
		if (post_date <= new Date()) {
			imageListModel.append({name: "Error: Date in the past"})
		}

		return (imageListModel.count === 0)
	}


	Dialog {
		id: dateTimePickerDialog

		title: qsTr("Выберите дату публикации")

		x: (parent.width - width) / 2
		y: (parent.height - height) / 2

		standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel

		onAccepted: {
			var date_end = datePicker.selectedDate
			date_end.setHours(hoursComboBox.currentIndex)
			date_end.setMinutes(minutesComboBox.currentIndex)
			dateTimeText.text = date_end.toLocaleString(Qt.locale("ru_RU"), "ddd dd.MM.yyyy hh:mm")
		}


		ColumnLayout {
			spacing: 1

			Old.Calendar {
				id: datePicker

				anchors.left: parent.left
				anchors.right: parent.right

				//onDoubleClicked: {
				//	console.log("dateTimePickerDialog.accept()")
				//	dateTimePickerDialog.accept()
				//}
			}

			RowLayout {
				anchors.horizontalCenter: parent
				anchors.top: datePicker.bottom

				ComboBox {
					id: hoursComboBox
					model: 24
					currentIndex: new Date().getHours()
				}

				Text {
					text: ":"
				}

				ComboBox {
					id: minutesComboBox
					model: 60
					currentIndex: new Date().getMinutes()
				}
			}
		}
	}

	function updateImageListModel(fileUrls, model)
	{
		for(var i = 0; i < fileUrls.length; i++)
		{
			model.append({name: fileUrls[i]})
		}
	}

	OldDialog.FileDialog {
		id: imageDialog
		title: "Выберите изображение"
		folder: shortcuts.home
		nameFilters: [ "Image files (*.jpg *.png *.bmp)" ]
		selectMultiple: true

		onAccepted: {
			console.log("You chose: " + imageDialog.fileUrls)
			console.log(imageDialog.fileUrls.length)

			updateImageListModel(imageDialog.fileUrls, imageListModel)
		}

		onRejected: {
			console.log("Canceled")
		}
	}
}
