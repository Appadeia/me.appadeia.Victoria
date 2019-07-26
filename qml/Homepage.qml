import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.13

Rectangle {
    id: root
    clip: true
    color: Qt.rgba(255,255,255,0.02);
    signal serviceAdded()
    Column {
        spacing: 10
        anchors.horizontalCenter: parent.horizontalCenter
        Label {
            font.pointSize: 20
            font.family: "Rubik"
            font.bold: true
            text: qsTr("Welcome to Victoria!")
            color: "white"
        }
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Add Service")
            onClicked: {
                root.serviceAdded()
            }
        }
    }
}
