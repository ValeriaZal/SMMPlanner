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

	property string template_name: "Default"
	property var template_idx: 0

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
		namePostTextEdit.text = res_get_template[0]
		templateColorButtonBackground.color = res_get_template[1]
		textArea.text = res_get_template[3]

		var template_tags = res_get_template[4]
		console.log("template_tags:", template_tags)
		for (var i = 0; i < template_tags.length; ++i) {
			var tmp_idx = find(tagsListModel, function(ListElement) { return ListElement.tag === template_tags[i].toString() })
			tagsListModel.get(tmp_idx).checked = true
		}
	}

	Component.onCompleted: {
		console.log("\t\teditTemplateWindow:", templatesWindow)
		if (templatesWindow !== undefined) {
			template_name = templatesWindow.template_name
			template_idx = templatesWindow.template_idx
		}

		console.log("editTemplateWindow:", template_name, template_idx)

		if (template_idx === 0) {
			for (var i = 0; i < templateListModel.count; ++i) {
				templateComboBoxModel.append({template: templateListModel.get(i).name})
			}
			publishButton.text = qsTr("Закончить создание шаблона")
		} else {
			templateComboBoxModel.append({template:template_name})
			publishButton.text = qsTr("Закончить редактирование шаблона")
		}

		templateComboBox.currentIndex = 0
		var res_get_tags = db_manager.get_tags()
		for (var k = 0; k < res_get_tags.length; ++k) {
			tagsListModel.append({tag: res_get_tags[k], checked: false})
		}
		console.log("Component.onCompleted: updateWindow", template_name)
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
				visible: false
				anchors.fill: parent
				source: "../icons/color_picker.jpg"
				fillMode: Image.Stretch
			}


		}

		ComboBox {
			id: templateComboBox

			Layout.fillWidth: true
			displayText: qsTr("Выбранный шаблон: " + currentText)
			textRole: template
			font.bold: true
			Layout.fillHeight: true
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

			model: ListModel {
				id: templateComboBoxModel
				//ListElement { template: "Default" }
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
			textFormat: Text.AutoText
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
								color: "red"
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

			text: qsTr("")
			Layout.fillHeight: true
			Layout.fillWidth: true
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

			onClicked: {
				console.log("publishButton clicked")
				imageListModel.clear()

				var is_valid = post_field_is_valid()

				if (is_valid) {
					var tagList = [];
					for (var i = 0; i < tagsListModel.count; ++i) {
						if (tagsListModel.get(i).checked === true) {
							tagList.push(tagsListModel.get(i).tag.toString());
						}
					}
					console.log(tagList)

					console.log("EditTemplate: save template: ",
								namePostTextEdit.text.toString(),
								templateColorButtonBackground.color.toString(),
								templateComboBox.currentText.toString(),
								textArea.text.toString(),
								tagList)

					var res_save_template = db_manager.save_template(
								[namePostTextEdit.text.toString(),
								 templateColorButtonBackground.color.toString(),
								 templateComboBox.currentText.toString(),
								 textArea.text.toString(),
								 tagList])
					console.log("EditTemplate:", "db_manager.save_template():", res_save_template)

					if (template_idx === 0)
						templateListModel.append({name: namePostTextEdit.text, colorCode: templateColorButtonBackground.color.toString() })

					editTemplateWindow.close()
				}
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

	function post_field_is_valid()
	{
		if (template_idx !== 0) {
			return true
		}

		if (namePostTextEdit.text.toString() === "") {
			imageListModel.append({name: "Error: Name is empty"})
		}

		if (find(templateListModel, function(ListElement) { return ListElement.name === namePostTextEdit.text.toString() }) !== -1) {
			imageListModel.append({name: "Error: Template with this name exists"})
		}

		if (startIcon.visible === true) {
			imageListModel.append({name: "Please, chose the template color"})
		}

		if (find(templateListModel, function(ListElement) { return ListElement.colorCode === templateColorButtonBackground.color.toString() }) !== -1) {
			imageListModel.append({name: "Template with this color exists"})
		}
		return (imageListModel.count === 0)
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

