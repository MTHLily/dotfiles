local config = {features = {}, keys = {}, apps = {}}

config.features["mpd"] = true

-- modkey or mod4 = super key
config.keys["modkey"] = "Mod4"
config.keys["altkey"] = "Mod1"
config.keys["ctrlkey"] = "Control"

-- Applications
config.apps["browser1"] = "firefox"
config.apps["browser2"] = "brave-bin"
config.apps["browser3"] = "chromium -no-default-browser-check"
config.apps["editor"] = os.getenv("EDITOR") or "neovim"
config.apps["editorgui"] = "emacs ~/.config/awesome/README.org"
config.apps["filemanager"] = "thunar"
config.apps["mailclient"] = "mailspring"
config.apps["mediaplayer"] = "spotify"
config.apps["terminal"] = "alacritty"
config.apps["virtualmachine"] = "virtualbox"

return config
