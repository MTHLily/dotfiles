local awful = require("awful") -- Everything related to window managment
local naughty = require("naughty")

local layout_init = false

tag.connect_signal("request::layouts", function(t) layout_init = true end)

tag.connect_signal("property::layout", function(t)
    local name = t.layout.name
    if layout_init then
        naughty.notification {
            urgency = "low",
            title = "Layout changed",
            message = name,
            timeout = 1,
            app_name = "layout"
        }
    end
end)

local cycle_layout = function() awful.layout.inc(1) end

return cycle_layout
