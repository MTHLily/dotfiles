local tbl = require("gears.table")

local awesome = require("keybindings.awesome")
local applications = require("keybindings.applications")
local system = require("keybindings.system")

return tbl.join(system, awesome, applications)
