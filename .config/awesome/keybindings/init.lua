local gears = require("gears")
local tbl = require("gears.table")
local awful = require("awful")
local helpers = require("helpers")

-- Import the keybindings
local awesome = require("keybindings.awesome")
local applications = require("keybindings.applications")
local system = require("keybindings.system")
local mouse = require("keybindings.mouse")
local elemental = require("keybindings.elemental")

local global = gears.table.join(system.global, awesome.global,
    applications.global)
local clientbuttons = gears.table.join(mouse.clientbuttons)
local clientkeys = gears.table.join(awesome.clientkeys)

-- helpers.generateKeybindingDescriptions(elemental.titlebar_buttons)

-- Spooky function
-- Initialize this function on the same line as root
for i = 1, 10 do
    global = tbl.join(global,
        awful.key({"Mod4", "Shift"}, "#" .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then client.focus:move_to_tag(tag) end
            end
        end, {
            description = "move focused client to tag #",
            group = "awesome/tags"
        }))
end

root.keys(global)

return {
    global = global,
    clientbuttons = clientbuttons,
    clientkeys = clientkeys,
    tasklist_buttons = elemental.tasklist_buttons,
    taglist_buttons = elemental.taglist_buttons,
    titlebar_buttons = elemental.titlebar_buttons
}
