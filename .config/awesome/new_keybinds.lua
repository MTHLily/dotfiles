local awful = require("awful")
local naughty = require("naughty")
local gears = require("gears")
local apps = require("apps")
local decorations = require("decorations")

local helpers = require("helpers")
local lain = require("lain")

local keys = {}

-- Mod keys
Superkey = "Mod4"
Altkey = "Mod1"
Ctrlkey = "Control"
Shiftkey = "Shift"

local scratch_calc = bling.module.scratchpad {
    command = "qalculate-gtk",
    rule = {instance = "qalculate-gtk"},
    sticky = false,
    autoclose = true,
    floating = true,
    geometry = {x = 360, y = 90, height = 900, width = 1200},
    reapply = true,
    dont_focus_before_close = false
}

local scratch_dict = bling.module.scratchpad {
    command = "goldendict $(xclip -o primary)",
    rule = {instance = "qalculate-gtk"},
    sticky = false,
    autoclose = true,
    floating = true,
    geometry = {x = 360, y = 90, height = 900, width = 1200},
    reapply = true,
    dont_focus_before_close = false
}

local applications = {
    awful.key({config.keys.modkey}, "[", function() scratch_calc:toggle() end,
        {description = "Calculator", group = "Applications"}),
    awful.key({config.keys.modkey}, "]", function() scratch_dict:toggle() end,
        {description = "Dictionary", group = "Applications"}),
    awful.key({config.keys.modkey}, "w",
        function() awful.util.spawn(config.apps.browser1) end,
        {description = "Browser", group = "Applications"})
}

local system = {
    awful.key({config.keys.modkey}, "o", function()
        awful.spawn.with_shell("$HOME/.config/rofi/scripts/launcher_t7")
    end, {description = "Launcher", group = "System"}),
    awful.key({config.keys.modkey}, "p", function()
        awful.spawn.with_shell("$HOME/.config/rofi/scripts/screenselector.sh")
    end, {description = "Screen Settings", group = "System"}),
    awful.key({config.keys.modkey}, ",",
        function() awful.spawn.with_shell("splatmoji type") end,
        {description = "Emojis", group = "System"}),
    awful.key({config.keys.modkey}, "r",
        function() awful.util.spawn("rofi-theme-selector") end,
        {description = "Rofi Themes", group = "System"}),
    awful.key({config.keys.modkey}, "F1",
        function() if dashboard_show then dashboard_show() end end,
        {description = "Dashboard", group = "System"}),
    awful.key({config.keys.modkey}, "x",
        function() awful.util.spawn("archlinux-logout") end,
        {description = "Power Menu", group = "System"}),
    awful.key({config.keys.modkey}, "Escape",
        function() awful.util.spawn("xkill") end,
        {description = "Kill proces", group = "System"})
}

local globalkeys = gears.table.join(applications)
