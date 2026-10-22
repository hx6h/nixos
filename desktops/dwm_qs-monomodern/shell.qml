import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Notifications
import "." as Mono

ShellRoot {
  id: root
  property bool launcherOpen: false
  property bool controlOpen: false
  property bool notificationsOpen: false
  property string searchText: ""

  // Wallpaper runs inside Quickshell instead of spawning swaybg.
  PanelWindow {
    anchors { top: true; left: true; right: true; bottom: true }
    color: Mono.Theme.background
    WlrLayershell.layer: WlrLayer.Background
    WlrLayershell.namespace: "dwm_qs-monomodern-wallpaper"
    exclusiveZone: -1
    Image {
      anchors.fill: parent
      source: "file://" + Quickshell.env("HOME") + "/.config/images/wall2.png"
      fillMode: Image.PreserveAspectCrop
      asynchronous: true
      cache: true
    }
  }

  NotificationServer {
    id: notificationServer
    keepOnReload: true
    onNotification: notification.tracked = true
  }

  PanelWindow {
    anchors { top: true; left: true; right: true }
    implicitHeight: 42
    color: "transparent"
    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.namespace: "dwm_qs-monomodern-bar"

    Rectangle {
      anchors { fill: parent; leftMargin: 8; rightMargin: 8; topMargin: 6; bottomMargin: 4 }
      radius: 8
      color: Mono.Theme.surface
      border.color: Mono.Theme.border
      RowLayout {
        anchors { fill: parent; leftMargin: 12; rightMargin: 12 }
        spacing: 10

        Text {
          Layout.alignment: Qt.AlignVCenter
          text: "HX6H"
          color: Mono.Theme.foreground
          font.bold: true
          font.letterSpacing: 1.2
          font.pixelSize: 12
        }
        Rectangle {
          Layout.alignment: Qt.AlignVCenter
          width: 1
          height: 18
          color: Mono.Theme.border
        }
        Text {
          Layout.alignment: Qt.AlignVCenter
          text: "MONO MODERN"
          color: Mono.Theme.muted
          font.pixelSize: 11
        }
        Item { Layout.fillWidth: true }

        Timer {
          id: clock
          property date now: new Date()
          interval: 30000
          repeat: true
          running: true
          triggeredOnStart: true
          onTriggered: now = new Date()
        }
        Text {
          Layout.alignment: Qt.AlignVCenter
          text: Qt.formatDateTime(clock.now, "ddd dd MMM  ·  HH:mm")
          color: Mono.Theme.foreground
          font.pixelSize: 12
        }
        Button {
          Layout.alignment: Qt.AlignVCenter
          text: "NOTIFY"
          onClicked: root.notificationsOpen = !root.notificationsOpen
          contentItem: Text { text: parent.text; color: Mono.Theme.foreground; font.pixelSize: 10; font.letterSpacing: 0.6; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
          background: Rectangle { radius: 5; color: parent.down ? Mono.Theme.surfaceRaised : "transparent"; border.color: Mono.Theme.border }
        }
        Button {
          Layout.alignment: Qt.AlignVCenter
          text: "CONTROL"
          onClicked: root.controlOpen = !root.controlOpen
          contentItem: Text { text: parent.text; color: Mono.Theme.foreground; font.pixelSize: 10; font.letterSpacing: 0.6; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
          background: Rectangle { radius: 5; color: parent.down ? Mono.Theme.surfaceRaised : "transparent"; border.color: Mono.Theme.border }
        }
        Button {
          Layout.alignment: Qt.AlignVCenter
          text: "＋"
          onClicked: root.launcherOpen = !root.launcherOpen
          contentItem: Text { text: parent.text; color: Mono.Theme.foreground; font.pixelSize: 18; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
          background: Rectangle { radius: 5; color: parent.down ? Mono.Theme.surfaceRaised : "transparent"; border.color: Mono.Theme.border }
        }
      }
    }
  }

  // Native .desktop launcher, without a separate Rofi process.
  PanelWindow {
    visible: root.launcherOpen
    anchors { top: true; left: true; right: true; bottom: true }
    color: Qt.rgba(Mono.Theme.background.r, Mono.Theme.background.g, Mono.Theme.background.b, 0.78)
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "dwm_qs-monomodern-launcher"
    onVisibleChanged: if (visible) search.forceActiveFocus()
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
    exclusiveZone: -1
    Rectangle {
      width: Math.min(560, parent.width - 32)
      height: Math.min(620, parent.height - 80)
      anchors.centerIn: parent
      radius: 12
      color: Mono.Theme.background
      border.color: Mono.Theme.border
      Column {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 12
        Text { text: "LAUNCHER"; color: Mono.Theme.muted; font.pixelSize: 10; font.bold: true }
        TextField {
          id: search
          placeholderText: "Search applications..."
          color: Mono.Theme.foreground
          placeholderTextColor: Mono.Theme.dim
          onTextChanged: root.searchText = text
          background: Rectangle { radius: 6; color: Mono.Theme.surface; border.color: Mono.Theme.border }
          Keys.onEscapePressed: root.launcherOpen = false
        }
        ListView {
          id: apps
          width: parent.width
          height: parent.height - 48
          clip: true
          model: DesktopEntries.applications.values.filter(entry => entry.name.toLowerCase().includes(root.searchText.toLowerCase()))
          delegate: ItemDelegate {
            required property var modelData
            width: apps.width
            text: modelData.name
            onClicked: { modelData.execute(); root.launcherOpen = false; search.text = ""; }
            contentItem: Text { text: parent.text; color: Mono.Theme.foreground; verticalAlignment: Text.AlignVCenter; elide: Text.ElideRight }
            background: Rectangle { radius: 5; color: parent.highlighted ? Mono.Theme.surfaceRaised : "transparent" }
          }
        }
      }
    }
    Keys.onEscapePressed: root.launcherOpen = false
  }

  // Quickshell itself owns notifications, replacing Mako/SwayNC.
  PanelWindow {
    visible: root.notificationsOpen
    anchors { top: true; right: true; bottom: true }
    implicitWidth: 360
    color: "transparent"
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "dwm_qs-monomodern-notifications"
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
    exclusiveZone: -1
    Rectangle {
      anchors { top: parent.top; right: parent.right; bottom: parent.bottom }
      anchors.margins: 10
      width: parent.width - 20
      radius: 12
      color: Mono.Theme.background
      border.color: Mono.Theme.border
      Column {
        anchors.fill: parent
        anchors.margins: 14
        spacing: 10
        RowLayout {
          width: parent.width
          Text {
            Layout.fillWidth: true
            text: "NOTIFICATIONS"
            color: Mono.Theme.foreground
            font.bold: true
            font.pixelSize: 12
          }
          Mono.MonoButton { text: "×"; onClicked: root.notificationsOpen = false }
        }
        ListView {
          width: parent.width
          height: parent.height - 36
          clip: true
          spacing: 8
          model: notificationServer.trackedNotifications
          delegate: Rectangle {
            required property var modelData
            width: parent.width
            implicitHeight: content.implicitHeight + 20
            radius: 7
            color: Mono.Theme.surface
            border.color: Mono.Theme.border
            Column {
              id: content
              anchors { left: parent.left; right: parent.right; top: parent.top }
              anchors.margins: 10
              spacing: 5
              Text { width: parent.width; text: modelData.appName + " · " + modelData.summary; color: Mono.Theme.foreground; font.bold: true; wrapMode: Text.WordWrap }
              Text { width: parent.width; text: modelData.body; color: Mono.Theme.muted; wrapMode: Text.WordWrap; textFormat: Text.PlainText }
              Mono.MonoButton { text: "Dismiss"; onClicked: modelData.dismiss() }
            }
          }
        }
      }
    }
  }

  // Event-driven controls: no polling daemon and no separate mixer process until clicked.
  PanelWindow {
    visible: root.controlOpen
    anchors { top: true; right: true; bottom: true }
    implicitWidth: 340
    color: "transparent"
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "dwm_qs-monomodern-controls"
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
    exclusiveZone: -1
    Rectangle {
      anchors { top: parent.top; right: parent.right; bottom: parent.bottom }
      anchors.margins: 10
      width: parent.width - 20
      radius: 12
      color: Mono.Theme.background
      border.color: Mono.Theme.border
      Column {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 12
        Text { text: "CONTROL CENTER"; color: Mono.Theme.foreground; font.bold: true; font.pixelSize: 12 }
        Text { text: "Audio"; color: Mono.Theme.muted; font.pixelSize: 11 }
        Row {
          spacing: 8
          Mono.MonoButton { text: "−"; onClicked: volumeDown.running = true }
          Mono.MonoButton { text: "Mute"; onClicked: mute.running = true }
          Mono.MonoButton { text: "+"; onClicked: volumeUp.running = true }
        }
        Text { text: "System"; color: Mono.Theme.muted; font.pixelSize: 11 }
        Mono.MonoButton { text: "Bluetooth"; onClicked: bluetooth.running = true }
        Mono.MonoButton { text: "Network"; onClicked: network.running = true }
        Mono.MonoButton { text: "Audio mixer"; onClicked: mixer.running = true }
        Mono.MonoButton { text: "Lock session"; onClicked: lock.running = true }
        Mono.MonoButton { text: "Close"; onClicked: root.controlOpen = false }
      }
    }
  }

  Process { id: volumeDown; command: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%-"]; onExited: running = false }
  Process { id: volumeUp; command: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%+"]; onExited: running = false }
  Process { id: mute; command: ["wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"]; onExited: running = false }
  Process { id: bluetooth; command: ["kitty", "--title", "Bluetooth", "-e", "bluetui"]; onExited: running = false }
  Process { id: network; command: ["kitty", "--title", "Network", "-e", "nmtui"]; onExited: running = false }
  Process { id: mixer; command: ["kitty", "--title", "Audio", "-e", "wiremix"]; onExited: running = false }
  Process { id: lock; command: ["loginctl", "lock-session"]; onExited: running = false }
}
