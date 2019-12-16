import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Templates 2.13

import QtQuick.Layouts 1.4
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4


Item {
	id: calendarWindow

	width: 1440
	height: 900

	Calendar
	{
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.fill: parent

		style: CalendarStyle
		{
			gridVisible: true

			dayDelegate: Rectangle
			{
				id: rectDelegate
				color: styleData.selected
					   ? "#ffffff"
					   : (styleData.visibleMonth && styleData.valid
						  ? "#dddedf"
						  : "#404142")

				Label {
					id: dayText

					color: styleData.visibleMonth && styleData.valid
						   ? "#000000"
						   : "light grey"
					text: styleData.date.getDate()
				}

				Rectangle {
					id: listViewBackground

					anchors.top: dayText.bottom
					anchors.left: parent.left
					anchors.right: parent.right
					anchors.bottom: parent.bottom

					ListView {
						id: listView

						parent: listViewBackground

						anchors.leftMargin: 6
						anchors.rightMargin: 6
						anchors.bottomMargin: 6
						anchors.topMargin: 6
						anchors.fill: parent

						clip: true
						contentHeight: 30
						contentWidth: 250

						highlightFollowsCurrentItem: true
						highlightRangeMode: ListView.NoHighlightRange

						boundsBehavior: Flickable.StopAtBounds
						snapMode: ListView.SnapToItem

						delegate: Item {
							x: 0
							width: listView.width
							height: 25

							Button {
								id: postButton

								anchors.leftMargin: 6
								anchors.rightMargin: 6
								anchors.bottomMargin: 6
								anchors.topMargin: 6

								width: listView.width

								onClicked: {
									console.log("Post " + model.name + " clicked")
								}

								style: ButtonStyle {
										background: Rectangle {
											color: model.color // tag color
											radius: 3
											opacity: postButton.pressed ? 0.75 : 0.5
										}

										label: Text {
											text: model.name
										}
								}
							}
						}

						// example
						model: ListModel {
							ListElement {
								name: "post 1"
								color: "grey"
							}

							ListElement {
								name: "post 2"
								color: "red"
							}

							ListElement {
								name: "post 3"
								color: "green"
							}

							ListElement {
								name: "post 4"
								color: "blue"
							}

							ListElement {
								name: "post 5"
								color: "black"
							}
						}
					}
				}
			}
		}
	}
}
