--[[

     Katsushika Awesome WM theme

--]]
local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi
local beautiful = require("beautiful")

local math, string, os = math, string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local kanagawa = {}

kanagawa.fujiWhite = "#DCD7BA"
kanagawa.oldWhite = "#C8C093"
kanagawa.sumiInk0 = "#16161D"
kanagawa.sumiInk1 = "#1F1F28"
kanagawa.sumiInk2 = "#2A2A37"
kanagawa.sumiInk3 = "#363646"
kanagawa.sumiInk4 = "#54546D"
kanagawa.waveBlue1 = "#223249"
kanagawa.waveBlue2 = "#2D4F67"
kanagawa.winterGreen = "#2B3328"
kanagawa.winterYellow = "#49443C"
kanagawa.winterRed = "#43242B"
kanagawa.winterBlue = "#252535"
kanagawa.autumnGreen = "#76946A"
kanagawa.autumnRed = "#C34043"
kanagawa.autumnYellow = "#DCA561"
kanagawa.samuraiRed = "#E82424"
kanagawa.roninYellow = "#FF9E3B"
kanagawa.waveAqua1 = "#6A9589"
kanagawa.dragonBlue = "#658594"
kanagawa.fujiGray = "#727169"
kanagawa.springViolet1 = "#938AA9"
kanagawa.oniViolet = "#957FB8"
kanagawa.crystalBlue = "#7E9CD8"
kanagawa.springViolet2 = "#9CABCA"
kanagawa.springBlue = "#7FB4CA"
kanagawa.lightBlue = "#A3D4D5"
kanagawa.waveAqua2 = "#7AA89F"
kanagawa.springGreen = "#98BB6C"
kanagawa.boatYellow1 = "#938056"
kanagawa.boatYellow2 = "#C0A36E"
kanagawa.carpYellow = "#E6C384"
kanagawa.sakuraPink = "#D27E99"
kanagawa.waveRed = "#E46876"
kanagawa.peachRed = "#FF5D62"
kanagawa.surimiOrange = "#FFA066"
kanagawa.katanaGray = "#717C7C"

local theme = {}
theme.naughty_preset = {}

theme.naughty_preset.normal = {
  bg = kanagawa.sumiInk1,
  fg = kanagawa.fujiWhite
        }

theme.dir = os.getenv("HOME") .. "/.config/awesome/themes/powerarrow"
theme.wallpaper = theme.dir .. "/wallpaper.jpg"
theme.font = "Iosevka 12"
theme.taglist_font = "Iosevka 24"
theme.fg_normal = kanagawa.fujiWhite
theme.fg_color = kanagawa.fujiWhite
theme.fg_focus = kanagawa.oldWhite
theme.fg_urgent = kanagawa.autumnYellow
theme.bg_normal = kanagawa.sumiInk1
theme.bg_focus = kanagawa.sumiInk2
theme.bg_urgent = kanagawa.sumiInk3
theme.taglist_fg_focus = kanagawa.crystalBlue
theme.tasklist_bg_focus = kanagawa.waveRed
theme.tasklist_fg_focus = kanagawa.carpYellow
theme.topline_bg = kanagawa.autumnRed
theme.border_width = dpi(2)
theme.border_normal = kanagawa.oldWhite
theme.border_focus = kanagawa.autumnRed
theme.border_marked = kanagawa.sakuraPink
theme.titlebar_bg_focus = kanagawa.sumiInk1
theme.titlebar_bg_normal = kanagawa.autumnRed
theme.titlebar_bg_focus = theme.bg_focus
theme.titlebar_bg_normal = theme.bg_normal
theme.titlebar_fg_focus = theme.fg_focus
theme.menu_height = dpi(25)
theme.menu_width = dpi(260)
theme.menu_submenu_icon = theme.dir .. "/icons/submenu.png"
theme.awesome_icon = theme.dir .. "/icons/awesome.png"
theme.taglist_squares_sel = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile = theme.dir .. "/icons/tile.png"
theme.layout_tileleft = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv = theme.dir .. "/icons/fairv.png"
theme.layout_fairh = theme.dir .. "/icons/fairh.png"
theme.layout_spiral = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle = theme.dir .. "/icons/dwindle.png"
theme.layout_max = theme.dir .. "/icons/max.png"
theme.layout_fullscreen = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier = theme.dir .. "/icons/magnifier.png"
theme.layout_floating = theme.dir .. "/icons/floating.png"
theme.widget_ac = theme.dir .. "/icons/ac.png"
theme.widget_battery = theme.dir .. "/icons/battery.png"
theme.widget_battery_low = theme.dir .. "/icons/battery_low.png"
theme.widget_battery_empty = theme.dir .. "/icons/battery_empty.png"
theme.widget_mem = theme.dir .. "/icons/mem.png"
theme.widget_cpu = theme.dir .. "/icons/cpu.png"
theme.widget_temp = theme.dir .. "/icons/temp.png"
theme.widget_net = theme.dir .. "/icons/net.png"
theme.widget_hdd = theme.dir .. "/icons/hdd.png"
theme.widget_music = theme.dir .. "/icons/note.png"
theme.widget_music_on = theme.dir .. "/icons/note.png"
theme.widget_music_pause = theme.dir .. "/icons/pause.png"
theme.widget_music_stop = theme.dir .. "/icons/stop.png"
theme.widget_vol = theme.dir .. "/icons/vol.png"
theme.widget_vol_low = theme.dir .. "/icons/vol_low.png"
theme.widget_vol_no = theme.dir .. "/icons/vol_no.png"
theme.widget_vol_mute = theme.dir .. "/icons/vol_mute.png"
theme.widget_mail = theme.dir .. "/icons/mail.png"
theme.widget_mail_on = theme.dir .. "/icons/mail_on.png"
theme.widget_task = theme.dir .. "/icons/task.png"
theme.widget_scissors = theme.dir .. "/icons/scissors.png"
theme.widget_weather = theme.dir .. "/icons/dish.png"
theme.tasklist_plain_task_name = false
theme.tasklist_disable_icon = false
theme.useless_gap = dpi(2)

