-- Provides:
-- evil::spotify
--      artist (string)
--      song (string)
--      status (string) [playing | paused | stopped]
local awful = require("awful")
local gears = require("gears")

local function emit_info(playerctl_output)
    local player = playerctl_output:match('player_name(.*)artist_start')
    local artist = playerctl_output:match('artist_start(.*)title_start')
    local title = playerctl_output:match('title_start(.*)status_start')
    -- Use the lower case of status
    local status = playerctl_output:match('status_start(.*)song_cover'):lower()
    status = string.gsub(status, '^%s*(.-)%s*$', '%1')
    local cover = playerctl_output:match('song_cover(.*)')
    if player == "firefox" then cover = cover:gsub("file://", "") end

    awesome.emit_signal("evil::spotify", artist, title, status, cover)

    return {cover = cover, player = player}
end

-- Sleeps until spotify changes state (pause/play/next/prev)
local spotify_script = [[
  sh -c '
    playerctl metadata --format 'player_name{{playerName}}artist_start{{artist}}title_start{{title}}status_start{{status}}song_cover{{mpris:artUrl}}' --follow
  ']]

-- Kill old playerctl process
awful.spawn.easy_async_with_shell(
    "ps x | grep \"playerctl metadata\" | grep -v grep | awk '{print $1}' | xargs kill",
    function()
        -- Emit song info with each line printed
        awful.spawn.with_line_callback(spotify_script, {
            stdout = function(line)
                local cover = emit_info(line)
                if line.player == "spotify" then
                    awful.spawn.easy_async_with_shell(
                        "wget -nc -P /home/maespera/.local/share/hakunon/covers " ..
                            line.cover, function(wget_out)
                            gears.debug
                                .dump("Evil spotify: " .. cover .. wget_out)
                        end)
                end
            end
        })
    end)

