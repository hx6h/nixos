import QtQuick
import QtQuick.Controls
import "." as Mono

Button {
  id: control
  property int labelPixelSize: 11
  property real labelLetterSpacing: 0
  implicitHeight: 30
  implicitWidth: Math.max(48, contentItem.implicitWidth + 22)

  contentItem: Text {
    text: control.text
    color: Mono.Theme.foreground
    font.pixelSize: control.labelPixelSize
    font.letterSpacing: control.labelLetterSpacing
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    elide: Text.ElideRight
  }

  background: Rectangle {
    radius: 6
    color: control.down ? Mono.Theme.surfaceRaised : Mono.Theme.surface
    border.width: 1
    border.color: control.hovered ? Mono.Theme.accent : Mono.Theme.border
  }
}
