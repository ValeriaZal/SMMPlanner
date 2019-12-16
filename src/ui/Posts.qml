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

	StackView
	{
		id: stackView

		anchors.top: rowLayout.bottom
		anchors.right: parent.right
		anchors.bottom: parent.bottom
        anchors.left: parent.left

        focus: true
        initialItem: webViewPosts

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
