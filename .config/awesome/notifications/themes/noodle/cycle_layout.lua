local awful = require("awful") -- Everything related to window managment
local naughty = require("naughty")

local cycle_layout = function()
    awful.layout.inc(1)
    local layout = awful.layout.get()
    local name = awful.layout.getname(layout)
    naughty.notification {
        urgency = "critical",
        title = "Layout changed",
        message = name,
        timeout = 1
    }
end

return cycle_layout
