#!/bin/bash

dir="$HOME/.config/rofi/launchers/type-6"
theme='hakunon'

vaultscript=~/.config/rofi/scripts/apps/obsidian-vault-selector
tmuxscript=~/.config/rofi/scripts/apps/tmux-session-starter

rofi -show vault -modes "vault:$vaultscript,tmux:$tmuxscript" -theme ${dir}/${theme}.rasi
exit 0
