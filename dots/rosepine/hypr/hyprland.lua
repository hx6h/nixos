
-- ╭──────────────────────────────────────────────╮
-- │              hyprland_rosepine                │
-- │              Rosé Pine Moon • NixOS           │
-- ╰──────────────────────────────────────────────╯

local terminal = "kitty"
local fileManager = "kitty -e yazi"
local launcher = "rofi -show drun"
local browser = "librewolf"

-- ── Environment ─────────────────────────────────

hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Qt dark theme
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_STYLE_OVERRIDE", "kvantum")

-- GTK dark theme
hl.env("GTK_THEME", "adw-gtk3-dark")
hl.env("GTK_APPLICATION_PREFER_DARK_THEME", "1")

-- Prefer dark mode in supported applications
hl.env("COLOR_SCHEME", "prefer-dark")

-- ── Monitors ────────────────────────────────────

hl.monitor({
    output = "eDP-1",
    disabled = true,
})

hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@60",
    position = "0x0",
    scale = 1,
})

-- ── Appearance ──────────────────────────────────

hl.config({
    general = {
        -- Spacing
        gaps_in = 5,
        gaps_out = 10,

        -- Borders
        border_size = 2,

        col = {
            active_border = {
                colors = {
                    "rgba(c4a7e7ff)",
                    "rgba(eb6f92ff)",
                },
                angle = 45,
            },

            inactive_border = "rgba(393552ff)",
        },

        layout = "dwindle",
        resize_on_border = true,
        allow_tearing = false,
    },

    decoration = {
        -- Rounded corners
        rounding = 8,
        rounding_power = 2,

        -- Opacity
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        fullscreen_opacity = 1.0,

        -- Shadows
        shadow = {
            enabled = true,
            range = 6,
            render_power = 3,
            color = 0x66000000,
            sharp = false,
        },

        -- Blur
        blur = {
            enabled = true,
            size = 6,
            passes = 3,

            ignore_opacity = false,
            new_optimizations = true,
            xray = false,

            noise = 0.0117,
            contrast = 1.15,
            brightness = 0.9,
            vibrancy = 0.15,
            vibrancy_darkness = 0.5,
        },
    },

    input = {
        kb_layout = "cz",
        kb_options = "caps:backspace",

        follow_mouse = 1,
        sensitivity = -0.7,
        accel_profile = "flat",

        touchpad = {
            natural_scroll = true,
        },
    },

    dwindle = {
        preserve_split = true,
        smart_split = true,
    },

    animations = {
        enabled = true,
    },
})

-- ── Animations ──────────────────────────────────

hl.curve("roseEase", {
    type = "bezier",
    points = {
        { 0.16, 1.0 },
        { 0.3, 1.0 },
    },
})

hl.curve("roseSmooth", {
    type = "bezier",
    points = {
        { 0.65, 0.0 },
        { 0.35, 1.0 },
    },
})

hl.animation({
    leaf = "global",
    enabled = true,
    speed = 8,
    bezier = "default",
})

hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 5,
    bezier = "roseEase",
})

hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 4,
    bezier = "roseEase",
    style = "popin 85%",
})

hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 3,
    bezier = "roseSmooth",
    style = "popin 85%",
})

hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 4,
    bezier = "roseSmooth",
})

hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 4,
    bezier = "roseSmooth",
    style = "slide",
})

-- ── Keybindings ─────────────────────────────────

-- Applications

hl.bind("SUPER + Return",
    hl.dsp.exec_cmd(terminal))

hl.bind("SUPER + SPACE",
    hl.dsp.exec_cmd(launcher))

hl.bind("SUPER + E",
    hl.dsp.exec_cmd(fileManager))

hl.bind("SUPER + C",
    hl.dsp.exec_cmd("kitty -e nvim"))

hl.bind("SUPER + SHIFT + Return",
    hl.dsp.exec_cmd(browser))

hl.bind("SUPER + S",
    hl.dsp.exec_cmd("obsidian"))

hl.bind("SUPER + A",
    hl.dsp.exec_cmd("prismlauncher"))

