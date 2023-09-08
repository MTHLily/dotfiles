#!/bin/bash

NF_PATH="$HOME/.config/rofi/scripts/json/nerd-fonts.json"
EMOJI_DB="$HOME/.config/rofi/scripts/json/emoji_db"

if [[ -n "$1" ]]; then
  nf="$(echo "$1" | awk "{print \$1}")"
  icon="${nf[0]}"
  echo -n "$icon" | xclip -sel clip
  killall xclip
  exit 1
fi

test -f "$NF_PATH" || \
  curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/glyphnames.json \
  | jq '[. | to_entries[] | select(.key != "METADATA")] | from_entries' \
  > "$NF_PATH"

[ -f "$EMOJI_DB.test" ] || {
  cp "/usr/share/rofi-emoji/all_emojis.txt" "$EMOJI_DB"
  jq -r 'to_entries[] | .value.char + "\tNerd Fonts Glyph\tnerd-fonts\t" + .key + "\t" + .value.code' "$NF_PATH" >> "$EMOJI_DB"
}

# jq -r 'to_entries | .[] | .value.char + "  " + .key' "$NF_PATH"
