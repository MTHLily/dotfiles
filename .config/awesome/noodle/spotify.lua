local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")
local gears = require("gears")

local helpers = require("helpers")
local log = helpers.log

-- Declare widgets
local spotify_artist = wibox.widget.textbox()
local spotify_title = wibox.widget.textbox()
local spotify_bg = wibox.widget.background()
local cover = nil

-- Main widget that includes all others
local spotify_widget = wibox.widget {
    {
        -- Title widget
        {
            align = "center",
            text = "---",
            font = "Iosevka Nerd Font Mono 16",
            widget = spotify_title
        },
        -- Artist widget
        {
            align = "center",
            text = "---",
            font = "Iosevka Nerd Font Mono 10",
            widget = spotify_artist
        },
        spacing = 2,
        layout = wibox.layout.fixed.vertical
    },
    widget = spotify_bg
}

-- Subcribe to spotify updates
awesome.connect_signal("evil::spotify", function(artist, title, status, cover)
    -- Do whatever you want with artist, title, status
    -- ...
    spotify_artist.text = artist
    spotify_title.text = title

    local image = cover ~= "" and gears.surface.load(cover) or nil
    spotify_bg.bgimage = helpers.create_background_image {
        image = image,
        opacity = 0.2,
        valign = "center",
        halign = "center"
    }

    -- Example notification (might not be needed if spotify already sends one)
    if status == "playing" then
        naughty.notification {
            urgency = "low",
            title = "「音楽」 Now Playing",
            message = title .. " by " .. artist,
            app_name = "spotify",
            image = image
        }
    end
end)

return spotify_widget
