local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")
local cairo = require("lgi").cairo
local catppuccin = require("colors.catppuccin")

local helpers = require("helpers")

-- Note: This theme does not show image notification icons

-- For antialiasing
-- The real background color is set in the widget_template
beautiful.notification_bg = "#00000000"

local default_icon = ""

-- Custom text icons according to the notification's app_name
-- plus whether the title should be visible or not
-- (This will be removed when notification rules are released)
-- Using icomoon font
local app_config = {
    ['battery'] = {icon = "", title = false, message_align = "center"},
    ['charger'] = {icon = "", title = false, message_align = "center"},
    ['volume'] = {icon = "", title = false, message_align = "center"},
    ['brightness'] = {icon = "", title = false, message_align = "center"},
    ['screenshot'] = {icon = "", title = false, message_align = "center"},
    ['Telegram Desktop'] = {
        icon = "",
        title = true,
        message_align = "center"
    },
    ['night_mode'] = {icon = "", title = false, message_align = "center"},
    ['NetworkManager Applet'] = {
        icon = "",
        title = true,
        message_align = "center"
    },
    ['NetworkManager'] = {icon = "", title = true, message_align = "center"},
    ['youtube'] = {icon = "", title = true, message_align = "center"},
    ['mpd'] = {icon = "", title = true, message_align = "center"},
    ['mpv'] = {icon = "", title = true, message_align = "center"},
    ['keyboard'] = {icon = "", title = false, message_align = "center"},
    ['email'] = {icon = "", title = true, message_align = "center"},
    ['Mailspring'] = {icon = "", title = true, message_align = "left"},
    ['layout'] = {icon = "󰕮", title = true, message_align = "center"},
    ['discord'] = {
        icon = "󰙯",
        title = true,
        message_align = "left",
        image_width = dpi(75),
        icon_color = catppuccin.blue
    },
    ['spotify'] = {
        icon = "",
        title = true,
        message_align = "center",
        image_width = dpi(75),
        icon_color = catppuccin.green
    }
}

local urgency_color = {
    ['low'] = x.color2,
    ['normal'] = x.color4,
    ['critical'] = x.color11
}

-- Template
-- ===================================================================
naughty.connect_signal("request::display", function(n)
    -- Custom icon widget
    -- It can be used instead of naughty.widget.icon if you prefer your icon to be
    -- a textbox instead of an image. However, you have to determine its
    -- text/markup value from the notification before creating the
    -- naughty.layout.box.

    local custom_left_widget = nil
    local custom_right_widget = nil
    local custom_notification_icon = wibox.widget {
        font = "icomoon 18",
        -- font = "icomoon bold 40",
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox
    }

    local icon, title_visible, message_align, image_width
    local color = urgency_color[n.urgency]
    -- Set icon according to app_name
    icon = app_config[n.app_name].icon or default_icon
    title_visible = app_config[n.app_name].title or false
    message_align = app_config[n.app_name].message_align or "center"
    image_width = app_config[n.app_name].image_width or dpi(50)

    if n.app_name == "discord" or n.app_name == "spotify" then
        local bg_w, bg_h = gears.surface.get_size(n.image)
        helpers.log({type = "SIZE", bg_w = bg_w, bg_h = bg_h, image = n.image})
        custom_left_widget = function(_)
            return {
                {
                    {
                        markup = helpers.colorize_text(icon, color),
                        align = "center",
                        valign = "center",
                        widget = custom_notification_icon
                    },
                    bgimage = n.image == nil and nil or
                        helpers.create_background_image {
                            image = n.image,
                            valign = "center",
                            halign = "center",
                            opacity = 0.6
                        },
                    -- opacity = 0.5,
                    widget = wibox.container.background
                },
                forced_width = image_width,
                bg = x.background,
                widget = wibox.container.background
            }
        end
    end

    local actions = wibox.widget {
        notification = n,
        base_layout = wibox.widget {
            spacing = dpi(3),
            layout = wibox.layout.flex.horizontal
        },
        widget_template = {
            {
                {
                    {
                        id = 'text_role',
                        font = beautiful.notification_font,
                        widget = wibox.widget.textbox
                    },
                    left = dpi(6),
                    right = dpi(6),
                    widget = wibox.container.margin
                },
                widget = wibox.container.place
            },
            bg = x.color8 .. "32",
            forced_height = dpi(25),
            forced_width = dpi(70),
            widget = wibox.container.background
        },
        style = {underline_normal = false, underline_selected = true},
        widget = naughty.list.actions
    }

    local left_widget = {
        {
            markup = helpers.colorize_text(icon, color),
            align = "center",
            valign = "center",
            widget = custom_notification_icon
        },
        forced_width = dpi(50),
        bg = x.background,
        widget = wibox.container.background
    }

    local right_widget = {
        {
            {
                align = "center",
                visible = title_visible,
                font = beautiful.notification_font,
                markup = "<b>" .. n.title .. "</b>",
                widget = wibox.widget.textbox
                -- widget = naughty.widget.title,
            },
            {
                align = message_align,
                -- wrap = "char",
                widget = naughty.widget.message
            },
            {
                helpers.vertical_pad(dpi(10)),
                {
                    actions,
                    shape = helpers.rrect(dpi(4)),
                    widget = wibox.container.background
                },
                visible = n.actions and #n.actions > 0,
                layout = wibox.layout.fixed.vertical
            },
            layout = wibox.layout.align.vertical
        },
        margins = beautiful.notification_margin,
        widget = wibox.container.margin
    }

    if custom_left_widget then left_widget = custom_left_widget(left_widget) end
    if custom_right_widget then
        right_widget = custom_right_widget(right_widget)
    end

    naughty.layout.box {
        notification = n,
        type = "notification",
        -- For antialiasing: The real shape is set in widget_template
        shape = gears.shape.rectangle,
        border_width = beautiful.notification_border_width,
        border_color = beautiful.notification_border_color,
        position = beautiful.notification_position,
        widget_template = {
            {
                {
                    left_widget,
                    right_widget,
                    layout = wibox.layout.fixed.horizontal
                },
                strategy = "max",
                width = beautiful.notification_max_width or dpi(350),
                height = beautiful.notification_max_height or dpi(180),
                widget = wibox.container.constraint
            },
            -- Anti-aliasing container
            shape = helpers.rrect(beautiful.notification_border_radius),
            bg = x.color0,
            widget = wibox.container.background
        }
    }
end)

-- naughty.disconnect_signal("request::display",
--     naughty.default_notification_handler)
