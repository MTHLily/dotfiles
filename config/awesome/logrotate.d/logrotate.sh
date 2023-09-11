#!/bin/bash

LOGROTATE_CONF=~/.config/logrotate.d/conf
LOGROTATE_STATUS=~/.config/logrotate.d/status

cat > "$LOGROTATE_CONF" <<HEREDOC
"$HOME/.cache/awesome/stderr" {
  create
  rotate 5
  size 30M
  missingok
  notifempty
}

"$HOME/.cache/awesome/stdout" {
  create
  rotate 5
  size 30M
  missingok
  notifempty
}
HEREDOC

logrotate -s "$LOGROTATE_STATUS" "$LOGROTATE_CONF"
