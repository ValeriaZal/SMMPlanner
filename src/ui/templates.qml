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
				var component = Qt.createComponent("new_template.qml");
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
			id: list
			snapMode: ListView.SnapToItem
			keyNavigationWraps: true
			clip: true
			anchors.fill: parent
			model: ListModel {
						   ListElement {
							   name: "Default"
							   colorCode: "grey"
						   }

						   ListElement {
							   name: "News"
							   colorCode: "red"
						   }

						   ListElement {
							   name: "Music"
							   colorCode: "blue"
						   }

						   ListElement {
							   name: "Art"
							   colorCode: "green"
						   }
					   }
			   delegate: Component {
				   id: listItemDelegate

				   Item {
					   width: listViewRectangle.width;
					   height: 40

					   Row {
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
					   MouseArea {
						   anchors.fill: parent
						   onClicked: list.currentIndex = index
					   }
				   }
			   }
			   highlight: Rectangle {
				   color: "lightsteelblue";
				   radius: 2
			   }
			   focus: true
			   onCurrentItemChanged: {
				   console.log(model.get(list.currentIndex).name + ' template selected')
			   }
		   }
	}
}

/*##^##
Designer {
	D{i:1;anchors_y:60}D{i:4;anchors_height:60}
}
##^##*/
