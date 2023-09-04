local awful = require("awful")
local tbl = require("gears.table")
local modkeys = require("keybindings.modkeys")
local lain = require("lain")
local helpers = require("helpers")

local hotkeys_popup = require("awful.hotkeys_popup").widget
local cycle_layout = require("noodle.cycle_layout")

local navigation = tbl.join({}, -- Navigate by Index
awful.key({modkeys.alt}, "j", function() awful.client.focus.byidx(1) end,
    {description = "focus by ind", group = "awesome/navigation"}),
    awful.key({modkeys.alt}, "k", function() awful.client.focus.byidx(-1) end,
        {description = "focus by ind", group = "awesome/navigation"}),
    -- Navigate by Direction (hjkl)
    awful.key({modkeys.meta}, "j", function()
        awful.client.focus.global_bydirection("down")
        if client.focus then client.focus:raise() end
    end, {description = "focus by direction", group = "awesome/navigation"}),
    awful.key({modkeys.meta}, "k", function()
        awful.client.focus.global_bydirection("up")
        if client.focus then client.focus:raise() end
    end, {description = "focus by direction", group = "awesome/navigation"}),
    awful.key({modkeys.meta}, "h", function()
        awful.client.focus.global_bydirection("left")
        if client.focus then client.focus:raise() end
    end, {description = "focus by direction", group = "awesome/navigation"}),
    awful.key({modkeys.meta}, "l", function()
        awful.client.focus.global_bydirection("right")
        if client.focus then client.focus:raise() end
    end, {description = "focus by direction", group = "awesome/navigation"}),
    -- Navigate by Direction (Arrows)
    awful.key({modkeys.meta}, "Down", function()
        awful.client.focus.global_bydirection("down")
        if client.focus then client.focus:raise() end
    end, {description = "focus by arrows", group = "awesome/navigation"}),
    awful.key({modkeys.meta}, "Up", function()
        awful.client.focus.global_bydirection("up")
        if client.focus then client.focus:raise() end
    end, {description = "focus by arrows", group = "awesome/navigation"}),
    awful.key({modkeys.meta}, "Left", function()
        awful.client.focus.global_bydirection("left")
        if client.focus then client.focus:raise() end
    end, {description = "focus by arrows", group = "awesome/navigation"}),
    awful.key({modkeys.meta}, "Right", function()
        awful.client.focus.global_bydirection("right")
        if client.focus then client.focus:raise() end
    end, {description = "focus by arrows", group = "awesome/navigation"}),
    -- Navigate Screens
    awful.key({modkeys.meta}, "u",
        function() awful.screen.focus_relative(1) end,
        {description = "screen focus", group = "awesome/navigation"}),
    awful.key({modkeys.meta}, "d",
        function() awful.screen.focus_relative(-1) end,
        {description = "screen focus", group = "awesome/navigation"}))

local client = tbl.join({}, awful.key({modkeys.meta}, "t", function()
    awful.client.ontop = not awful.client.ontop
end, {description = "pin to top", group = "awesome/client"}),
    awful.key({modkeys.meta}, "n", function(c) c.minimized = true end,
        {description = "minimize client", group = "awesome/client"}),
    awful.key({modkeys.meta, modkeys.shift}, "n", function()
        local c = awful.client.restore()
        if c then
            client.focus = c
            c:raise()
        end
    end, {description = "restore minimized client", group = "awesome/client"}),
    awful.key({modkeys.meta, modkeys.shift}, "j",
        function() awful.client.swap.byidx(1) end, {
            description = "move client by ind",
            group = "awesome/client"
        }), awful.key({modkeys.meta, modkeys.shift}, "k",
        function() awful.client.swap.byidx(-1) end, {
            description = "move client by ind",
            group = "awesome/client"
        }), awful.key({modkeys.meta, "Shift"}, "u", function()
        client.focus:move_to_screen(client.focus.screen.index + 1)
    end, {description = "move client screen", group = "awesome/client"}),
    awful.key({modkeys.meta, "Shift"}, "d", function()
        client.focus:move_to_screen(client.focus.screen.index - 1)
    end, {description = "move client screen", group = "awesome/client"}),
    awful.key({modkeys.meta}, "`", awful.client.urgent.jumpto,
        {description = "jump to urgent client", group = "awesome/client"}))

local layout = tbl.join({},
    awful.key({modkeys.meta}, "space", function() cycle_layout() end,
        {description = "select next", group = "awesome/layout"}),
    awful.key({modkeys.alt, modkeys.shift}, "l",
        function() awful.tag.incmwfact(0.05) end, {
            description = "increase master width factor",
            group = "awesome/layout"
        }), awful.key({modkeys.alt, modkeys.shift}, "h",
        function() awful.tag.incmwfact(-0.05) end, {
            description = "decrease master width factor",
            group = "awesome/layout"
        }), awful.key({modkeys.meta, modkeys.shift}, "h",
        function() awful.tag.incnmaster(1, nil, true) end, {
            description = "increase the number of master clients",
            group = "awesome/layout"
        }), awful.key({modkeys.meta, modkeys.shift}, "l",
        function() awful.tag.incnmaster(-1, nil, true) end, {
            description = "decrease the number of master clients",
            group = "awesome/layout"
        }), awful.key({modkeys.alt, modkeys.shift}, "j",
        function() awful.tag.incncol(1, nil, true) end, {
            description = "increase the number of columns",
            group = "awesome/layout"
        }), awful.key({modkeys.alt, modkeys.shift}, "k",
        function() awful.tag.incncol(-1, nil, true) end, {
            description = "decrease the number of columns",
            group = "awesome/layout"
        }))

