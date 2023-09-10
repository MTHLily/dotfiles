local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")

local helpers = require("helpers")
local keys = require("keys")

local last_coords = {x = 0, y = 0}

local tag_icons = {
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "󰊫",
    "",
    ""
}

local tag_colors_focused = {
    "#9399b2",
    x.color1,
    x.color3,
    x.color4,
    x.color5,
    x.color6,
    x.color11,
    x.color12,
    x.color10,
    x.color9
}

-- Helper function that updates a taglist item
local update_taglist = function(item, tag, index)
    item.opacity = 1
    item.bg = beautiful.tasklist_bg_normal
    if tag.selected then
        item.bg = beautiful.tasklist_bg_focus
    elseif tag.urgent then
        item.opacity = 0.8
    elseif #tag:clients() > 0 then
        item.opacity = 0.4
    else
        item.opacity = 0.1
    end
end

screen.connect_signal("property::geometry", function()
    for s in screen do
        awful.placement.bottom_right(s.traybox,
            {margins = beautiful.useless_gap * 2})
    end
end)

awful.screen.connect_for_each_screen(function(s)
    -- Create a taglist for every screen
    s.mytaglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = keys.taglist_buttons,
        layout = {
            spacing = 10,
            spacing_widget = {
                color = '#00ff00',
                shape = gears.shape.circle,
                widget = wibox.widget.separator
            },
            layout = wibox.layout.flex.horizontal
        },
        widget_template = {
            {
                {
                    id = "text_icon",
                    text = "",
                    font = beautiful.tasklist_font,
                    halign = "center",
                    valign = "center",
                    widget = wibox.widget.textbox
                },
                {
                    text = "",
                    font = beautiful.tasklist_font,
                    visible = false,
                    halign = "right",
                    valign = "bottom",
                    widget = wibox.widget.textbox
                },
                fill_space = false,
                forced_width = dpi(35),
                layout = wibox.layout.stack
            },
            spacing = 0,
            fg = beautiful.wibar_bg,
            widget = wibox.container.background,
            create_callback = function(self, tag, index, _)
                self:get_children_by_id("text_icon")[1].text = tag_icons[index]
                self.fg = tag_colors_focused[index]
                if index == 1 then
                    self.shape = helpers.prrect(beautiful.wibar_border_radius,
                        true, false, false, true)
                elseif index == 10 then
                    self.shape = helpers.prrect(beautiful.wibar_border_radius,
                        false, true, true, false)
                end
                update_taglist(self, tag, index)
            end,
            update_callback = function(self, tag, index, _)
                update_taglist(self, tag, index)
            end
        }
    }

    -- Create the taglist wibox
    s.wibar = awful.wibar({
        screen = s,
        visible = true,
        ontop = false,
        type = "dock",
        position = "top",
        margins = dpi(beautiful.useless_gap),
        bg = "#00000000"
        -- position = "left",
        -- width = dpi(6),
    })

    s.taglist_container = wibox.widget {
        {s.mytaglist, margins = dpi(0), widget = wibox.container.margin},
        bg = beautiful.wibar_fg,
        forced_width = beautiful.wibar_height * 10,
        shape = helpers.prrect(beautiful.wibar_border_radius, true, true, true,
            true),
        widget = wibox.container.background
    }

    s.wibar_clock = wibox.widget {
        {
            {
                {
                    {
                        text = "",
                        valign = "center",
                        halign = "center",
                        font = beautiful.tasklist_font,
                        widget = wibox.widget.textbox
                    },
                    margins = dpi(8),
                    widget = wibox.container.margin
                },
                fg = beautiful.wibar_fg,
                bg = x.color2,
                widget = wibox.container.background
            },
            {
                {
                    format = '%a %b %d %H:%M',
                    halign = "center",
                    valign = "center",
                    widget = wibox.widget.textclock
                },
                left = dpi(8),
                right = dpi(8),
                widget = wibox.container.margin
            },
            layout = wibox.layout.align.horizontal
        },
        fg = beautiful.wibar_bg,
        bg = beautiful.wibar_fg,
        shape = helpers.prrect(beautiful.wibar_border_radius, true, true, true,
            true),
        widget = wibox.container.background
    }

    s.wibar_container = wibox.widget {
        s.taglist_container,
        nil,
        s.wibar_clock,
        layout = wibox.layout.align.horizontal
    }

    s.wibar:setup{widget = s.wibar_container}
    -- Create a system tray widget
    s.systray = wibox.widget.systray()
    s.systray.base_size = beautiful.systray_icon_size
    -- Create the tray box
    s.traybox = wibox({
        screen = s,
        width = dpi(300),
        height = beautiful.systray_icon_size * beautiful.systray_max_rows +
            (beautiful.systray_icon_spacing * 2 * beautiful.systray_max_rows),
        bg = "#00000000",
        visible = false,
        ontop = true
    })
    s.traybox:setup{
        {
            {
                nil,
                s.systray,
                expand = "none",
                layout = wibox.layout.align.vertical
            },
            margins = dpi(10),
            widget = wibox.container.margin
        },
        bg = beautiful.bg_systray,
        shape = helpers.rrect(beautiful.border_radius),
        widget = wibox.container.background
    }
    awful.placement.bottom_right(s.traybox,
        {margins = beautiful.useless_gap * 2})
    s.traybox:buttons(gears.table.join(awful.button({}, 2, function()
        s.traybox.visible = false
    end)))
end)

awesome.connect_signal("elemental::dismiss",
    function() local s = mouse.screen end)

-- Every bar theme should provide these fuctions
function wibars_toggle()
    local s = awful.screen.focused()
    s.wibar.visible = not s.wibar.visible
end

function tray_resize()
    local systray_cols = math.ceil(awesome.systray() / 2.0)
    for s in screen do
        s.traybox.width = (beautiful.systray_icon_size * systray_cols) +
                              (beautiful.systray_icon_spacing * systray_cols)
        awful.placement.bottom_right(s.traybox,
            {margins = beautiful.useless_gap * 2})
    end
end

function tray_toggle()
    tray_resize()
    for s in screen do
        if s == awful.screen.focused() then
            s.traybox.visible = not s.traybox.visible
            wibox.widget.systray().screen = s
            if s.traybox.visible then
                last_coords = {x = mouse.coords().x, y = mouse.coords().y}
                local coords = helpers.wibox_center_coords(s.traybox)
                mouse.coords {x = coords.x, y = coords.y}
            else
                mouse.coords {x = last_coords.x, y = last_coords.y}
            end
        else
            s.traybox.visible = false
        end
    end
end

awesome.connect_signal("systray::update", function() tray_resize() end)
