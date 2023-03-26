--[[

     MTHLily AwesomeWM Configuration
     https://github.com/awesomeWM

     Freedesktop : https://github.com/lcpz/awesome-freedesktop
     Based off Multicolor Copycats themes : https://github.com/lcpz/awesome-copycats
     lain : https://github.com/lcpz/lain

--]] -- {{{ Required libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os,
                                                            table, tostring,
                                                            tonumber, type

local gears = require("gears") -- Utilities such as color parsing and objects
local awful = require("awful") -- Everything related to window managment
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local lain = require("lain")
local freedesktop = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility
local xrdb = beautiful.xresources.get_current_theme()
-- Make dpi function global
dpi = beautiful.xresources.apply_dpi
-- Make xresources colors global
x = {
    --           xrdb variable
    background = xrdb.background,
    foreground = xrdb.foreground,
    color0 = xrdb.color0,
    color1 = xrdb.color1,
    color2 = xrdb.color2,
    color3 = xrdb.color3,
    color4 = xrdb.color4,
    color5 = xrdb.color5,
    color6 = xrdb.color6,
    color7 = xrdb.color7,
    color8 = xrdb.color8,
    color9 = xrdb.color9,
    color10 = xrdb.color10,
    color11 = xrdb.color11,
    color12 = xrdb.color12,
    color13 = xrdb.color13,
    color14 = xrdb.color14,
    color15 = xrdb.color15
}

if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        if in_error then return end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        })
        in_error = false
    end)
end

naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title = "Oops, an error happened" ..
            (startup and " during startup!" or "!"),
        message = message
    }
end)

local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format(
                                   "pgrep -u $USER -fx '%s' > /dev/null || (%s)",
                                   cmd, cmd))
    end
end

run_once({"unclutter -root"})

awful.spawn.with_shell(
    'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;' ..
        'xrdb -merge <<< "awesome.started:true";' ..
        -- list each of your autostart commands, followed by ; inside single quotes, followed by ..
        'dex --environment Awesome --autostart --search-paths "$XDG_CONFIG_DIRS/autostart:$XDG_CONFIG_HOME/autostart"' -- https://github.com/jceb/dex
)

require("awful.autofocus")
require("awful.hotkeys_popup.keys")

user = {
    -- >> Default applications <<
    -- Check apps.lua for more
    terminal = "kitty -1",
    floating_terminal = "kitty -1",
    browser = "firefox",
    file_manager = "kitty -1 --class files -e ranger",
    editor = "kitty -1 --class editor -e vim",
    email_client = "kitty -1 --class email -e neomutt",
    music_client = "kitty -o font_size=12 --class music -e ncmpcpp",

    -- >> Web Search <<
    web_search_cmd = "xdg-open https://duckduckgo.com/?q=",
    -- web_search_cmd = "xdg-open https://www.google.com/search?q=",

    -- >> User profile <<
    profile_picture = os.getenv("HOME") .. "/.config/awesome/profile.png",

    -- Directories with fallback values
    dirs = {
        downloads = os.getenv("XDG_DOWNLOAD_DIR") or "~/Downloads",
        documents = os.getenv("XDG_DOCUMENTS_DIR") or "~/Documents",
        music = os.getenv("XDG_MUSIC_DIR") or "~/Music",
        pictures = os.getenv("XDG_PICTURES_DIR") or "~/Pictures",
        videos = os.getenv("XDG_VIDEOS_DIR") or "~/Videos",
        -- Make sure the directory exists so that your screenshots
        -- are not lost
        screenshots = os.getenv("XDG_SCREENSHOTS_DIR") or
            "~/Pictures/Screenshots"
    },

    -- >> Sidebar <<
    sidebar = {hide_on_mouse_leave = true, show_on_mouse_screen_edge = true},

    -- >> Lock screen <<
    -- This password will ONLY be used if you have not installed
    -- https://github.com/RMTT/lua-pam
    -- as described in the README instructions
    -- Leave it empty in order to unlock with just the Enter key.
    -- lock_screen_custom_password = "",
    lock_screen_custom_password = "awesome",

    -- >> Battery <<
    -- You will receive notifications when your battery reaches these
    -- levels.
    battery_threshold_low = 20,
    battery_threshold_critical = 5,

    -- >> Weather <<
    -- Get your key and find your city id at
    -- https://openweathermap.org/
    -- (You will need to make an account!)
    openweathermap_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
    openweathermap_city_id = "yyyyyy",
    -- > Use "metric" for Celcius, "imperial" for Fahrenheit
    weather_units = "metric",

    -- >> Coronavirus <<
    -- Country to check for corona statistics
    -- Uses the https://corona-stats.online API
    coronavirus_country = "germany"
}

