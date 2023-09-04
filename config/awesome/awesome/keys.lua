local configuration = require("keybindings.init")

local keys = {}

-- Mod keys
Superkey = "Mod4"
Altkey = "Mod1"
Ctrlkey = "Control"
Shiftkey = "Shift"

keys.globalkeys = configuration.global

-- Mouse buttons on the client (whole window, not just titlebar)
keys.clientbuttons = configuration.clientbuttons -- Mouse buttons on the tasklist
-- Use 'Any' modifier so that the same buttons can be used in the floating
-- tasklist displayed by the window switcher while the superkey is pressed
keys.tasklist_buttons = configuration.tasklist_buttons

-- Mouse buttons on a tag of the taglist widget
keys.taglist_buttons = configuration.taglist_buttons -- Mouse buttons on the primary titlebar of the window
keys.titlebar_buttons = configuration.titlebar_buttons

-- }}}

keys.clientkeys = configuration.clientkeys

return keys
