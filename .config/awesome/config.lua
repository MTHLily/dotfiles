local config = {
    features = {debug = true},
    keys = {},
    apps = {},
    locations = {
        covers = os.getenv("HOME") .. "/.local/share/hakunon/covers",
        hakunon_box = os.getenv("HOME") .. "/.config/awesome/assets/hakutea.jpg"
    }
}

return config
