import QtQuick 2.13
import QtQuick.Controls 2.13

import QtQuick.Window 2.13
import QtQuick.Layouts 1.3

//import QtQuick.Controls 1.3
import QtQuick.Dialogs 1.3
import Qt.labs.calendar 1.0

ApplicationWindow
{
	id: newPostWindow
	width: 600
	height: 600
	color: "#f3f3f4"
	title: qsTr("SMMPlanner: New post")

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

		TextEdit {
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
		}
	}

	TextArea {
		id: textArea
		height: 269
		text: qsTr("")
		clip: false
		textFormat: Text.RichText
		verticalAlignment: Text.AlignTop
		//placeholderText: "Что у Вас нового?"
		anchors.right: parent.right
		anchors.rightMargin: 6
		anchors.left: parent.left
		anchors.leftMargin: 6
		anchors.top: templatesRowLayout.bottom
		anchors.topMargin: 6
	}

	RowLayout {
		id: imageRowLayout
		width: 303
		anchors.bottomMargin: 6
		anchors.bottom: parent.bottom
		anchors.left: parent.left
		anchors.leftMargin: 6
		anchors.topMargin: 6
		anchors.top: textArea.bottom

		ColumnLayout {
			id: imageDateColumnLayout
			width: 100
			height: 100

			Button {
				id: imageRoundButton
				Layout.preferredHeight: 32
				Layout.preferredWidth: 32
				//text: "img"
				Layout.fillHeight: false
				Layout.fillWidth: false

				background: Rectangle {
					id: imageRoundButtonBackground
					width: imageRoundButton.width
					height: imageRoundButton.height
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

			Button {
				id: dateRoundButton
				Layout.preferredHeight: 32
				Layout.preferredWidth: 32
				Layout.fillHeight: false
				Layout.fillWidth: false
				//text: "date"

				background: Rectangle {
					id: newTemplateButtonBackground
					width: newTemplateButton.width
					height: newTemplateButton.height
					color: "transparent"
				}

				Image {
					anchors.fill: parent
					source: "../icons/date.png"
					fillMode: Image.Stretch
				}

			}
		}

		ItemDelegate {
			id: attachedImageItemDelegate
			text: qsTr("// список прикрепленных изображений")
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
			Layout.fillHeight: true
			Layout.fillWidth: true
		}
	}

	RowLayout
	{
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
			editable: true
			textRole: ""
			Layout.fillWidth: true
			displayText: qsTr("Templates")
			Layout.fillHeight: true
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

			model: [ "Banana", "Apple", "Coconut" ]
		}

		ComboBox
		{
			id: tagComboBox
			flat: false
			editable: true
			Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
			displayText: qsTr("Tags")
			Layout.fillHeight: true

			model: ListModel
			{
				ListElement
				{
					name: "#music"
					checked: false
				}
				ListElement
				{
					name: "#info"
					checked: false
				}
				ListElement
				{
					name: "#tag"
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
					text: model.name
					highlighted: comboBox.highlightedIndex === index
					checked: model.checked
					onCheckedChanged: model.checked = checked
				}
			}

		}
	}

	ColumnLayout {
		id: saveButtonsColumnLayout
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 6
		anchors.top: textArea.bottom
		anchors.topMargin: 6
		anchors.leftMargin: 6
		anchors.left: imageRowLayout.right
		anchors.rightMargin: 6
		anchors.right: parent.right

		Button {
			id: saveTemplateButton
			text: qsTr("Сохранить шаблон поста")
			Layout.fillHeight: true
			Layout.fillWidth: true
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
		}

		Button {
			id: publicButton
			text: qsTr("Закончить редактирование поста")
			Layout.fillHeight: true
			Layout.fillWidth: true
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
		}
	}
/*
	Dialog {
		id: dateDialog
		visible: true
		title: "Choose a date"
		standardButtons: StandardButton.Ok | StandardButton.Cancel

		onAccepted: console.log("Saving the date " +
			calendar.selectedDate.toLocaleDateString())

		Calendar {
			id: calendar
			//onDoubleClicked: dateDialog.click(StandardButton.Save)
		}
	}
	*/
}