hl.bind("SUPER + SHIFT + S",
    hl.dsp.exec_cmd("flameshot gui"))

-- Window management

hl.bind("SUPER + Q",
    hl.dsp.window.close())

hl.bind("SUPER + F",
    hl.dsp.window.fullscreen({
        action = "toggle",
    }))

hl.bind("SUPER + V",
    hl.dsp.window.float({
        action = "toggle",
    }))

hl.bind("SUPER + P",
    hl.dsp.window.pseudo())

hl.bind("SUPER + SHIFT + F",
    hl.dsp.window.fullscreen({
        action = "toggle",
        mode = "maximized",
    }))

hl.bind("SUPER + W",
    hl.dsp.layout("togglesplit"))

-- Focus

hl.bind("SUPER + Left",
    hl.dsp.focus({ direction = "left" }))

hl.bind("SUPER + Right",
    hl.dsp.focus({ direction = "right" }))

hl.bind("SUPER + Up",
    hl.dsp.focus({ direction = "up" }))

hl.bind("SUPER + Down",
    hl.dsp.focus({ direction = "down" }))

-- Move windows

hl.bind("SUPER + SHIFT + Left",
    hl.dsp.window.move({ direction = "left" }))

hl.bind("SUPER + SHIFT + Right",
    hl.dsp.window.move({ direction = "right" }))

hl.bind("SUPER + SHIFT + Up",
    hl.dsp.window.move({ direction = "up" }))

hl.bind("SUPER + SHIFT + Down",
    hl.dsp.window.move({ direction = "down" }))

-- Workspaces
-- Physical number-row keycodes.
-- Independent of the Czech keyboard layout.

for i = 1, 9 do
    local keycode = tostring(i + 9)

    hl.bind("SUPER + code:" .. keycode,
        hl.dsp.focus({ workspace = i }))

    hl.bind("SUPER + SHIFT + code:" .. keycode,
        hl.dsp.window.move({ workspace = i }))
end

-- Workspace navigation

hl.bind("SUPER + Page_Down",
    hl.dsp.focus({ workspace = "e+1" }))

hl.bind("SUPER + Page_Up",
    hl.dsp.focus({ workspace = "e-1" }))

-- Mouse window movement

hl.bind("SUPER + mouse:272",
    hl.dsp.window.drag(),
    { mouse = true })

hl.bind("SUPER + mouse:273",
    hl.dsp.window.resize(),
    { mouse = true })

-- Reload

hl.bind("SUPER + R",
    hl.dsp.exec_cmd("hyprctl reload"))

-- Exit

hl.bind("SUPER + SHIFT + Escape",
    hl.dsp.exit())

-- ── Audio ───────────────────────────────────────

hl.bind("XF86AudioRaiseVolume",
    hl.dsp.exec_cmd(
        "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"
    ),
    { locked = true, repeating = true })

hl.bind("XF86AudioLowerVolume",
    hl.dsp.exec_cmd(
        "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ),
    { locked = true, repeating = true })

hl.bind("XF86AudioMute",
    hl.dsp.exec_cmd(
        "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ),
    { locked = true })

hl.bind("XF86AudioPlay",
    hl.dsp.exec_cmd("playerctl play-pause"),
    { locked = true })

hl.bind("XF86AudioNext",
    hl.dsp.exec_cmd("playerctl next"),
    { locked = true })

hl.bind("XF86AudioPrev",
    hl.dsp.exec_cmd("playerctl previous"),
    { locked = true })

-- ── Brightness ──────────────────────────────────

hl.bind("XF86MonBrightnessUp",
    hl.dsp.exec_cmd("brightnessctl set 5%+"),
    { locked = true, repeating = true })

hl.bind("XF86MonBrightnessDown",
    hl.dsp.exec_cmd("brightnessctl set 5%-"),
    { locked = true, repeating = true })

-- ── Startup ─────────────────────────────────────

hl.on("hyprland.start", function()
    hl.exec_cmd(
        "swaybg -i /home/larp/.config/images/tomoko-kuroki.jpg -m fill"
    )

    hl.exec_cmd("waybar")
end)
