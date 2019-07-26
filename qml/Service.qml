import QtQuick 2.0

Rectangle {
    id: root
    signal added()
    property alias name: serviceLabel.text
    anchors.horizontalCenter: parent.horizontalCenter
    color: maus.containsMouse ? "#2F2F2F" : "#191919"
    width: 384
    height: 64
    border.width: 2
    border.color: "#2A2A2A"
    radius: 14
    Text {
        font.family: "Rubik"
        anchors.centerIn: parent
        id: serviceLabel
        color: "white"
        font.pointSize: 12
    }
    MouseArea {
        id: maus
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            root.added()
        }
    }
}
