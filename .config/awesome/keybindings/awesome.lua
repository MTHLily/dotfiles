local awful = require("awful")
local tbl = require("gears.table")
local keys = require("keybindings.modkeys")
local lain = require("lain")

local hotkeys_popup = require("awful.hotkeys_popup").widget
local cycle_layout = require("noodle.cycle_layout")

local navigation = tbl.join({}, -- Navigate by Index
awful.key({keys.alt}, "j", function() awful.client.focus.byidx(1) end,
    {description = "focus by ind", group = "awesome/navigation"}),
    awful.key({keys.alt}, "k", function() awful.client.focus.byidx(-1) end,
        {description = "focus by ind", group = "awesome/navigation"}),
    -- Navigate by Direction (hjkl)
    awful.key({keys.meta}, "j", function()
        awful.client.focus.global_bydirection("down")
        if client.focus then client.focus:raise() end
    end, {description = "focus by direction", group = "awesome/navigation"}),
    awful.key({keys.meta}, "k", function()
        awful.client.focus.global_bydirection("up")
        if client.focus then client.focus:raise() end
    end, {description = "focus by direction", group = "awesome/navigation"}),
    awful.key({keys.meta}, "h", function()
        awful.client.focus.global_bydirection("left")
        if client.focus then client.focus:raise() end
    end, {description = "focus by direction", group = "awesome/navigation"}),
    awful.key({keys.meta}, "l", function()
        awful.client.focus.global_bydirection("right")
        if client.focus then client.focus:raise() end
    end, {description = "focus by direction", group = "awesome/navigation"}),
    -- Navigate by Direction (Arrows)
    awful.key({keys.meta}, "Down", function()
        awful.client.focus.global_bydirection("down")
        if client.focus then client.focus:raise() end
    end, {description = "focus by arrows", group = "awesome/navigation"}),
    awful.key({keys.meta}, "Up", function()
        awful.client.focus.global_bydirection("up")
        if client.focus then client.focus:raise() end
    end, {description = "focus by arrows", group = "awesome/navigation"}),
    awful.key({keys.meta}, "Left", function()
        awful.client.focus.global_bydirection("left")
        if client.focus then client.focus:raise() end
    end, {description = "focus by arrows", group = "awesome/navigation"}),
    awful.key({keys.meta}, "Right", function()
        awful.client.focus.global_bydirection("right")
        if client.focus then client.focus:raise() end
    end, {description = "focus by arrows", group = "awesome/navigation"}),
    -- Navigate Screens
    awful.key({keys.meta}, "u", function() awful.screen.focus_relative(1) end,
        {description = "screen focus", group = "awesome/navigation"}),
    awful.key({keys.meta}, "d", function() awful.screen.focus_relative(-1) end,
        {description = "screen focus", group = "awesome/navigation"}))

local client = tbl.join({}, awful.key({keys.meta}, "t", function()
    awful.client.ontop = not awful.client.ontop
end, {description = "pin to top", group = "awesome/client"}),
    awful.key({keys.meta}, "n", function(c) c.minimized = true end,
        {description = "minimize client", group = "awesome/client"}),
    awful.key({keys.meta, keys.shift}, "n", function()
        local c = awful.client.restore()
        if c then
            client.focus = c
            c:raise()
        end
    end, {description = "restore minimized client", group = "awesome/client"}),
    awful.key({keys.meta, keys.shift}, "j",
        function() awful.client.swap.byidx(1) end, {
            description = "move client by ind",
            group = "awesome/client"
        }), awful.key({keys.meta, keys.shift}, "k",
        function() awful.client.swap.byidx(-1) end, {
            description = "move client by ind",
            group = "awesome/client"
        }), awful.key({keys.meta, "Shift"}, "u", function()
        client.focus:move_to_screen(client.focus.screen.index + 1)
    end, {description = "move client screen", group = "awesome/client"}),
    awful.key({keys.meta, "Shift"}, "d", function()
        client.focus:move_to_screen(client.focus.screen.index - 1)
    end, {description = "move client screen", group = "awesome/client"}),
    awful.key({keys.meta}, "`", awful.client.urgent.jumpto,
        {description = "jump to urgent client", group = "awesome/client"}))

local layout = tbl.join({},
    awful.key({keys.meta}, "space", function() cycle_layout() end,
        {description = "select next", group = "awesome/layout"}),
    awful.key({keys.alt, keys.shift}, "l",
        function() awful.tag.incmwfact(0.05) end, {
            description = "increase master width factor",
            group = "awesome/layout"
        }), awful.key({keys.alt, keys.shift}, "h",
        function() awful.tag.incmwfact(-0.05) end, {
            description = "decrease master width factor",
            group = "awesome/layout"
        }), awful.key({keys.meta, keys.shift}, "h",
        function() awful.tag.incnmaster(1, nil, true) end, {
            description = "increase the number of master clients",
            group = "awesome/layout"
        }), awful.key({keys.meta, keys.shift}, "l",
        function() awful.tag.incnmaster(-1, nil, true) end, {
            description = "decrease the number of master clients",
            group = "awesome/layout"
        }), awful.key({keys.alt, keys.shift}, "j",
        function() awful.tag.incncol(1, nil, true) end, {
            description = "increase the number of columns",
            group = "awesome/layout"
        }), awful.key({keys.alt, keys.shift}, "k",
        function() awful.tag.incncol(-1, nil, true) end, {
            description = "decrease the number of columns",
            group = "awesome/layout"
        }))

local ui = tbl.join({},
    awful.key({keys.meta}, "b", function() wibars_toggle() end,
        {description = "toggle wibox", group = "awesome/ui"}), -- Show/Hide Systray
    awful.key({keys.meta}, "=", function() tray_toggle() end,
        {description = "toggle tray visibility", group = "awesome/ui"}),
    awful.key({keys.meta}, "r", function() sidebar_show() end,
        function() sidebar_hide() end,
        {description = "toggle sidebar", group = "awesome/ui"}),
    awful.key({keys.meta}, "F1",
        function() if dashboard_show then dashboard_show() end end,
        {description = "dashboard", group = "awesome/ui"}),
    awful.key({keys.meta}, "s", hotkeys_popup.show_help,
        {description = "show help", group = "awesome/ui"}))

local spacing = tbl.join({}, awful.key({keys.alt, keys.shift}, "u", function()
    lain.util.useless_gaps_resize(1)
end, {description = "resize useless gaps", group = "awesome/spacing"}),
    awful.key({keys.alt, keys.shift}, "d",
        function() lain.util.useless_gaps_resize(-1) end, {
            description = "resize useless gaps",
            group = "awesome/spacing"
        }))

local tags = tbl.join({},
    awful.key({keys.meta, keys.alt}, "Left", awful.tag.viewprev,
        {description = "view previous", group = "awesome/tags"}),
    awful.key({keys.meta, keys.alt}, "Right", awful.tag.viewnext,
        {description = "view next", group = "awesome/tags"}),
    awful.key({keys.meta}, "Tab", function() lain.util.tag_view_nonempty(1) end,
        {description = "view next", group = "awesome/tags"}),
    awful.key({keys.meta, "Shift"}, "Tab",
        function() lain.util.tag_view_nonempty(-1) end,
        {description = "view previous", group = "awesome/tags"}))

return tbl.join(navigation, layout, client, tags, spacing, ui)
