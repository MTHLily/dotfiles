local awful = require("awful") -- Everything related to window managment
local naughty = require("naughty")

tag.connect_signal("property::layout", function(t)
    local name = t.layout.name
    naughty.notification {
        urgency = "low",
        title = "Layout changed",
        message = name,
        timeout = 1,
        app_name = "layout"
    }
end)

local cycle_layout = function() awful.layout.inc(1) end

return cycle_layout
