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
local singleton = {}

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
        icon_color = catppuccin.green,
        singleton = true
    },
    ['error'] = {icon = '󰋔'}
}

local urgency_color = {
    ['low'] = x.color2,
    ['normal'] = x.color4,
    ['critical'] = x.color1
}

local custom_widgets = {
    left = {
        default = function(args)
            local inner_widget = args.inner_widget or {}
            return function()
                return {
                    inner_widget,
                    forced_width = dpi(50),
                    bg = x.background,
                    widget = wibox.container.background
                }
            end
        end,
        image_bg = function(args)
            local inner_widget = args.inner_widget or {}
            local bgimage = args.bgimage or nil
            local width = args.width or dpi(50)

            return function(_)
                return {
                    {
                        inner_widget,
                        bgimage = bgimage and helpers.create_background_image {
                            image = bgimage,
                            valign = "center",
                            halign = "center",
                            opacity = 0.6
                        } or nil,
                        widget = wibox.container.background
                    },
                    forced_width = width,
                    bg = x.background,
                    widget = wibox.container.background
                }
            end
        end
    },
    right = {
        default = function(args)
            local n = args.n
            local title_visible = args.title_visible ~= nil and
                                      args.title_visible or true
            local message_align = args.message_align or "center"
            local actions = args.actions or nil

            return function()
                return wibox.widget {
                    {
                        {
                            align = "center",
                            visible = title_visible,
                            font = beautiful.notification_font,
                            markup = "<b>" .. n.title .. "</b>",
                            widget = wibox.widget.textbox
                        },
                        {
                            align = message_align,
                            notification = n,
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
            end
        end
    }
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
    local icon, title_visible, message_align, image_width, is_singleton
    local color = urgency_color[n.urgency]
    helpers.log(color, "Urgency")
    -- Set icon according to app_name
    icon = app_config[n.app_name] and app_config[n.app_name].icon or
               default_icon
    title_visible = app_config[n.app_name] and app_config[n.app_name].title or
                        false
    message_align = app_config[n.app_name] and
                        app_config[n.app_name].message_align or "center"
    image_width =
        app_config[n.app_name] and app_config[n.app_name].image_width or dpi(50)
    is_singleton =
        app_config[n.app_name] and app_config[n.app_name].singleton or false

    local centered_icon_widget = {
        markup = helpers.colorize_text(icon, color),
        align = "center",
        valign = "center",
        widget = custom_notification_icon
    }

    if n.app_name == "discord" or n.app_name == "spotify" then
        custom_left_widget = custom_widgets.left.image_bg {
            inner_widget = centered_icon_widget,
            bgimage = n.image,
            width = image_width
        }
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

    local left_widget = custom_left_widget and custom_left_widget() or
                            custom_widgets.left
                                .default {inner_widget = centered_icon_widget}()
    local right_widget = custom_right_widget and custom_right_widget() or
                             custom_widgets.right.default {
            n = n,
            message_align = message_align,
            title_visible = title_visible,
            actions = actions
        }()

    if is_singleton then
        if singleton[n.app_name] then
            if singleton[n.app_name].notification == nil then
                helpers.log("NIL NOTIFICATION")
                singleton[n.app_name].notification = n
            end
            singleton[n.app_name].widget.children = {
                wibox.widget {
                    {
                        left_widget,
                        right_widget,
                        layout = wibox.layout.fixed.horizontal
                    },
                    strategy = "max",
                    width = beautiful.notification_max_width or dpi(350),
                    height = beautiful.notification_max_height or dpi(180),
                    widget = wibox.container.constraint
                }
            }
            singleton[n.app_name].notification.title = n.title
        else
            singleton[n.app_name] = naughty.layout.box {
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
        end
    else
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
    end
end)

-- naughty.disconnect_signal("request::display",
--     naughty.default_notification_handler)