local markup = lain.util.markup
local separators = lain.util.separators

theme.notification_bg = kanagawa.sumiInk1
theme.notification_border_color = kanagawa.fujiWhite

theme.window_switcher_widget_bg = kanagawa.sumiInk1              -- The bg color of the widget
theme.window_switcher_widget_border_width = dpi(2)            -- The border width of the widget
theme.window_switcher_widget_border_radius = 4           -- The border radius of the widget
theme.window_switcher_widget_border_color = kanagawa.oniViolet    -- The border color of the widget
theme.window_switcher_clients_spacing = 20               -- The space between each client item
theme.window_switcher_client_icon_horizontal_spacing = 5 -- The space between client icon and text
theme.window_switcher_client_width = dpi(300)                 -- The width of one client widget
theme.window_switcher_client_height = 250                -- The height of one client widget
theme.window_switcher_client_margins = 10                -- The margin between the content and the border of the widget
theme.window_switcher_thumbnail_margins = 10             -- The margin between one client thumbnail and the rest of the widget
theme.thumbnail_scale = true                            -- If set to true, the thumbnails fit policy will be set to "fit" instead of "auto"
theme.window_switcher_name_margins = 10                  -- The margin of one clients title to the rest of the widget
theme.window_switcher_name_valign = "center"             -- How to vertically align one clients title
theme.window_switcher_name_forced_width = 200            -- The width of one title
theme.window_switcher_name_font = "iosevka 11"              -- The font of all titles
theme.window_switcher_name_normal_color = kanagawa.oldWhite      -- The color of one title if the client is unfocused
theme.window_switcher_name_focus_color = kanagawa.autumnRed       -- The color of one title if the client is focused
theme.window_switcher_icon_valign = "center"             -- How to vertically align the one icon
theme.window_switcher_icon_width = 40                    -- The width of one icon

-- Textclock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local clock =
    awful.widget.watch(
    "date +'%a %d %b %I:%M'",
    60,
    function(widget, stdout)
        widget:set_markup(" " .. markup.font(theme.font, stdout))
    end
)

local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")

 local cw = calendar_widget()
-- or customized
local cw = calendar_widget({
    theme = 'naughty',
    placement = 'top_left',
    start_sunday = true,
    radius = 0,
-- with customized next/previous (see table above)
    previous_month_button = 1,
    next_month_button = 3,
})
clock:connect_signal("mouse::enter",
    function(_, _, _, button)
        cw.toggle()
    end)
