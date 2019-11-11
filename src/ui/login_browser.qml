import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls 2.13
ApplicationWindow
{
    id: loginWindow

    //title of the application
    title: qsTr("SMMPlanner_test")
    width: 1440
    height: 900
    color: "#f3f3f4"
Rectangle {
    id: main

    property int userId: XXX
    property var friends

    width: 320
    height: 640
    color: 'skyblue'

    function getFriends() {
        var request = new XMLHttpRequest()
        request.open('POST', 'https://api.vk.com/method/friends.get')
        request.onreadystatechange = function() {
            if (request.readyState === XMLHttpRequest.DONE) {
                if (request.status && request.status === 200) {
                    console.log("response", request.responseText)
                    var result = JSON.parse(request.responseText)
                    main.friends = result.response
                } else {
                    console.log("HTTP:", request.status, request.statusText)
                }
            }
        }
        request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
        request.send('fields=photo_medium&uid=%1'.arg(main.userId))
    }

    ListView {
        id: view

        anchors.margins: 10
        anchors.fill: parent
        model: friends
        spacing: 10

        delegate: Rectangle {
            width: view.width
            height: 100
            anchors.horizontalCenter: parent.horizontalCenter
            color: 'white'
            border {
                color: 'lightgray'
                width: 2
            }
            radius: 10

            Row {
                anchors.margins: 10
                anchors.fill: parent
                spacing: 10

                Image {
                    id: image

                    height: parent.height
                    fillMode: Image.PreserveAspectFit
                    source: modelData['photo_medium']
                }

                Text {
                    width: parent.width - image.width - parent.spacing
                    anchors.verticalCenter: parent.verticalCenter
                    elide: Text.ElideRight
                    renderType: Text.NativeRendering
                    text: "%1 %2".arg(modelData['first_name']).arg(modelData['last_name'])
                }
            }
        }
    }

    Component.onCompleted: {
        getFriends()
    }
}

}
