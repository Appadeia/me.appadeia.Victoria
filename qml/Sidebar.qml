import QtQuick 2.0
import QtQuick.Controls 2.5

Rectangle {
    id: root
    property string fontName
    property string iconFontName
    property int currentIndex
    property alias model: sidebarView.model
    property var iconUrls
    signal indexChanged(int index)
    signal deleted(int index)

    width: 64
    color: Qt.rgba(255,255,255,0.05)

    Rectangle {
        id: homeBtn
        height: 64
        width: 64
        color: root.currentIndex === 0 ? Qt.rgba(255,255,255,0.2) : Qt.rgba(255,255,255,0.1);
        Label {
            font.family: iconFontName
            text: ""
            font.pointSize: 20
            color: "white"
            anchors.centerIn: parent
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.indexChanged(0)
            }
        }
    }
    ListView {
        clip: true
        anchors.top: homeBtn.bottom
        anchors.topMargin: 10
        id: sidebarView
        height: parent.height - homeBtn.height - 10
        width: 64
        spacing: 10
        delegate: Rectangle {
            color: Qt.rgba(255,255,255,0.08)
            width: parent.width
            height: 64
            Label {
                font.family: iconFontName
                text: model["icon"]
                font.pointSize: 20
                color: "white"
                anchors.centerIn: parent
            }
            Image {
                anchors.centerIn: parent
                width: 32
                height: 32
                source: root.iconUrls[model.index]
                Timer {
                    interval: 1000
                    running: true
                    repeat: true
                    onTriggered: {
                        parent.source = ""
                        parent.source = root.iconUrls[model.index]
                    }
                }
            }
            Rectangle {
                width: 4
                height: 64
                color: "white"
                anchors.right: parent.right
                visible: root.currentIndex === model["index"] + 1
            }
            MouseArea {
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                anchors.fill: parent
                onClicked: {
                    if (mouse.button == Qt.RightButton) {
                        root.deleted(model["index"])
                    } else {
                        root.indexChanged(model["index"] + 1)
                    }
                }
            }
        }
    }
}
