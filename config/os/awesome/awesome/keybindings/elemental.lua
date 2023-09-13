local tbl = require("gears.table")
local awful = require("awful")
local helpers = require("helpers")
local modkeys = require("keybindings.modkeys")

local tasklist = tbl.join(awful.button({'Any'}, 1, function(c)
    if c == client.focus then
        c.minimized = true
    else
        -- Without this, the following
        -- :isvisible() makes no sense
        c.minimized = false
        if not c:isvisible() and c.first_tag then c.first_tag:view_only() end
        -- This will also un-minimize
        -- the client, if needed
        client.focus = c
    end
end, {group = "elemental", description = "tasklist"}), -- Middle mouse button closes the window (on release)
    awful.button({'Any'}, 2, nil, function(c) c:kill() end), awful.button(
        {'Any'}, 3, function(c) c.minimized = true end), awful.button({'Any'},
        4, function() awful.client.focus.byidx(-1) end), awful.button({'Any'},
        5, function() awful.client.focus.byidx(1) end), -- Side button up - toggle floating
    awful.button({'Any'}, 9, function(c) c.floating = not c.floating end),
    -- Side button down - toggle ontop
    awful.button({'Any'}, 8, function(c) c.ontop = not c.ontop end))

local taglist = tbl.join(awful.button({}, 1, function(t)
    -- t:view_only()
    helpers.tag_back_and_forth(t.index)
end), awful.button({modkeys.meta}, 1, function(t)
    if client.focus then client.focus:move_to_tag(t) end
end), -- awful.button({ }, 3, awful.tag.viewtoggle),
awful.button({}, 3, function(t)
    if client.focus then client.focus:move_to_tag(t) end
end), awful.button({modkeys.meta}, 3, function(t)
    if client.focus then client.focus:toggle_tag(t) end
end), awful.button({}, 4, function(t) awful.tag.viewprev(t.screen) end),
    awful.button({}, 5, function(t) awful.tag.viewnext(t.screen) end))

local hotkeys_popup = require("awful.hotkeys_popup").widget
local titlebar = tbl.join(helpers.button_with_help({}, 1, function()
    local c = mouse.object_under_pointer()
    client.focus = c
    awful.mouse.client.move(c)
end, {description = "Move client", group = "elemental/titlebar"}), -- Middle button - close
    helpers.button_with_help({}, 2, function()
        local c = mouse.object_under_pointer()
        c:kill()
    end, {description = "Kill client", group = "elemental/titlebar"}), -- Right button - resize
    awful.button({}, 3, function()
        local c = mouse.object_under_pointer()
        client.focus = c
        awful.mouse.client.resize(c)
        -- awful.mouse.resize(c, nil, {jump_to_corner=true})
    end), -- Side button up - toggle floating
    awful.button({}, 9, function()
        local c = mouse.object_under_pointer()
        client.focus = c
        -- awful.placement.centered(c,{honor_padding = true, honor_workarea=true})
        c.floating = not c.floating
    end), -- Side button down - toggle ontop
    awful.button({}, 8, function()
        local c = mouse.object_under_pointer()
        client.focus = c
        c.ontop = not c.ontop
    end))

return {
    tasklist_buttons = tasklist,
    taglist_buttons = taglist,
    titlebar_buttons = titlebar
}
