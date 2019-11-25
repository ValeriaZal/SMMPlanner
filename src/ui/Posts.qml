import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Window 2.13

import QtQuick.Layouts 1.4


Rectangle
{
	id: postsWindow

	width: 1440
	height: 900
	color: "#f3f3f4"

	StackView
	{
		id: stackView

		anchors.top: rowLayout.bottom
		anchors.right: parent.right
		anchors.bottom: parent.bottom
		anchors.left: parent.left
	}

	RowLayout {
		id: rowLayout

		x: 624
		width: 571
		height: 71
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.top: parent.top

		Button {
			id: communityPostsButton
			text: qsTr("Community Posts")
			Layout.fillHeight: true
			Layout.fillWidth: true
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
		}

		Button {
			id: scheduledPostsButton
			text: qsTr("Scheduled Posts")
			Layout.fillWidth: true
			Layout.fillHeight: true
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
		}
	}
}




/*##^##
Designer {
	D{i:7;anchors_x:518;anchors_y:16}D{i:6;anchors_y:7}
}
##^##*/
