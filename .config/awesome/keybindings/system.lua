local awful = require("awful")
local tbl = require("gears.table")
local modkeys = require("keybindings.modkeys")

local system = tbl.join({},
    awful.key({modkeys.meta, modkeys.shift}, "r", awesome.restart,
        {description = "reload awesome", group = "system"}),
    awful.key({modkeys.meta}, "x",
        function() awful.util.spawn("archlinux-logout") end,
        {description = "exit", group = "system"}))

local mouse = tbl.join({},
    awful.key({modkeys.meta}, "Escape",
        function() awful.util.spawn("xkill") end,
        {description = "Kill process", group = "system"}),
    awful.key({modkeys.meta}, "`", function()
        awful.spawn.with_shell("$HOME/.config/local-bin/xprop-dialog")
    end, {description = "Describe xprop", group = "system"}),
    awful.key({modkeys.meta, "Shift"}, "s",
        function() awful.util.spawn("flameshot gui") end,
        {description = "flameshot", group = "screenshots"}),
    awful.key({}, "Print", function() awful.util.spawn("flameshot gui") end,
        {description = "flameshot", group = "screenshots"}))

local input = tbl.join({}, awful.key({modkeys.meta}, ".",
    function()
        awful.spawn.with_shell("$HOME/.config/rofi/scripts/emojiselector.sh")
    end, {description = "emoji keyboard", group = "system"}))

local sound = tbl.join({}, awful.key({modkeys.ctrl, modkeys.alt}, "u",
    function() awful.util.spawn("pavucontrol") end, {
        description = "Audio Control",
        group = "system/sound"
    }), awful.key({}, "XF86AudioPlay",
    function() awful.util.spawn("playerctl play-pause") end,
    {description = "Pause/Play", group = "system/sound"}),
    awful.key({}, "XF86AudioNext",
        function() awful.util.spawn("playerctl next") end,
        {description = "Next", group = "system/sound"}),
    awful.key({}, "XF86AudioPrev",
        function() awful.util.spawn("playerctl previous") end,
        {description = "Previous", group = "system/sound"}),
    awful.key({}, "XF86AudioStop",
        function() awful.util.spawn("playerctl stop") end,
        {description = "Stop", group = "system/sound"}),
    awful.key({}, "XF86AudioRaiseVolume", function()
        awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ +1%")
    end, {description = "Raise Volume", group = "system/sound"}),
    awful.key({}, "XF86AudioLowerVolume", function()
        awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ -1%")
    end, {description = "Lower Volume", group = "system/sound"}))

local screen = tbl.join({}, awful.key({}, "XF86MonBrightnessUp", function()
    os.execute("xbacklight -inc 10")
end, {description = "+10%", group = "system/screen"}),
    awful.key({}, "XF86MonBrightnessDown",
        function() os.execute("xbacklight -dec 10") end,
        {description = "-10%", group = "system/screen"}),
    awful.key({modkeys.meta}, "p", function()
        awful.spawn.with_shell("$HOME/.config/rofi/scripts/screenselector.sh")
    end, {description = "Screen Layout", group = "system/screen"}))

return {global = tbl.join(system, mouse, sound, input, screen)}

