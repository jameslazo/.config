-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")


------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
local mainMod = "SUPER"

-- A unified table containing name, resolution width, and scale factor
local mon = {
  { name = "eDP-1", width = 1920, scale = 1.5 }, -- 1920 / 1.5 = 1280 wide in layout space
  { name = "DP-2",  width = 1920, scale = 1.0 }, -- 1920 / 1.0 = 1920 wide in layout space
  { name = "DP-1",  width = 1920, scale = 1.0 }
}

local current_x = 0

for i = 1, #mon do
  local m = mon[i]
  
  ---------------------------------------------------------
  -- 1. Apply monitor layout configurations
  ---------------------------------------------------------
  hl.monitor({
    output   = m.name,
    mode     = "preferred",
    position = current_x .. "x0",
    scale    = "auto",
  })
  
  -- Calculate the position for the NEXT monitor before moving on
  -- Effective width = Physical Width / Scale Factor
  current_x = current_x + (m.width / m.scale)

  ---------------------------------------------------------
  -- 2. Apply workspace rules to monitors
  ---------------------------------------------------------
  local primary_ws  = tostring((i * 2) - 1)
  local secondary_ws = tostring(i * 2)
  
  hl.workspace_rule({ workspace = primary_ws,  monitor = m.name })
  hl.workspace_rule({ workspace = secondary_ws, monitor = m.name })
  
  ---------------------------------------------------------
  -- 3. Windows-like multi-monitor workspace switching
  ---------------------------------------------------------
  hl.bind(mainMod .. " + CONTROL + left",  hl.dsp.focus({ monitor = m.name }))
  hl.bind(mainMod .. " + CONTROL + left",  hl.dsp.focus({ workspace = "r-1" }))
  
  hl.bind(mainMod .. " + CONTROL + right", hl.dsp.focus({ monitor = m.name }))
  hl.bind(mainMod .. " + CONTROL + right", hl.dsp.focus({ workspace = "r+1" }))
  
  ---------------------------------------------------------
  -- 4. End focus on center display
  ---------------------------------------------------------
  if i == #mon then
    hl.bind(mainMod .. " + CONTROL + left",  hl.dsp.focus({ monitor = "DP-2" }))
    hl.bind(mainMod .. " + CONTROL + right", hl.dsp.focus({ monitor = "DP-2" }))
  end
end


-- local mon = { 
--   "eDP-1",
--   "DP-2",
--   "DP-1"
-- }
--
-- hl.monitor({
--   output   = mon[1],
--   mode     = "preferred",
--   position = "0x0",
--   scale    = "auto",
-- })
--
-- hl.monitor({
--   output   = mon[2],
--   mode     = "preferred",
--   position = "1280x0",
--   scale    = "auto",
-- })
--
-- hl.monitor({
--   output   = mon[3],
--   mode     = "preferred",
--   position = "3200x0",
--   scale    = "auto",
-- })
--
-- for i = 1, 6 do
--   -- math.ceil(1/2) = 1, math.ceil(2/2) = 1 -> mon[1] ("eDP-1")
--   -- math.ceil(3/2) = 2, math.ceil(4/2) = 2 -> mon[2] ("DP-2")
--   -- math.ceil(5/2) = 3, math.ceil(6/2) = 3 -> mon[3] ("DP-1")
--   local target_monitor = mon[math.ceil(i / 2)]
--
--   hl.workspace_rule({ workspace = tostring(i), monitor = target_monitor })
-- end

-- hl.workspace_rule({ workspace = "1", monitor = "eDP-1" })
-- hl.workspace_rule({ workspace = "2", monitor = "eDP-1" })
-- hl.workspace_rule({ workspace = "3", monitor = "DP-2" })
-- hl.workspace_rule({ workspace = "4", monitor = "DP-2" })
-- hl.workspace_rule({ workspace = "5", monitor = "DP-1" })
-- hl.workspace_rule({ workspace = "6", monitor = "DP-1" })

-- hl.workspace({
--   workspace = 1,
--   monitor = "eDP-1"
-- })


---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "kitty"
local fileManager = "yazi"
local menu        = "wofi --show drun"
local browser     = "qutebrowser"

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function () 
--  hl.exec_cmd(terminal)
--  hl.exec_cmd("nm-applet")
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd("waybar & hyprpaper & hypridle & fcitx5")
  hl.exec_cmd("[workspace special:kitty silent] kitty $XDG_CONFIG_HOME/hypr/tmux.sh")
  hl.dsp.focus({ workspace = "3" })
  hl.exec_cmd("[workspace 3] qutebrowser")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")


-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 2,
        gaps_out = 5,

        border_size = 2,

        col = {
            active_border   = { colors = {"rgba(00afafdd)", "rgba(292929dd)", "rgba(ff5f00dd)", "rgba(292929dd)"}, angle = 45 },
            inactive_border = { colors = {"rgba(595959dd)", "rgba(595959dd)", "rgba(595959dd)", "rgba(595959dd)"}, angle = 45 }
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 5,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 0.98,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },

        blur = {
            enabled   = true,
            size      = 2,
            passes    = 1,
            vibrancy  = 0.1696,
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
hl.curve("shimmer",        { type = "bezier", points = { {1, 0.27},    {0.40, 0.65} } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "borderangle",   enabled = true,  speed = 10,   bezier = "shimmer" })
hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

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
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
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
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


---------------------
---- KEYBINDINGS ----
---------------------

-- local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind("CONTROL + SHIFT + W", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("pidof wofi || wofi --show drun"))
-- hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
-- hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit"))    -- dwindle only
hl.bind("CONTROL + ALT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind("ALT + B", hl.dsp.exec_cmd("brave --profile-directory=Default"))
hl.bind("ALT + Q", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd("firefox --private-window"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind(mainMod .. " + SPACE", hl.dsp.window.set_prop({ prop = "opacity", value = "0.2"}))
hl.bind(mainMod .. " + SPACE", hl.dsp.window.set_prop({ prop = "opacity", value = "1" }), { release = true })
hl.bind("Print", hl.dsp.exec_cmd("grim"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind("CONTROL + Print", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind("ALT + Print", hl.dsp.exec_cmd("hyprshot -m window"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + H",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J",  hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + H",  hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mainMod .. " + SHIFT + L",  hl.dsp.focus({ workspace = "r+1" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("kitty"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:kitty" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

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

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

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

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
  name  = "move-hyprland-run",
  match = { class = "hyprland-run" },

  move  = "20 monitor_h-120",
  float = true,
})

hl.window_rule({
  no_blur = true,
  match = { class = "kitty" },
})

hl.window_rule({
  float = true,
  size = "300 500",
  move = "100 100",
  border_size = 0,
  opacity = 0.8,
  match = { class = "org.gnome.Calculator" },
})

hl.window_rule({
  workspace = 1,
  float = true,
  size = "720 400",
  move = "553 272",
  match = { title = "termwidget" },
  animation = "popin",
})