-- naughty.config.defaults["icon_size"] = 100
local notifications = require("notifications")
notifications.init("amarena")

local decorations = require("decorations")
decorations.init("ephemeral")

local theme_path = string.format(
                       "%s/.config/awesome/themes/katsushika/theme.lua",
                       os.getenv("HOME"))
beautiful.init(theme_path)

local bling = require("bling")

bling.widget.window_switcher.enable {type = "thumbnail"}

bling.widget.task_preview.enable {
    x = mouse.coords().x, -- The x-coord of the popup
    y = mouse.coords().y,
    height = 200, -- The height of the popup
    width = 300, -- The width of the popup
    placement_fn = function(c) -- Place the widget using awful.placement (this overrides x & y)
        awful.placement.top_right(c, {margins = {top = 40, right = 30}})
    end
}

-- local nice = require("nice")
-- nice {
--     titlebar_color = beautiful.titlebar_bg_normal,
--     titlebar_radius = 0,
--     filterClients = awful.widget.tasklist.filter.alltags,
--     titlebar_font = "Iosevka 12",
--     tooltip_messages = {
--         close = "close",
--         minimize = "minimize",
--         maximize_active = "unmaximize",
--         maximize_inactive = "maximize",
--         floating_active = "tiling mode",
--         floating_inactive = "enable floating mode",
--         ontop_active = "don't keep above other windows",
--         ontop_inactive = "keep above other windows",
--         sticky_active = "disable sticky mode",
--         sticky_inactive = "enable sticky mode"
--     }
-- }

-- modkey or mod4 = super key
local modkey = "Mod4"
local altkey = "Mod1"

local terminal = "alacritty"

-- awesome variables
awful.util.terminal = terminal

awful.util.tagnames = {
    "", "", "", "", "", "", "ﭮ", "", ""
}

awful.layout.suit.tile.left.mirror = true

awful.layout.layouts = {
    awful.layout.suit.tile, awful.layout.suit.floating,
    awful.layout.suit.tile.left, awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top, -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max, -- awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
    -- lain.layout.cascade,
    -- lain.layout.cascade.tile,
    -- lain.layout.centerwork,
    -- lain.layout.centerwork.horizontal,
    -- lain.layout.termfair,
    -- lain.layout.termfair.center,
}

lain.layout.termfair.nmaster = 3
lain.layout.termfair.ncol = 1
lain.layout.termfair.center.nmaster = 3
lain.layout.termfair.center.ncol = 1
lain.layout.cascade.tile.offset_x = dpi(2)
lain.layout.cascade.tile.offset_y = dpi(32)
lain.layout.cascade.tile.extra_padding = dpi(5)
lain.layout.cascade.tile.nmaster = 5
lain.layout.cascade.tile.ncol = 2

awful.util.taglist_buttons = my_table.join(
                                 awful.button({}, 1,
                                              function(t) t:view_only() end),
                                 awful.button({modkey}, 1, function(t)
        if client.focus then client.focus:move_to_tag(t) end
    end), awful.button({}, 3, awful.tag.viewtoggle),
                                 awful.button({modkey}, 3, function(t)
        if client.focus then client.focus:toggle_tag(t) end
    end), awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
                                 awful.button({}, 5, function(t)
        awful.tag.viewprev(t.screen)
    end))

awful.util.tasklist_buttons = my_table.join(
                                  awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            -- c:emit_signal("request::activate", "tasklist", {raise = true})<Paste>

            -- Without this, the following
            -- :isvisible() makes no sense
            c.minimized = false
            if not c:isvisible() and c.first_tag then
                c.first_tag:view_only()
            end
            -- This will also un-minimize
            -- the client, if needed
            client.focus = c
            c:raise()
        end
    end), awful.button({}, 3, function()
        local instance = nil

        return function()
            if instance and instance.wibox.visible then
                instance:hide()
                instance = nil
            else
                instance = awful.menu.clients({theme = {width = dpi(250)}})
            end
        end
    end), awful.button({}, 4, function() awful.client.focus.byidx(1) end),
                                  awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end))

-- }}}

