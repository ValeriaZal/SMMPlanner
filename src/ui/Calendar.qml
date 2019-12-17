import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Templates 2.13
import QtQml 2.0
import QtQuick.Layouts 1.4
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4


Rectangle {
	id: calendarWindow

	width: 1440
	height: 900

	Component.onCompleted: {
		//console.log("calendarWindow.onCompleted", applicationWindow.list_posts)
	}

	function getDayListPosts(sdate) {
		console.log("getDayListPosts: ", sdate)
		var dayList = []
		for (var i = 0; i < applicationWindow.list_posts.length; ++i) {
			var tmp_date;
			tmp_date = new Date(list_posts[i][3]*1000).setHours(12)
			tmp_date = new Date(tmp_date).setMinutes(0)
			tmp_date = new Date(tmp_date).setSeconds(0)
			tmp_date = new Date(tmp_date).setMilliseconds(0)
			//console.log(i, "tmp_date:", tmp_date, "tmp_date.getHours/Minutes():", tmp_date.getHours(), tmp_date.getMinutes())
			//console.log(i, "tmp_date: ", tmp_date)
			if (tmp_date === sdate) {
				console.log("tmp_date === sdate")
				dayList.push(list_posts[i])
				console.log(i, "tmp_date:", tmp_date, "list_posts[i]", list_posts[i])
			}
		}
		return dayList
	}


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

						// load_posts (list of post<id, title, color, time, status>)
						model: ListModel {
							id: delegateListModel
							//ListElement { post_id: 1; name: "post test"; color: "grey" }
						}

						Component.onCompleted: {
							console.log("listView.onCompleted", styleData.date)
							var dayListPost = getDayListPosts(styleData.date.getTime())
							for (var i = 0; i < dayListPost.length; ++i) {
								var color = "grey"
								if (dayListPost[i][1] !== "VK post" && dayListPost[i][4] !== "Published") {
									color = dayListPost[i][2]
								}
								delegateListModel.append({post_id: dayListPost[i][0], name: dayListPost[i][1], color: color, status: dayListPost[i][4]})
							}

						}
					}
				}
			}
		}
	}
}
