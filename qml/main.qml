import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import Qt.labs.settings 1.0
import QtQuick.Layouts 1.13
import QtWebEngine 1.9
import QtQuick.Controls.Material 2.12

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Victoria") + " - " + activeTitle
    color: "#121212"

    property var iconUrls: []
    property string activeTitle: qsTr("Home")

    Material.theme: Material.Dark
    Material.accent: "#bb86fc"
    Material.primary: "#bb86fc"
    Material.background: "#121212"

    Settings {
        id: settings
        property alias x: window.x
        property alias y: window.y
        property alias width: window.width
        property alias height: window.height
        property string dataStorage
    }
    Component.onCompleted: {
      if (settings.dataStorage) {
        siteModel.clear()
        var storemodel = JSON.parse(settings.dataStorage)
        for (var i = 0; i < storemodel.length; ++i) siteModel.append(storemodel[i])
      }
    }
    onClosing: {
        var storemodel = []
        for (var i = 0; i < siteModel.count; ++i)  {
            storemodel.push(siteModel.get(i))
        }
        settings.dataStorage = JSON.stringify(storemodel)
    }
    FontLoader {
        id: rubik
        source: "qrc:/font/Rubik-Regular.ttf"
    }
    FontLoader {
        id: material
        source: "qrc:/font/materialdesignicons-webfont.ttf"
    }
    ListModel {
        id: siteModel
    }
    RowLayout {
        anchors.fill: parent
        spacing: 0
        Sidebar {
            Layout.fillHeight: true;
            fontName: rubik.name;
            iconFontName: material.name;
            model: siteModel;
            currentIndex: stack.currentIndex
            iconUrls: window.iconUrls
            onIndexChanged: {
                stack.currentIndex = index
            }
            onDeleted: {
                siteModel.remove(index)
            }
        }
        StackLayout {
            id: stack
            Layout.fillHeight: true;
            Layout.fillWidth: true;
            currentIndex: 0
            Homepage {
                onServiceAdded: {
                    add.show()
                }
                Timer {
                    interval: 100
                    running: true
                    repeat: true
                    onTriggered: {
                        if (stack.currentIndex === 0) {
                            window.activeTitle = "Home"
                        }
                    }
                }
            }
            Repeater {
                model: siteModel
                delegate: WebEngineView {
                    id: view
                    url: model["siteUrl"]
                    onNewViewRequested: {
                        Qt.openUrlExternally(request.requestedUrl)
                    }
                    Timer {
                        interval: 100
                        running: true
                        repeat: true
                        onTriggered: {
                            window.iconUrls[model.index] = view.icon
                            if (stack.currentIndex === model["index"] + 1) {
                                window.activeTitle = view.title
                            }
                        }
                    }
                }
            }
        }
    }
    ServiceData { id: servicesModel }
    Rectangle {
        visible: false
        id: add
        anchors.fill: parent
        color: Qt.rgba(0,0,0,0.5);
        MouseArea {
            anchors.fill: parent
            onClicked: {
                add.hide()
            }
        }
        function show() {
            add.visible = true
        }
        function hide() {
            add.visible = false
        }
        Rectangle {
            width: 512
            height: window.height
            color: "#161616"
            anchors.horizontalCenter: parent.horizontalCenter
            MouseArea {
                anchors.fill: parent
            }
            ScrollView {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.fill: parent
                contentWidth: column.width
                contentHeight: column.height
                Column {
                    id: column
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 512
                    spacing: 10
                    Label {
                        color: "white"
                        font.family: rubik.name
                        font.pointSize: 20
                        text: qsTr("Add A Service...")
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Service {
                        name: qsTr("Add Custom...")
                        onAdded: {
                            addDrawer.show()
                        }
                    }
                    Repeater {
                        model: servicesModel
                        delegate: Service {
                            name: model["name"]
                            onAdded: {
                                siteModel.append({"siteUrl":model["url"],"icon":model["icon"]})
                                add.hide()
                            }
                        }
                    }
                }
            }
        }
    }
    AddDrawer {
        id: addDrawer
        rubik: rubik.name
        iconFont: material.name
        interactive: true
        onServiceAdded: {
            siteModel.append({"siteUrl":url,"icon":icon})
            addDrawer.close()
        }
    }
}
