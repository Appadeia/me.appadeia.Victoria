import QtQuick 2.0
import QtQuick.Controls 2.5

Drawer {
    y: 0
    id: addDrawer
    edge: Qt.RightEdge
    height: window.height
    width: window.width * (1/2)

    function show() {
        addDrawer.open()
    }
    property string rubik
    property string iconFont

    signal serviceAdded(string url, string icon)

    onOpened: {
        nameField.text = ""
        urlField.text = ""
    }

    Column {
        anchors.fill: parent
        spacing: 16
        Label {
            color: "white"
            font.family: rubik
            font.pointSize: 20
            text: qsTr("Add Custom")
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            Label {
                color: "white"
                horizontalAlignment: Text.AlignRight
                font.family: rubik
                font.pointSize: 12
                text: qsTr("Name")
                width: addDrawer.width * (1/4)
                anchors.verticalCenter: parent.verticalCenter
            }
            Rectangle {
                color: "transparent"
                height: 8
                width: 8
            }
            TextField {
                id: nameField
                width: addDrawer.width * (2/3)

            }
        }
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            Label {
                color: "white"
                font.family: rubik
                font.pointSize: 12
                horizontalAlignment: Text.AlignRight
                text: qsTr("URL")
                width: addDrawer.width * (1/4)
                anchors.verticalCenter: parent.verticalCenter
            }
            Rectangle {
                color: "transparent"
                height: 8
                width: 8
            }
            TextField {
                id: urlField
                width: addDrawer.width * (2/3)
                validator: RegExpValidator {
                    regExp: /^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/g
                }
            }
        }
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            Rectangle {
                color: "transparent"
                height: 8
                width: addDrawer.width * (1/4)
            }
            Rectangle {
                color: "transparent"
                height: 8
                width: 8
            }
            Label {
                color: "#f36c60"
                font.family: rubik
                text: qsTr("That is not a valid URL!")
                visible: !urlField.acceptableInput
            }
        }
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            Label {
                color: "white"
                font.family: rubik
                font.pointSize: 12
                horizontalAlignment: Text.AlignRight
                text: qsTr("Icon")
                width: addDrawer.width * (1/4)
                anchors.verticalCenter: parent.verticalCenter
            }
            Rectangle {
                color: "transparent"
                height: 8
                width: 8
            }
            ComboBox {
                font.family: iconFont
                id: iconCombo
                width: addDrawer.width * (2/3)
                model: ["", "", "", "", ""]
            }
        }
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            enabled: urlField.acceptableInput;
            text: qsTr("Add")
            onClicked: {
                addDrawer.serviceAdded(urlField.text,iconCombo.currentText);
            }
        }
    }
}
