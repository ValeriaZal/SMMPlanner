import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQml 2.2

import QtQuick.Window 2.13
import QtQuick.Layouts 1.3

import QtQuick.Controls 1.4 as Old
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Private 1.0
//import QtQuick.Dialogs 1.2

ApplicationWindow
{
	id: editPostWindow
	width: 600
	height: 600
	color: "#f3f3f4"
	title: qsTr("SMMPlanner: Редактирование поста")

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

	ScrollView {
		id: textAreaScrollView
		parent: editPostWindow
		height: 377
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
			anchors.rightMargin: -446
			anchors.bottomMargin: -334
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
			font.bold: true
			editable: false
			Layout.fillWidth: true
			displayText: qsTr("Выбранный шаблон: " + currentText)
			Layout.fillHeight: true
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

			model: [ "Default", "Music", "Info" ]
		}

		ComboBox
		{
			id: tagComboBox
			flat: false
			editable: true
			Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
			displayText: qsTr("Tags")
			Layout.fillHeight: true

			function find(model, criteria) {
			  for(var i = 0; i < model.count; ++i)
				  if (criteria(model.get(i)))
					  return model.get(i)
			  return -1
			}

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

			onAccepted: {
				if (find(model, function(ListElement) { return ListElement.text === editText }) === -1)
				{
					model.append({text: editText, checked: false})
				}
			}

		}
	}

	RowLayout {
		id: settingsRowLayout
		//parent: editPostWindow
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 6
		anchors.top: textAreaScrollView.bottom
		anchors.topMargin: 6
		anchors.right: parent.right
		anchors.rightMargin: 6
		anchors.leftMargin: 6
		anchors.left: parent.left

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
								text: qsTr("X")
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
						dateTimePickerDialog.open()
					}

				}

				Text {
					id: dateTimeText
					verticalAlignment: Text.AlignVCenter
					horizontalAlignment: Text.AlignLeft
					font.pixelSize: 12
					text: qsTr(new Date().toLocaleString(Qt.locale("ru_RU"), "ddd dd.MM.yyyy hh:mm"))
				}
			}

			Button {
				id: publishButton
				text: qsTr("Закончить редактирование поста")
				Layout.fillHeight: true
				Layout.fillWidth: true
				Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

				onClicked: {
					console.log("publishButton clicked")
					editPostWindow.close()
				}
			}
		}
	}

	Dialog {
		id: dateTimePickerDialog
		title: "Выберите дату публикации"
		modal: true

		standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel

		onAccepted: {
			console.log("time: " + hoursComboBox.currentIndex + ":" + minutesComboBox.currentIndex)
			console.log("Selected the date " + calendar.selectedDate.toLocaleDateString())
			dateTimeText.text = qsTr(calendar.selectedDate.toLocaleDateString(Qt.locale("ru_RU"), "ddd dd.MM.yyyy")
									 + " " + hoursComboBox.currentIndex.toString()
									 + ":" + minutesComboBox.currentIndex.toString())
		}

		ColumnLayout {
			Old.Calendar {
				id: calendar
				//Layout.centerIn: parent
				onDoubleClicked: dateTimePickerDialog.click(DialogButtonBox.Ok)
				//width: dateTimePickerDialog.width
			}

			RowLayout {
				id: timeRowLayout
				anchors.horizontalCenter: parent
				anchors.top: calendar.bottom
				anchors.bottom: footer.top

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
					model: 64
					currentIndex: new Date().getMinutes()
				}
			}

			spacing: 1
		}
	}
}





