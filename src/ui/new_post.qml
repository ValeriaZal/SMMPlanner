import QtQuick 2.13
import QtQuick.Controls 2.13

import QtQuick.Window 2.13
import QtQuick.Layouts 1.3

ApplicationWindow
{
	id: newPostWindow
	width: 600
	height: 600
	color: "#f3f3f4"

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
		textFormat: Text.RichText
		verticalAlignment: Text.AlignTop
		placeholderText: "Что у Вас нового?"
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

			RoundButton {
				id: imageRoundButton
				text: "img"
				Layout.fillHeight: false
				Layout.fillWidth: false
			}

			RoundButton {
				id: dateRoundButton
				text: "date"
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
			Layout.fillWidth: true
			displayText: qsTr("Шаблон поста")
			font.bold: true
			Layout.fillHeight: true
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

			model: [ "Banana", "Apple", "Coconut" ]
		}

		ComboBox
		{
			id: tagComboBox
			editable: true
			Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
			displayText: qsTr("Tags")
			font.bold: true
			Layout.fillHeight: true

			model: ListModel
			{
				ListElement
				{
					name: "music"
					checked: false
				}
				ListElement
				{
					name: "info"
					checked: false
				}
				ListElement
				{
					name: "tag"
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
}


/*##^##
Designer {
	D{i:1;anchors_width:100;anchors_x:199;anchors_y:95}D{i:4;anchors_width:562;anchors_x:15;anchors_y:82}
D{i:5;anchors_height:140;anchors_x:33;anchors_y:364}D{i:10;anchors_width:100;anchors_x:199;anchors_y:95}
D{i:19;anchors_height:140;anchors_width:100;anchors_x:410;anchors_y:415}
}
##^##*/
