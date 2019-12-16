import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls 2.13

import QtWebSockets 1.1
import QtWebEngine 1.4
import QtQuick.Layouts 1.4

ApplicationWindow {
	id: loginWindow

	title: qsTr("SMMPlanner: Log in")
	width: 1440
	height: 900
	color: "#f3f3f4"

	Rectangle {
		id: bottomWindowContainer

		y: 595
		height: 25
		color: "#d0d0d0"
		anchors.right: parent.right
		anchors.left: parent.left
		anchors.bottom: parent.bottom

		Text {
			id: versionText

			width: 123
			anchors.rightMargin: 10
			horizontalAlignment: Text.AlignRight
			verticalAlignment: Text.AlignTop
			anchors.top: parent.top
			anchors.bottom: parent.bottom
			anchors.right: parent.right
			font.pixelSize: 15

			Component.onCompleted: fileReader.getVersion();
		}
	}

	Text {
		id: welcomeText

		x: 404
		width: 632
		height: 70
		text: qsTr("Welcome to SMM Planner!")
		anchors.topMargin: 100
		anchors.horizontalCenterOffset: 0
		verticalAlignment: Text.AlignVCenter
		horizontalAlignment: Text.AlignHCenter
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.top: parent.top
		font.pixelSize: 32
	}

	Rectangle {
		id: webViewContainer

		anchors.top: welcomeText.bottom
		anchors.bottom: bottomWindowContainer.top
		anchors.left: parent.left
		anchors.right: parent.right

		anchors.leftMargin: 6
		anchors.rightMargin: 6
		anchors.topMargin: 6
		anchors.bottomMargin: 6

		WebEngineView {
			anchors.fill: parent
			id: webViewContent

			// Cookies is not permitted for login info
			/*profile: WebEngineProfile {
				httpCacheType: WebEngineProfile.NoCache
				persistentCookiesPolicy: WebEngineProfile.NoPersistentCookies
			}*/

			// Get url
			url: get_first_url(app_id, scope, APIv)

			// Create initial url
			function get_first_url(app_idt, scopet, APIvt) {
				console.log("get_first_url(", app_idt, ", ", scopet, ", ", APIvt, ")")
				var res = "https://oauth.vk.com/authorize?client_id="
						+ app_idt + "&display=page&redirect_uri=https://oauth.vk.com/blank.html&scope="
						+ scopet + "&response_type=token&v=" + APIvt + "&state=123456";
				return res;
			}

			// Check if access token is already found
			function token_found(url_string) {
				var res = url_string.indexOf("access_token");
				if (res === -1) {
					return false;
				}
				console.log("token_found(", url_string, ")")
				console.log("result: true")
				return true;
			}

			// Check if user has changed web site (Hacker test)
			function vk_lost(url_string) {
				var res_auth = url_string.indexOf("https://oauth.vk.com/authorize?client_id=");
				var res_access = url_string.indexOf("https://oauth.vk.com/blank.html#access_token=");
				var res_vk = url_string.indexOf("https://login.vk.com");
				var res_log = url_string.indexOf("login?act=authcheck");
				if ((res_auth === -1) && (res_access === -1) && (res_vk === -1) && (res_log === -1)) {
					console.log("vk_lost(", url_string, ")")
					console.log("result: true")
					return true;
				}
				return false;
			}

			onLoadingChanged: {
				console.log(loadRequest.url)
				// Case: successful log in process
				if (token_found(loadRequest.url.toString())) {
					console.log("authentication.login(loadRequest.url.toString())")
					authentication.login(loadRequest.url.toString())
					console.log("token:", authentication.token)
					loginWindow.close();
				}

				// Case: lost Internet connection
				if (loadRequest.status === WebEngineLoadRequest.LoadFailedStatus) {
					var html = loadRequest.errorString;
					console.log(loadRequest.errorDomain)
					loadHtml(html);
				}

				// Case: user is hacker
				else {
					if (vk_lost(loadRequest.url.toString())) {
						webViewContent.url = get_first_url(app_id, scope, APIv)
					}
				}
			}
		}
	}

	Connections {
		target: fileReader

		onVersion: {
			versionText.text = qsTr("Version " + version)
		}
	}
}

/*##^##
Designer {
	D{i:3;anchors_height:91;anchors_width:632;anchors_x:404;anchors_y:161}
}
##^##*/
