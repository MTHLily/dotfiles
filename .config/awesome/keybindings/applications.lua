local bling = require("bling")
local tbl = require("gears.table")
local awful = require("awful")
local keys = require("keybindings.modkeys")

local scratch = {}
local browser = "firefox"
local terminal = "alacritty"
local filemanager = "thunar"
local mediaplayer = "spotify"

scratch.calculator = bling.module.scratchpad {
    command = "qalculate-gtk",
    rule = {instance = "qalculate-gtk"},
    sticky = false,
    autoclose = true,
    floating = true,
    geometry = {x = 360, y = 90, height = 900, width = 1200},
    reapply = true,
    dont_focus_before_close = false
}

scratch.goldendict = bling.module.scratchpad {
    command = "goldendict $(xclip -o primary)",
    rule = {instance = "qalculate-gtk"},
    sticky = false,
    autoclose = true,
    floating = true,
    geometry = {x = 360, y = 90, height = 900, width = 1200},
    reapply = true,
    dont_focus_before_close = false
}

local launchers = tbl.join({}, awful.key({keys.meta}, "o", function()
    awful.spawn.with_shell("$HOME/.config/rofi/scripts/launcher.sh")
end, {description = "launcher", group = "applications/launcher"}),
    awful.key({keys.meta}, "e", function()
        awful.spawn.with_shell("$HOME/.config/rofi/scripts/app-launcher.sh")
    end, {description = "shortcuts", group = "applications/launcher"}))

local scratchkeys = tbl.join({},
    awful.key({keys.meta}, "[", function() scratch.calculator:toggle() end,
        {description = "Calculator", group = "applications/scratch"}),
    awful.key({keys.meta}, "]", function() scratch.goldendict:toggle() end,
        {description = "Dictionary", group = "applications/scratch"}))

local applications = tbl.join({},
    awful.key({keys.meta}, "w", function() awful.util.spawn(browser) end,
        {description = "Firefox", group = "applications"}),
    awful.key({keys.meta, keys.shift}, "Return",
        function() awful.util.spawn(filemanager) end,
        {description = "File Manager", group = "applications"}),
    awful.key({keys.ctrl, keys.alt}, "c",
        function() awful.util.spawn("catfish") end,
        {description = "Catfish", group = "applications"}),
    awful.key({keys.ctrl, keys.alt}, "s",
        function() awful.util.spawn(mediaplayer) end,
        {description = "Spotify", group = "applications"}),
    awful.key({keys.meta}, "Return", function() awful.spawn(terminal) end,
        {description = terminal, group = "applications"}))

return tbl.join(applications, launchers, scratchkeys)