clock:connect_signal("mouse::leave",
    function(_, _, _, button)
        cw.toggle()
    end)

-- Taskwarrior
--local task = wibox.widget.imagebox(theme.widget_task)
--lain.widget.contrib.task.attach(task, {
-- do not colorize output
--    show_cmd = "task | sed -r 's/\\x1B\\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g'"
--})
--task:buttons(my_table.join(awful.button({}, 1, lain.widget.contrib.task.prompt)))

-- Mail IMAP check
local mailicon = wibox.widget.imagebox(theme.widget_mail)
--[[ commented because it needs to be set before use
mailicon:buttons(my_table.join(awful.button({ }, 1, function () awful.spawn(mail) end)))
theme.mail = lain.widget.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        if mailcount > 0 then
            widget:set_text(" " .. mailcount .. " ")
            mailicon:set_image(theme.widget_mail_on)
        else
            widget:set_text("")
            mailicon:set_image(theme.widget_mail)
        end
    end
})
--]]

-- ALSA volume
theme.volume =
    lain.widget.alsabar(
    {
        --togglechannel = "IEC958,3",
        notification_preset = {font = theme.font, fg = theme.fg_normal}
    }
)

--[[
-- MPD
local musicplr = "urxvt -title Music -g 130x34-320+16 -e ncmpcpp"
local mpdicon = wibox.widget.imagebox(theme.widget_music)
mpdicon:buttons(my_table.join(
    awful.button({ modkey }, 1, function () awful.spawn.with_shell(musicplr) end),
    --[[awful.button({ }, 1, function ()
        awful.spawn.with_shell("mpc prev")
        theme.mpd.update()
    end),
    awful.button({ }, 2, function ()
        awful.spawn.with_shell("mpc toggle")
        theme.mpd.update()
    end),
    awful.button({ modkey }, 3, function () awful.spawn.with_shell("pkill ncmpcpp") end),
    awful.button({ }, 3, function ()
        awful.spawn.with_shell("mpc stop")
        theme.mpd.update()
    end)))
theme.mpd = lain.widget.mpd({
    settings = function()
        if mpd_now.state == "play" then
            artist = " " .. mpd_now.artist .. " "
            title  = mpd_now.title  .. " "
            mpdicon:set_image(theme.widget_music_on)
            widget:set_markup(markup.font(theme.font, markup("#FFFFFF", artist) .. " " .. title))
        elseif mpd_now.state == "pause" then
            widget:set_markup(markup.font(theme.font, " mpd paused "))
            mpdicon:set_image(theme.widget_music_pause)
        else
            widget:set_text("")
            mpdicon:set_image(theme.widget_music)
        end
    end
})
--]]

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem =
    lain.widget.mem(
    {
        settings = function()
            -- widget:set_markup(markup.font(theme.font, " " .. mem_now.used .. "MB "))
            widget:set_markup(markup.font(theme.font, " " .. mem_now.perc .. "% "))
        end
    }
)

-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu =
    lain.widget.cpu(
    {
        settings = function()
            widget:set_markup(markup.font(theme.font, " " .. cpu_now.usage .. "% "))
        end
    }
)

--[[ Coretemp (lm_sensors, per core)
local tempwidget = awful.widget.watch({awful.util.shell, '-c', 'sensors | grep Core'}, 30,
function(widget, stdout)
    local temps = ""
    for line in stdout:gmatch("[^\r\n]+") do
        temps = temps .. line:match("+(%d+).*°C")  .. "° " -- in Celsius
    end
    widget:set_markup(markup.font(theme.font, " " .. temps))
end)
--]]
-- Coretemp (lain, average)
local temp =
    lain.widget.temp(
    {
        settings = function()
            widget:set_markup(markup.font(theme.font, " " .. coretemp_now .. "°C "))
        end
    }
)
--]]
local tempicon = wibox.widget.imagebox(theme.widget_temp)

