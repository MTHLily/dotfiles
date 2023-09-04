#!/bin/bash

if ! [[ -z $1 ]]; then
  nf=($1)
  icon="${nf[0]}"
  echo "$icon" | xclip -sel clip
  killall xclip
  exit 1
fi
nf_path="$HOME/.config/rofi/scripts/json/nerd-fonts.json"

test -f $nf_path || \
  curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/glyphnames.json > $nf_path

jq -r 'to_entries | .[] | .value.char + "  " + .key' $nf_path
echo "ASD"
