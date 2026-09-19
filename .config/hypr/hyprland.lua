-- Hyprland Lua config, ported from hyprland.conf
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")


------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- laptop
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

-- desktop
hl.monitor({
    output   = "DP-1",
    -- mode     = "3440x1440@280",
    mode     = "3840x2160@240",
    position = "0x0",
    bitdepth = 10,
    -- cm       = "hdr",
    cm       = "srgb",
    scale    = 1,
    sdrbrightness = 0.5,
    sdrsaturation = 1.0,
    sdr_min_luminance = 0.005,
    sdr_max_luminance = 603, -- 603? https://www.reddit.com/r/hyprland/comments/1th3epw/why_you_strugle_with_hdr_and_how_to_fix_it/
})

hl.monitor({
    output    = "DP-2",
    mode      = "2560x1440@144",
    -- position  = "3440x-600",
    position  = "3840x-300",
    scale     = 1,
    transform = 3,
})


---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "alacritty"
local fileManager = "nautilus"
local menu        = "rofi -show drun" -- works on wayland now


-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
    hl.exec_cmd("wl-paste --type text --watch cliphist store")  -- Stores only text data
    hl.exec_cmd("wl-paste --type image --watch cliphist store") -- Stores only image data
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("mako")
    -- https://www.reddit.com/r/hyprland/comments/16rydsu/comment/k27jjok/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
    hl.exec_cmd("wlsunset -l 43.7 -L -79.4 -t 4000 -T 5700") -- lat/long for toronto
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
-- hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
-- hl.env("XDG_SESSION_TYPE", "wayland")
-- hl.env("XDG_SESSION_DESKTOP", "Hyprland")


-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

hl.config({
    ecosystem = {
        -- enforce_permissions = true,
        no_update_news  = true,
        no_donation_nag = true,
    },
})

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,

        border_size = 2,
        -- no_border_on_floating = false,

        -- https://github.com/dracula/hyprland/blob/main/hyprland.conf
        col = {
            active_border         = { colors = { "rgb(44475a)", "rgb(bd93f9)" }, angle = 90 },
            inactive_border       = "rgba(44475aaa)",
            nogroup_border        = "rgba(282a36dd)",
            nogroup_border_active = { colors = { "rgb(bd93f9)", "rgb(44475a)" }, angle = 90 },
        },

        -- WIP nord https://www.nordtheme.com/docs/colors-and-palettes
        -- col = {
        --     active_border   = "rgb(88c0d0)",
        --     inactive_border = "rgb(4c566a)",
        -- },

        -- non-gradient alternative
        -- col = {
        --     active_border   = "rgb(bd93f9)",
        --     inactive_border = "rgba(44475aaa)",
        -- },

        -- darker alternative
        -- col = {
        --     active_border   = "rgb(44475a)", -- or rgb(6272a4)
        --     inactive_border = "rgb(282a36)",
        -- },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = true,

        -- layout = "dwindle",
        layout = "master",
    },

    decoration = {
        rounding       = 0,
        rounding_power = 0,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            -- https://github.com/dracula/hyprland/blob/main/hyprland.conf
            color        = "rgba(1E202966)",
        },

        blur = {
            enabled = false,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 7,    bezier = "quick" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
-- TODO fix this
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "slave",
        mfact      = 0.5,
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        disable_hyprland_logo      = false, -- If true disables the random hyprland logo / anime girl background. :(
        force_default_wallpaper    = 0,     -- Set to 0 or 1 to disable the anime mascot wallpapers
        vrr                        = 0,
        mouse_move_focuses_monitor = false,
        on_focus_under_fullscreen  = 2,
    },
})

-- https://github.com/dracula/hyprland/blob/main/hyprland.conf
hl.config({
    group = {
        groupbar = {
            col = {
                active   = { colors = { "rgb(bd93f9)", "rgb(44475a)" }, angle = 90 },
                inactive = "rgba(282a36dd)",
            },
        },
    },
})

hl.config({
    binds = {
        movefocus_cycles_fullscreen = false,
    },
})

hl.config({
    render = {
        -- direct_scanout = 0,
        direct_scanout = 2,
        cm_auto_hdr = 1,
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "ctrl:nocaps",
        kb_rules   = "",

        follow_mouse               = 2,
        float_switch_override_focus = 0,

        sensitivity   = 0.2, -- -1.0 - 1.0, 0 means no modification.
        accel_profile = "flat",

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.config({
    cursor = {
        no_hardware_cursors = 0,
    },
})

-- See https://wiki.hypr.land/Configuring/Basics/Gestures/
hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
-- hl.device({
--     name        = "epic-mouse-v1",
--     sensitivity = -0.5,
-- })


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- See https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + RETURN",    hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q",         hl.dsp.window.close())
hl.bind(mainMod .. " + W",         hl.dsp.window.close())
hl.bind(mainMod .. " + S",         hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SPACE",     hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P",         hl.dsp.window.pseudo()) -- dwindle
hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SLASH",     hl.dsp.exec_cmd("emacs"))
hl.bind(mainMod .. " + BACKSLASH", hl.dsp.exec_cmd("firefox"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- ... and with vim keys
local vimDirections = { H = "left", L = "right", K = "up", J = "down" }
for key, direction in pairs(vimDirections) do
    hl.bind(mainMod .. " + " .. key,           hl.dsp.focus({ direction = direction }))
    hl.bind(mainMod .. " + SHIFT + " .. key,   hl.dsp.window.move({ direction = direction }))
end

hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.resize({ x = -20, y = 0,   relative = true }))
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.resize({ x = 0,   y = 20,  relative = true }))
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.resize({ x = 0,   y = -20, relative = true }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.resize({ x = 20,  y = 0,   relative = true }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- https://www.reddit.com/r/hyprland/comments/1eh91lu/what_is_the_best_way_to_dynamically_control_bind/lfxts1p/
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("kill $(pidof waybar) || waybar &"))

-- access cliphist history with fuzzel
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"))

-- requires grim and slurp
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp)" -t png - | wl-copy -t image/png'))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("pamixer -i 5"),                   { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("pamixer -d 5"),                   { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("pamixer -t"),                     { locked = true, repeating = true })
-- hl.bind("XF86AudioMicMute",   hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

-- check if window is xwayland
hl.window_rule({
    name  = "xwayland-border-color",
    match = { xwayland = true },

    border_color = "rgb(ff5555)",
})


hl.window_rule({
    name            = "tag-proton-games",
    match           = { class = "^(steam_app_[0-9]+)$" },
    tag             = "+game",
    confine_pointer = true
})

hl.window_rule({
    name            = "tag-native-games",
    match           = { class = "^(dota2|cs2)$" },
    tag             = "+game",
    confine_pointer = true
})


-- main monitor
for i = 1, 6 do
    hl.workspace_rule({
        workspace = tostring(i),
        monitor   = "DP-1",
        default   = (i == 1) or nil,
    })
end

-- vertical monitor
for i = 7, 10 do
    hl.workspace_rule({
        workspace   = tostring(i),
        monitor     = "DP-2",
        -- NOTE: the .conf had `defualt:true` here (typo), so this never took effect.
        default     = (i == 7) or nil,
        layout_opts = { orientation = "top" },
    })
end