--[[ Weather
https://openweathermap.org/
Type in the name of your city
Copy/paste the city code in the URL to this file in city_id
--]]
local weathericon = wibox.widget.imagebox(theme.widget_weather)
theme.weather =
    lain.widget.weather(
    {
        city_id = 2803138, -- placeholder (Belgium)
        notification_preset = {font = "Noto Sans Mono Medium 10", fg = theme.fg_normal},
        weather_na_markup = markup.fontfg(theme.font, "#ffffff", "N/A "),
        settings = function()
            descr = weather_now["weather"][1]["description"]:lower()
            units = math.floor(weather_now["main"]["temp"])
            widget:set_markup(markup.fontfg(theme.font, "#ffffff", descr .. " @ " .. units .. "°C "))
        end
    }
)

-- / fs
local fsicon = wibox.widget.imagebox(theme.widget_hdd)
--[[ commented because it needs Gio/Glib >= 2.54
theme.fs = lain.widget.fs({
    notification_preset = { fg = theme.fg_normal, bg = theme.bg_normal, font = "Noto Sans Mono Medium 10" },
    settings = function()
        local fsp = string.format(" %3.2f %s ", fs_now["/"].free, fs_now["/"].units)
        widget:set_markup(markup.font(theme.font, fsp))
    end
})
--]]

-- Battery


local baticon = wibox.widget.imagebox(theme.widget_battery)

local battery = require("awesome-upower-battery")

local bat =
    battery(
    {
        settings = function()
            if bat_now.status and bat_now.status ~= "N/A" then
                if bat_now.ac_status == 1 then
                    widget:set_markup(markup.font(theme.font, " AC "))
                    baticon:set_image(theme.widget_ac)
                    return
                elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
                    baticon:set_image(theme.widget_battery_empty)
                elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
                    baticon:set_image(theme.widget_battery_low)
                else
                    baticon:set_image(theme.widget_battery)
                end
                widget:set_markup(markup.font(theme.font, " " .. bat_now.perc .. "% "))
            else
                widget:set_markup()
                baticon:set_image(theme.widget_ac)
            end
        end
    }
)

-- ALSA volume
local volicon = wibox.widget.imagebox(theme.widget_vol)

local volume_widget = require('awesome-wm-widgets.volume-widget.volume')

theme.volume = volume_widget{
  widget_type = "horizontal_bar",
  with_icon = false,
  bg_color = kanagawa.fujiWhite
}

-- Net
local neticon = wibox.widget.imagebox(theme.widget_net)
local net =
    lain.widget.net(
    {
        settings = function()
            widget:set_markup(
                markup.fontfg(theme.font, "#FEFEFE", " " .. net_now.received .. " ↓↑ " .. net_now.sent .. " ")
            )
        end
    }
)

-- Separators
local arrow = separators.arrow_left

function theme.powerline_rl(cr, width, height)
    local arrow_depth, offset = height / 2, 0

    -- Avoid going out of the (potential) clip area
    if arrow_depth < 0 then
        width = width + 2 * arrow_depth
        offset = -arrow_depth
    end

    cr:move_to(offset + arrow_depth, 0)
    cr:line_to(offset + width, 0)
    cr:line_to(offset + width - arrow_depth, height / 2)
    cr:line_to(offset + width, height)
    cr:line_to(offset + arrow_depth, height)
    cr:line_to(offset, height / 2)

    cr:close_path()
end

local pl_color = {
  kanagawa.waveBlue2,
  kanagawa.sakuraPink,
  kanagawa.autumnGreen,
  kanagawa.roninYellow,
  kanagawa.dragonBlue,
  kanagawa.oniViolet,
  kanagawa.springGreen
                 }
local pl_ind = 1

local function pl(widget, bgcolor, padding)
-- return wibox.container.background(wibox.container.margin(widget, dpi(16), dpi(16)), bgcolor, theme.powerline_rl)
local color_ind = pl_ind
local fg_ind = pl_ind
  pl_ind = (pl_ind % 7) + 1


  return wibox.container.background(
    wibox.container.margin(
      widget,
      dpi(8),
      dpi(8)
    ),
    pl_color[color_ind]
    -- theme.powerline_rl
  )
end

