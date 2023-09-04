local tbl = require("gears.table")
local awful = require("awful")
local modkeys = require("keybindings.modkeys")

local mouse = tbl.join(awful.button({}, 1, function(c) client.focus = c end),
    awful.button({modkeys.meta}, 1, awful.mouse.client.move),
    -- awful.button({ superkey }, 2, function (c) c:kill() end),
    awful.button({modkeys.meta}, 3, function(c)
        client.focus = c
        awful.mouse.client.resize(c)
        -- awful.mouse.resize(c, nil, {jump_to_corner=true})
    end), -- Super + scroll = Change client opacity
    awful.button({modkeys.meta}, 4, function(c) c.opacity = c.opacity + 0.1 end),
    awful.button({modkeys.meta}, 5, function(c) c.opacity = c.opacity - 0.1 end))

return {clientbuttons = tbl.join(mouse)}

