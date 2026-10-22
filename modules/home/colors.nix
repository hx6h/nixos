{ ... }:
let
  # One source of truth for Quickshell and Kitty.
  colors = {
    background = "#101010";
    surface = "#181818";
    surfaceRaised = "#222222";
    border = "#343434";
    foreground = "#f2f2f2";
    muted = "#969696";
    dim = "#666666";
    accent = "#ffffff";
    danger = "#ff6666";
  };
in {
  xdg.configFile."quickshell/dwm_qs-monomodern/Theme.qml".text = ''
    pragma Singleton
    import QtQuick
    QtObject {
      readonly property color background: ${builtins.toJSON colors.background}
      readonly property color surface: ${builtins.toJSON colors.surface}
      readonly property color surfaceRaised: ${builtins.toJSON colors.surfaceRaised}
      readonly property color border: ${builtins.toJSON colors.border}
      readonly property color foreground: ${builtins.toJSON colors.foreground}
      readonly property color muted: ${builtins.toJSON colors.muted}
      readonly property color dim: ${builtins.toJSON colors.dim}
      readonly property color accent: ${builtins.toJSON colors.accent}
      readonly property color danger: ${builtins.toJSON colors.danger}
    }
  '';
  xdg.configFile."quickshell/dwm_qs-monomodern/qmldir".text = ''
    module DwmQsMonoModern
    singleton Theme 1.0 Theme.qml
  '';
  xdg.configFile."kitty/current-theme.conf".text = ''
    foreground ${colors.foreground}
    background ${colors.background}
    selection_foreground ${colors.background}
    selection_background ${colors.foreground}
    cursor ${colors.foreground}
    cursor_text ${colors.background}
    active_border_color ${colors.foreground}
    inactive_border_color ${colors.border}
    color0 #101010
    color1 #d06f6f
    color2 #9b9b9b
    color3 #b5b5b5
    color4 #888888
    color5 #a0a0a0
    color6 #c0c0c0
    color7 #f2f2f2
    color8 #666666
    color9 #e08080
    color10 #b0b0b0
    color11 #c7c7c7
    color12 #a0a0a0
    color13 #b8b8b8
    color14 #d0d0d0
    color15 #ffffff
  '';
}