-- {{{ Menu
local myawesomemenu = {
    {"hotkeys", function() return false, hotkeys_popup.show_help end},
    {"arandr", "arandr"}
}

awful.util.mymainmenu = freedesktop.menu.build({
    before = {
        {"Awesome", myawesomemenu} -- { "Atom", "atom" },
        -- other triads can be put here
    },
    after = {
        {"Terminal", terminal}, {"Log out", function() awesome.quit() end},
        {"Sleep", "systemctl suspend"}, {"Restart", "systemctl reboot"},
        {"Shutdown", "systemctl poweroff"} -- other triads can be put here
    }
})
-- hide menu when mouse leaves it
-- awful.util.mymainmenu.wibox:connect_signal("mouse::leave", function() awful.util.mymainmenu:hide() end)

-- menubar.utils.terminal = terminal -- Set the Menubar terminal for applications that require it
-- }}}

-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then wallpaper = wallpaper(s) end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)

-- No borders when rearranging only 1 non-floating or maximized client
screen.connect_signal("arrange", function(s)
    local only_one = #s.tiled_clients == 1
    for _, c in pairs(s.clients) do
        if only_one and not c.floating or c.maximized then
            c.border_width = 2
        else
            c.border_width = beautiful.border_width
        end
    end
end)
-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s)
    beautiful.at_screen_connect(s)
    s.systray = wibox.widget.systray()
    s.systray.visible = true
end)
-- }}}

globalkeys = require("keybindings")

clientkeys = my_table.join(awful.key({altkey, "Shift"}, "m",
                                     lain.util.magnify_client, {
    description = "magnify client",
    group = "client"
}), awful.key({modkey}, "f", function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
end, {description = "toggle fullscreen", group = "client"}),
                           awful.key({modkey, "Shift"}, "q",
                                     function(c) c:kill() end,
                                     {description = "close", group = "hotkeys"}),
                           awful.key({modkey}, "q", function(c) c:kill() end,
                                     {description = "close", group = "hotkeys"}),
                           awful.key({modkey, "Shift"}, "space",
                                     awful.client.floating.toggle, {
    description = "toggle floating",
    group = "client"
}), awful.key({modkey, "Control"}, "Return",
              function(c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
                           awful.key({modkey, "Shift"}, "Left",
                                     function(c) c:move_to_screen() end, {
    description = "move to screen",
    group = "client"
}), awful.key({modkey, "Shift"}, "Right",
              function(c) c:move_to_screen(c.screen.index - 1) end,
              {description = "move to screen", group = "client"}), -- awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
-- {description = "toggle keep on top", group = "client"}),
                           awful.key({modkey}, "n", function(c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
    c.minimized = true
end, {description = "minimize", group = "client"}),
                           awful.key({modkey}, "m", function(c)
    c.maximized = not c.maximized
    c:raise()
end, {description = "maximize", group = "client"}))

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = "view tag #", group = "tag"}
        descr_toggle = {description = "toggle tag #", group = "tag"}
        descr_move = {
            description = "move focused client to tag #",
            group = "tag"
        }
        descr_toggle_focus = {
            description = "toggle focused client on tag #",
            group = "tag"
        }
    end
    globalkeys = my_table.join(globalkeys, -- View tag only.
    awful.key({modkey}, "#" .. i + 9, function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then tag:view_only() end
    end, descr_view), -- Toggle tag display.
    awful.key({modkey, "Control"}, "#" .. i + 9, function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then awful.tag.viewtoggle(tag) end
    end, descr_toggle), -- Move client to tag.
    awful.key({modkey, "Shift"}, "#" .. i + 9, function()
        if client.focus then
            local tag = client.focus.screen.tags[i]
            if tag then
                client.focus:move_to_tag(tag)
                tag:view_only()
            end
        end
    end, descr_move), -- Toggle tag on focused client.
    awful.key({modkey, "Control", "Shift"}, "#" .. i + 9, function()
        if client.focus then
            local tag = client.focus.screen.tags[i]
            if tag then client.focus:toggle_tag(tag) end
        end
    end, descr_toggle_focus))
end

clientbuttons = gears.table.join(awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
end), awful.button({modkey}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.move(c)
end), awful.button({modkey}, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.resize(c)
end))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = require("rules")
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.

client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and not c.size_hints.user_position and
        not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus",
                      function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus",
                      function(c) c.border_color = beautiful.border_normal end)

-- Autostart applications
awful.spawn.with_shell("~/.config/awesome/autostart.sh")
awful.spawn.with_shell("picom -b --config  $HOME/.config/awesome/picom.conf")
