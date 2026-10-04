hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("flameshot")
    hl.exec_cmd("hyprpaper")

    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user start graphical-session.target")

    hl.exec_cmd("firefox")
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 24")
end)

hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3-dark"')
hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')

hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("GTK_THEME", "adw-gtk3-dark")
hl.env("GDK_BACKEND", "wayland")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")

hl.monitor({ output = "eDP-1", disabled = true })
--hl.monitor({ output = "eDP-1", disabled = false })
hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@60",
    position = "auto",
    scale = 1,
})

hl.config({
    general = {
        gaps_in = 6,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border = "#cba6f7",
            inactive_border = "#b4befe",
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },
})

hl.config({
    decoration = {
        rounding = 0,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 10,
            render_power = 2,
            color = "#181825",
        },
        blur = {
            enabled = true,
            size = 6,
            passes = 4,
            new_optimizations = true,
            xray = false,
            vibrancy = 1,
            vibrancy_darkness = 0.60,
        },
    },
})

hl.config({
    dwindle = {
        preserve_split = true,
    },
})

hl.config({
    master = {
        new_status = "master",
    },
})

hl.config({
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = true,
    },
})

hl.config({
    input = {
        kb_layout = "cz",
        follow_mouse = 1,
        sensitivity = -1,
        --sensitivity = 0.5,
        kb_options = "caps:backspace",
        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.curve("snap", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("bounce", { type = "bezier", points = { { 0.35, 1.15 }, { 0.65, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 15, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "quick" })
hl.animation({ leaf = "windows", enabled = true, speed = 6, bezier = "bounce" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 5, bezier = "bounce" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 6.5, bezier = "bounce" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 0.5, bezier = "quick" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 0.4, bezier = "quick" })
hl.animation({ leaf = "fade", enabled = true, speed = 1.0, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 4, bezier = "snap" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3.5, bezier = "snap", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 3.5, bezier = "snap", style = "slide" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 0.3, bezier = "quick" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 0.2, bezier = "quick" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5.5, bezier = "bounce", style = "slide" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 5.5, bezier = "bounce", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 4, bezier = "quick", style = "slide" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 10, bezier = "quick" })

hl.window_rule({
    match = { class = "yazi" },
    opacity = 0.6,
})

hl.window_rule({
    match = { class = "zeditor" },
    opacity = 0.90,
})

hl.window_rule({
    match = { class = "kitty" },
    opacity = 0.7,
})

hl.window_rule({
    match = { class = "file_chooser" },
    float = true,
    center = true,
    size = "900 600",
})

hl.window_rule({
    match = { class = "hyprland-share-picker" },
    float = true,
    center = true,
})

local mainMod = "SUPER"
local terminal = "kitty"
local fileManager = "kitty -e yazi"
local menu = "rofi -show drun"
local code = "zeditor"
local browser = "librewolf"
local mc = "prismlauncher"

hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd("wlogout -b 2 -c 80 -r 80"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("flameshot gui"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(code))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(mc))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("kitty -e moviebox-tui"))

hl.bind("SUPER + V", function()
    hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
end)

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

local workspaceKeys = {
    { key = "plus", ws = "1" },
    { key = "ecaron", ws = "2" },
    { key = "scaron", ws = "3" },
    { key = "ccaron", ws = "4" },
    { key = "rcaron", ws = "5" },
    { key = "zcaron", ws = "6" },
    { key = "eacute", ws = "7" },
    { key = "uacute", ws = "8" },
    { key = "oacute", ws = "9" },
}

for _, w in ipairs(workspaceKeys) do
    hl.bind(mainMod .. " + " .. w.key, hl.dsp.focus({ workspace = w.ws }))
    hl.bind(mainMod .. " + SHIFT + " .. w.key, hl.dsp.window.move({ workspace = w.ws }))
end

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
