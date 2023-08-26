local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local helpers = require("helpers")
local apps = require("apps")
local icons = require("icons")
local config = require("config")

local keygrabber = require("awful.keygrabber")

-- Appearance
local box_radius = beautiful.dashboard_box_border_radius or dpi(12)
local box_gap = dpi(6)

-- Get screen geometry
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height

local fulocal
function create_boxed_widget(widget_to_be_boxed, bg_color)
    local box_container = wibox.container.background()
    box_container.bg = bg_color
    box_container.shape = helpers.rrect(box_radius)

    local boxed_widget = wibox.widget {
        {
            nil,
            {
                nil,
                widget_to_be_boxed,
                layout = wibox.layout.align.vertical,
                expand = "none"
            },
            layout = wibox.layout.align.horizontal,
            expand = "none"
        },
        widget = box_container
    }

    return boxed_widget
end

-- Create the widget

local gridbox = wibox.widget {
    homogeneous = true,
    spacing = dpi(15),
    expand = true,
    forced_num_cols = 32,
    forced_num_rows = 18,
    layout = wibox.layout.grid
}

local desktop = wibox({
    widget = {gridbox, bg = "#0F00", widget = wibox.container.background},
    visible = false,
    width = dpi(1520),
    height = dpi(855),
    type = "dock",
    bg = "#000000",
    screen = screen.primary
})
desktop.bg = "#00000000"
awful.placement.centered(desktop)

local hakunon_box = gears.surface.load(config.locations.hakunon_box)

local calendar = wibox.widget.calendar.month(os.date("*t"))
calendar.font = "sans medium 10"
local calendar_widget = create_boxed_widget(calendar, x.foreground)
local search_widget = create_boxed_widget(wibox.widget {
    text = "Searchbox",
    widget = wibox.widget.textbox
}, x.foreground)
local hakunon_widget = wibox.widget {
    bgimage = helpers.create_background_image {
        image = hakunon_box,
        halign = 0.7
    },
    widget = wibox.widget.background
}
local ram_widget = create_boxed_widget(wibox.widget {
    text = "ram_widget",
    widget = wibox.widget.textbox
}, x.foreground)
local hdd_widget = create_boxed_widget(wibox.widget {
    text = "hdd_widget",
    widget = wibox.widget.textbox
}, x.foreground)
local shortcuts_widget = create_boxed_widget(wibox.widget {
    text = "shortcuts_widget",
    widget = wibox.widget.textbox
}, x.foreground)
local weather_widget = create_boxed_widget(wibox.widget {
    text = "weather_widget",
    widget = wibox.widget.textbox
}, x.foreground)

gridbox:add_widget_at(search_widget, 1, 1, 2, 11)
gridbox:add_widget_at(calendar_widget, 3, 1, 4, 5)
gridbox:add_widget_at(ram_widget, 13, 14, 6, 5)
gridbox:add_widget_at(hdd_widget, 13, 19, 6, 5)
gridbox:add_widget_at(hakunon_widget, 10, 1, 9, 7)
-- gridbox:add_widget_at(hakunon_widget, 8, 1, 4, 3)
-- desktop:add_widget_at(third, 2, 3, 2, 1)
-- desktop:add_widget_at(fourth, 4, 1, 1, 1)
-- desktop:add_widget_at(fifth, 4, 2, 1, 2)
-- p
