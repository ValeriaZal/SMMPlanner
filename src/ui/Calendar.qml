import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Templates 2.13
import QtQml 2.0
import QtQuick.Layouts 1.4
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.13 as NewControl

Rectangle {
	id: calendarWindow

	property var edited_post;
	property var selected_post_id;
	property variant win;  // for newButtons

	width: 1440
	height: 900

	function getDayListPosts(sdate) {
		list_posts = db_manager.get_posts_by_time(sdate, sdate + 86400)
		return list_posts
	}

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


	signal modelUpdate(var month)
	onModelUpdate: {
		console.log("onModelUpdate", month)
	}


	Calendar
	{
		id: calendar

		anchors.horizontalCenter: parent.horizontalCenter
		anchors.fill: parent

		property ListModel day_model: [];

		style: CalendarStyle
		{
			id: calendarStyle
			gridVisible: true

			navigationBar: Rectangle {
				height: 48
				color: "#f7f7f7"

				Rectangle {
					color: "#d7d7d7"
					height: 1
					width: parent.width
					anchors.bottom: parent.bottom
				}

				NewControl.Button {
					id: previousMonth
					width: parent.height - 8
					height: width
					anchors.verticalCenter: parent.verticalCenter
					anchors.left: parent.left
					anchors.leftMargin: 8
					text: "<"
					visible: false

					onClicked: {
						console.log("showPreviousMonth")
						control.showPreviousMonth()
						calendarWindow.modelUpdate(style.VisibleMonth)
						listView.onNeedUpdateModel(style.VisibleMonth)
						console.log(style.VisibleMonth)
						delegateListModel.clear()
					}
				}

				NewControl.Label {
					id: dateText
					text: styleData.title
					color:  "black"
					elide: Text.ElideRight
					horizontalAlignment: Text.AlignHCenter
					font.pixelSize: 16
					anchors.verticalCenter: parent.verticalCenter
					anchors.left: previousMonth.right
					anchors.leftMargin: 2
					anchors.right: nextMonth.left
					anchors.rightMargin: 2
				}

				NewControl.Button {
					id: nextMonth
					width: parent.height - 8
					height: width
					anchors.verticalCenter: parent.verticalCenter
					anchors.right: parent.right
					text: ">"
					visible: false

					onClicked: {
						console.log("showNextMonth")
						control.showNextMonth()
						calendar.modelUpdate(style.VisibleMonth)
						console.log(style.VisibleMonth)
					}
				}
			}

			dayDelegate: Rectangle {
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
							id: itemDelegate
							x: 0
							width: listView.width
							height: 25

							//signal onNeedModelUpdate()

							//onNeedModelUpdate: {
							//	console.log("onNeedModelUpdate")
								/*var dayListPost = getDayListPosts(styleData.date.getTime()/1000)
								for (var i = 0; i < dayListPost.length; ++i) {
									var color = color = dayListPost[i][2]
									var enabled = (dayListPost[i][1] === "VK post")
									delegateListModel.append({post_id: dayListPost[i][0], name: dayListPost[i][1], color: color, status: dayListPost[i][4], enabled: enabled})
								}*/
							//}



							Button {
								id: postButton

								anchors.leftMargin: 6
								anchors.rightMargin: 6
								anchors.bottomMargin: 6
								anchors.topMargin: 6
								enabled: model.enabled

								width: listView.width

								onClicked: {
									selected_post_id = model.post_id
									edited_post = find(delegateListModel, function(ListElement) { return ListElement.name === model.name })
									console.log("Find Post " + edited_post.name + " clicked")

									var component = Qt.createComponent("EditPost.qml");
									win = component.createObject(applicationWindow);
									win.show();
									// console.log(post)
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
							//ListElement { post_id: 1; name: "post test"; color: "grey", enabled: false }
						}

						signal needUpdateModel(var month)

						onNeedUpdateModel: {
							console.log("onNeedUpdateModel")
						}

						Component.onCompleted: {
							var dayListPost = getDayListPosts(styleData.date.getTime()/1000)
							for (var i = 0; i < dayListPost.length; ++i) {
								var color = dayListPost[i][2]
								var enabled = (dayListPost[i][1] !== "VK post")
								delegateListModel.append({post_id: dayListPost[i][0], name: dayListPost[i][1], color: color, status: dayListPost[i][4], enabled: enabled})
							}
						}
					}
				}
			}
		}
	}

	Connections {
		target: listView

		function onNeedUpdateModel(month) { console.log("onNeedUpdateModel ", month) }
	}
}