local ui = tbl.join({},
    awful.key({modkeys.meta}, "b", function() wibars_toggle() end,
        {description = "toggle wibox", group = "awesome/ui"}), -- Show/Hide Systray
    awful.key({modkeys.meta}, "=", function() tray_toggle() end,
        {description = "toggle tray visibility", group = "awesome/ui"}),
    awful.key({modkeys.meta}, "r", function() sidebar_show() end,
        function() sidebar_hide() end,
        {description = "toggle sidebar", group = "awesome/ui"}),
    awful.key({modkeys.meta}, "F1",
        function() if dashboard_show then dashboard_show() end end,
        {description = "dashboard", group = "awesome/ui"}),
    awful.key({modkeys.meta}, "s", hotkeys_popup.show_help,
        {description = "show help", group = "awesome/ui"}))

local spacing = tbl.join({}, awful.key({modkeys.alt, modkeys.shift}, "u",
    function() lain.util.useless_gaps_resize(1) end, {
        description = "resize useless gaps",
        group = "awesome/spacing"
    }), awful.key({modkeys.alt, modkeys.shift}, "d",
    function() lain.util.useless_gaps_resize(-1) end, {
        description = "resize useless gaps",
        group = "awesome/spacing"
    }))

local tags = tbl.join({},
    awful.key({modkeys.meta, modkeys.alt}, "Left", awful.tag.viewprev,
        {description = "view previous", group = "awesome/tags"}),
    awful.key({modkeys.meta, modkeys.alt}, "Right", awful.tag.viewnext,
        {description = "view next", group = "awesome/tags"}),
    awful.key({modkeys.meta, modkeys.alt}, "h", awful.tag.viewprev,
        {description = "view previous", group = "awesome/tags"}),
    awful.key({modkeys.meta, modkeys.alt}, "l", awful.tag.viewnext,
        {description = "view next", group = "awesome/tags"}),
    awful.key({modkeys.meta}, "Tab",
        function() lain.util.tag_view_nonempty(1) end,
        {description = "view next", group = "awesome/tags"}),
    awful.key({modkeys.meta, "Shift"}, "Tab",
        function() lain.util.tag_view_nonempty(-1) end,
        {description = "view previous", group = "awesome/tags"}))

for i = 1, 10 do
    tags = tbl.join(tags, awful.key({modkeys.meta}, "#" .. i + 9, function()
        helpers.tag_back_and_forth(i)
    end, {description = "view tag #", group = "awesome/tags"}),
        awful.key({modkeys.meta, modkeys.ctrl}, "#" .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then awful.tag.viewtoggle(tag) end
        end, {description = "toggle tag #", group = "awesome/tags"}),
        awful.key({modkeys.meta, modkeys.alt}, "#" .. i + 9, function()
            local tag = client.focus.screen.tags[i]
            local clients = awful.screen.focused().clients
            if tag then
                for _, c in pairs(clients) do c:move_to_tag(tag) end
                tag:view_only()
            end
        end, {
            description = "move all visible clients to tag #",
            group = "awesome/tags"
        }), awful.key({modkeys.meta, modkeys.ctrl, modkeys.shift}, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then client.focus:toggle_tag(tag) end
                end
            end, {
                description = "toggle focused client on tag #",
                group = "awesome/tags"
            }))
end

local clientkeys = tbl.join(awful.key({modkeys.alt, modkeys.shift}, "m",
    lain.util.magnify_client, {description = "magnify client", group = "client"}),
    awful.key({modkeys.meta}, "f", function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end, {description = "toggle fullscreen", group = "client"}),
    awful.key({modkeys.meta, "Shift"}, "q", function(c) c:kill() end,
        {description = "close", group = "hotkeys"}),
    awful.key({modkeys.meta}, "q", function(c) c:kill() end,
        {description = "close", group = "hotkeys"}),
    awful.key({modkeys.meta, "Shift"}, "space", awful.client.floating.toggle,
        {description = "toggle floating", group = "client"}),
    awful.key({modkeys.meta, "Control"}, "Return",
        function(c) c:swap(awful.client.getmaster()) end,
        {description = "move to master", group = "client"}),
    awful.key({modkeys.meta}, "n", function(c) c.minimized = true end,
        {description = "minimize", group = "client"}),
    awful.key({modkeys.meta}, "m", function(c)
        c.maximized = not c.maximized
        c:raise()
    end, {description = "maximize", group = "client"}))

return {
    global = tbl.join(navigation, layout, client, tags, spacing, ui),
    clientkeys = clientkeys
}
