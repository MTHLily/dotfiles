#!/usr/bin/env fish

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Launcher (Modi Drun, Run, File Browser, Window)
#
## Available Styles
#
## style-1     style-2     style-3     style-4     style-5
## style-6     style-7     style-8     style-9     style-10

set dir "$HOME/.config/rofi/launchers/type-7"
set theme 'style-1'

set vaults "Personal" "Headspace" "TTRPG"

## Run
set choice (echo -e (string join '\n' $vaults) | rofi \
    -dmenu \
    -theme "$dir/$theme.rasi")
echo $choice

switch $choice
  case "Personal"
    xdg-open "obsidian://open?vault=今日のマイク" &
  case "Headspace"
    xdg-open "obsidian://open?vault=Headspace" &
  case "TTRPG"
    xdg-open "obsidian://open?vault=TTRPG" &
end

