import QtQuick 2.0
import Qt.labs.calendar 1.0
import QtQuick.Window 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import QtQuick.Templates 2.13

import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4


Item
{
	id: calendarWindow
	width: 1440
	height: 900
	//color: "#f3f3f4"

	Calendar
	{
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.fill: parent
        //anchors.top: monthText.bottom

		style: CalendarStyle
		{
			gridVisible: true
			dayDelegate: Rectangle
			{
				gradient: Gradient
				{
					GradientStop {
						position: 0.00
						color: styleData.selected ? "#ffffff" : (styleData.visibleMonth && styleData.valid ? "#dddedf" : "#404142");
					}
				}

				Label {
					text: styleData.date.getDate()
                    /*anchors.top: parent
					anchors.left: parent
                    anchors.right: parent*/
					color: styleData.visibleMonth && styleData.valid ? "#000000" : "light grey"
				}

				ListView
				{
					id: dayPostsListView
					model: Qt.fontFamilies()
					delegate: ItemDelegate
					{
						text: modelData
						highlighted: ListView.isCurrentItem
						onClicked: listView.currentIndex = index
					}
					ScrollIndicator.vertical: ScrollIndicator { }

				}
			}
		}
	}
}
