import QtQuick 2.13
import QtQuick.Controls 2.13

import QtQuick.Window 2.13
import QtQuick.Layouts 1.3

ApplicationWindow
{
	id: newTemplateWindow
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
			text: qsTr("Название шаблона поста:")
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
			cursorVisible: false
			Layout.fillHeight: false
			Layout.fillWidth: true
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
			font.pixelSize: 25

			background: Rectangle {
				implicitWidth: namePostTextEdit.width
				implicitHeight: namePostTextEdit.height
				color: control.enabled ? "transparent" : "#353637"
				border.color: control.enabled ? "#21be2b" : "transparent"
			}
		}
	}

	ScrollView {
		id: textAreaScrollView
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
			anchors.fill: parent
			wrapMode: Text.WrapAtWordBoundaryOrAnywhere
			textFormat: Text.RichText
			verticalAlignment: Text.AlignTop
			placeholderText: "Что у Вас нового?"
		}

		background: Rectangle {
			implicitWidth: textAreaScrollView.width
			implicitHeight: textAreaScrollView.height
			color: control.enabled ? "transparent" : "#353637"
			border.color: control.enabled ? "#21be2b" : "transparent"
		}
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

		RoundButton {
			id: roundButton
			text: "img"
			Layout.fillHeight: false
			Layout.fillWidth: false
		}

		ItemDelegate {
			id: itemDelegate
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
			textRole: "Шаблон поста"
			Layout.fillWidth: true
			displayText: qsTr("")
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
	}
}

