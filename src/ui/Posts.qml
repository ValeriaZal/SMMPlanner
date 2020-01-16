import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Window 2.13

import QtQuick.Layouts 1.4
import QtWebEngine 1.4


Rectangle
{
	id: postsWindow

	width: 1440
	height: 900
	color: "#f3f3f4"

	Loader {
		id: loader

		property string path: ""
		property var component: webViewPosts

		anchors.top: rowLayout.bottom
		anchors.right: parent.right
		anchors.bottom: parent.bottom
		anchors.left: parent.left
		source: path

		sourceComponent: component
	}

	// Check if user has changed web site (Hacker test)
	function vk_lost(url_string, url_search) {
		var res_wall= url_string.indexOf(url_search);
		if (res_wall === -1) {
			console.log("vk_lost(", url_string, ")")
			console.log("result: true")
			return true;
		}
		return false;
	}

	Component {
		id: webViewPosts
		WebEngineView {
			anchors.fill: parent
			id: webViewContent
			// Get url
			url: authentication.get_wall_posts()

			onLoadingChanged: {
				console.log(loadRequest.url)
				// Case: lost Internet connection
				if (loadRequest.status === WebEngineLoadRequest.LoadFailedStatus) {
					var html = loadRequest.errorString;
					console.log(loadRequest.errorDomain)
					loadHtml(html);
				}

				// Case: user is hacker
				else {
					if (vk_lost(loadRequest.url.toString(), authentication.get_wall_posts())) {
						webViewContent.url = authentication.get_wall_posts()
					}
				}
			}
		}

	}

	Component {
		id: webViewPostponed
		WebEngineView {
			anchors.fill: parent
			id: webViewContent
			url: authentication.get_wall_postponed()
			onLoadingChanged: {
				console.log(loadRequest.url)
				// Case: lost Internet connection
				if (loadRequest.status === WebEngineLoadRequest.LoadFailedStatus) {
					var html = loadRequest.errorString;
					console.log(loadRequest.errorDomain)
					loadHtml(html);
				}

				// Case: user is hacker
				else {
					if (vk_lost(loadRequest.url.toString(), authentication.get_wall_postponed())) {
						webViewContent.url = authentication.get_wall_postponed()
					}
				}
			}
		}
	}

	RowLayout {
		id: rowLayout

		x: 624
		width: 400
		height: 50
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.top: parent.top

		Button {
			id: communityPostsButton
			text: qsTr("Записи сообщества")
			highlighted: true
			checkable: false
			checked: false
			Layout.fillHeight: true
			Layout.fillWidth: true
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

			onClicked: {
				communityPostsButton.highlighted = true
				scheduledPostsButton.highlighted = false
				loader.sourceComponent = webViewPosts
			}
		}

		Button {
			id: scheduledPostsButton
			text: qsTr("Отложенные записи")
			checkable: false
			Layout.fillWidth: true
			Layout.fillHeight: true
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

			onClicked: {
				communityPostsButton.highlighted = false
				scheduledPostsButton.highlighted = true
				loader.sourceComponent = webViewPostponed
			}
		}
	}
}




/*##^##
Designer {
	D{i:7;anchors_x:518;anchors_y:16}D{i:6;anchors_y:7}
}
##^##*/