function theme.at_screen_connect(s)
    -- Quake application
    -- s.quake = lain.util.quake({ app = awful.util.terminal })
    s.quake = lain.util.quake({app = "urxvt", height = 0.50, argname = "--name %s"})

    -- If wallpaper is a function, call it with the screen
    -- local wallpaper = theme.wallpaper
    -- if type(wallpaper) == "function" then
    --     wallpaper = wallpaper(s)
    -- end
    -- gears.wallpaper.maximized(wallpaper, s, true)

    -- All tags open with layout 1
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(
        my_table.join(
            awful.button(
                {},
                1,
                function()
                    awful.layout.inc(1)
                end
            ),
            awful.button(
                {},
                3,
                function()
                    awful.layout.inc(-1)
                end
            ),
            awful.button(
                {},
                4,
                function()
                    awful.layout.inc(1)
                end
            ),
            awful.button(
                {},
                5,
                function()
                    awful.layout.inc(-1)
                end
            )
        )
    )

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
      screen = s,
      filter = awful.widget.tasklist.filter.currenttags,
      buttons = awful.util.tasklist_buttons,
      widget_template = {
        {
          {
            id     = 'clienticon',
            widget = awful.widget.clienticon,
          },
          margins = 1,
          widget  = wibox.container.background,
          id = 'background_role'
        },
        nil,
        create_callback = function(self, c, index, objects) --luacheck: no unused args
          self:get_children_by_id('clienticon')[1].client = c

          -- BLING: Toggle the popup on hover and disable it off hover
          self:connect_signal('mouse::enter', function()
            awesome.emit_signal("bling::task_preview::visibility", s,
                                true, c)
          end)

          self:connect_signal('mouse::leave', function()
            awesome.emit_signal("bling::task_preview::visibility", s,
                                false, c)
          end)
        end,
        layout = wibox.layout.align.vertical,
      },
    }

    -- Create the wibox
    s.mywibox =
      awful.wibar({position = "top", screen = s, height = dpi(26), bg = theme.bg_normal, fg = theme.fg_normal, border_width = dpi(4)})

    -- Add widgets to the wibox
    s.mywibox:setup {
      layout = wibox.layout.fixed.vertical,
      wibox.widget {
        widget = wibox.widget.separator,
        orientation = "horizontal",
        forced_height = dpi(4),
        thickness = dpi(4),
        color = theme.topline_bg,
        visible = true
      },
      wibox.widget{
        layout = wibox.layout.align.horizontal,
        expand = "none",
        {
          -- Right widgets
          layout = wibox.layout.fixed.horizontal,
          --[[ using shapes ]]--
          --pl(wibox.widget { mpdicon, theme.mpd.widget, layout = wibox.layout.align.horizontal }, "#343434"),
          --pl(task, "#343434"),
          --pl(wibox.widget { mailicon, mail and theme.mail.widget, layout = wibox.layout.align.horizontal }, "#343434"),
          pl(wibox.container.margin(clock, dpi(4), dpi(8)), "#777E76"),
          pl(wibox.widget { baticon, bat.widget, layout = wibox.layout.align.horizontal }, "#8DAA9A"),
          pl(wibox.widget { volicon, theme.volume, layout = wibox.layout.align.horizontal }, "#343434"),
          pl(wibox.widget { memicon, mem.widget, layout = wibox.layout.align.horizontal }, "#777E76"),
          --- pl(wibox.widget { cpuicon, cpu.widget, layout = wibox.layout.align.horizontal }, "#4B696D"),
          -- pl(wibox.widget { tempicon, temp.widget, layout = wibox.layout.align.horizontal }, "#4B3B51"),
          --pl(wibox.widget { fsicon, theme.fs and theme.fs.widget, layout = wibox.layout.align.horizontal }, "#CB755B"), --
          pl(wibox.widget { neticon, net.widget, layout = wibox.layout.align.horizontal }, "#C0C0A2")
        },
        {
          -- Left widgets
          layout = wibox.layout.fixed.horizontal,
          --spr,
          s.mytaglist,
          s.mypromptbox,
          spr
        },
        {
          layout = wibox.layout.fixed.horizontal,
          s.mytasklist, -- Middle widget
          wibox.widget.separator{orientation = "vertical", border_width = 0, forced_width = 2},
          wibox.widget.systray(),
          arrow( theme.bg_normal, theme.topline_bg),
          s.mylayoutbox
        }
      }
    }
end

return theme
