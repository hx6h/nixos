{ ... }:
let
  # Select the active dot theme here. All generated application colors flow
  # from this one palette; switching themes means changing this import only.
  palette = import ../../desktops/dwm_qs-monomodern/colors.nix;
  templates = ../../dots/dwm_qs-monomodern;

  basicTokens = [
    { token = "@BACKGROUND@"; value = palette.background; }
    { token = "@SURFACE@"; value = palette.surface; }
    { token = "@SURFACE_RAISED@"; value = palette.surfaceRaised; }
    { token = "@SURFACE_ALT@"; value = palette.surfaceAlt; }
    { token = "@BORDER@"; value = palette.border; }
    { token = "@FOREGROUND@"; value = palette.foreground; }
    { token = "@MUTED@"; value = palette.muted; }
    { token = "@DIM@"; value = palette.dim; }
    { token = "@ACCENT@"; value = palette.accent; }
    { token = "@URGENT@"; value = palette.urgent; }
    { token = "@SUCCESS@"; value = palette.success; }
    { token = "@WARNING@"; value = palette.warning; }
    { token = "@BACKGROUND_HEX@"; value = "0x${builtins.substring 1 6 palette.background}ff"; }
    { token = "@SURFACE_HEX@"; value = "0x${builtins.substring 1 6 palette.surface}ff"; }
    { token = "@SURFACE_RAISED_HEX@"; value = "0x${builtins.substring 1 6 palette.surfaceRaised}ff"; }
    { token = "@BORDER_HEX@"; value = "0x${builtins.substring 1 6 palette.border}ff"; }
    { token = "@FOREGROUND_HEX@"; value = "0x${builtins.substring 1 6 palette.foreground}ff"; }
    { token = "@MUTED_HEX@"; value = "0x${builtins.substring 1 6 palette.muted}ff"; }
    { token = "@ACCENT_HEX@"; value = "0x${builtins.substring 1 6 palette.accent}ff"; }
    { token = "@URGENT_HEX@"; value = "0x${builtins.substring 1 6 palette.urgent}ff"; }
  ];
  ansiTokens = builtins.genList (i: {
    token = "@ANSI${toString i}@";
    value = builtins.elemAt palette.ansi i;
  }) 16;
  tokens = basicTokens ++ ansiTokens;
  render = file:
    builtins.replaceStrings
      (map (item: item.token) tokens)
      (map (item: item.value) tokens)
      (builtins.readFile (templates + "/${file}"));
in
{
  programs.fetch.labelColor = if palette.name == "catppuccin-mocha" then "magenta" else "white";

  # Quickshell's singleton is the UI palette for every panel and popup.
  xdg.configFile."quickshell/dwm_qs-monomodern/Theme.qml".text = ''
    pragma Singleton
    import QtQuick
    QtObject {
      readonly property string themeName: ${builtins.toJSON palette.name}
      readonly property color background: ${builtins.toJSON palette.background}
      readonly property color surface: ${builtins.toJSON palette.surface}
      readonly property color surfaceRaised: ${builtins.toJSON palette.surfaceRaised}
      readonly property color surfaceAlt: ${builtins.toJSON palette.surfaceAlt}
      readonly property color border: ${builtins.toJSON palette.border}
      readonly property color foreground: ${builtins.toJSON palette.foreground}
      readonly property color muted: ${builtins.toJSON palette.muted}
      readonly property color dim: ${builtins.toJSON palette.dim}
      readonly property color accent: ${builtins.toJSON palette.accent}
      readonly property color urgent: ${builtins.toJSON palette.urgent}
      readonly property color success: ${builtins.toJSON palette.success}
      readonly property color warning: ${builtins.toJSON palette.warning}
    }
  '';

  xdg.configFile."quickshell/dwm_qs-monomodern/qmldir".text = ''
    module DwmQsMonoModern
    singleton Theme 1.0 Theme.qml
    MonoButton 1.0 MonoButton.qml
  '';

  # Templates are rendered at evaluation time, so every application uses the
  # exact same palette without hand-maintained copies of hex values.
  xdg.configFile."kitty/current-theme.conf".text = render "kitty/current-theme.conf";
  xdg.configFile."cava/config".text = render "cava/config";
  xdg.configFile."fastfetch/config.jsonc".text = render "fastfetch/config.jsonc";
  xdg.configFile."waybar/style.css".text = render "waybar/style.css";
  xdg.configFile."rofi/config.rasi".text = render "rofi/config.rasi";
  xdg.configFile."mango/config.conf".text = render "mango/config.conf";
  xdg.configFile."flameshot/flameshot.ini".text = render "flameshot/flameshot.ini";
  xdg.configFile."gtk-3.0/gtk.css".text = render "gtk/gtk.css";
  xdg.configFile."gtk-4.0/gtk.css".text = render "gtk/gtk.css";

  home.file.".oh-my-zsh/themes/hx6h.zsh-theme".text = render "zsh/themes/hx6h.zsh-theme";
}

