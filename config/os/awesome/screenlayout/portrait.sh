#!/bin/sh
xrandr --output eDP --primary --mode 1920x1080 --pos 1080x1327 --rotate normal --output HDMI-A-0 --mode 1920x1080 --pos 0x0 --rotate left --output DisplayPort-0 --off --output DisplayPort-1 --off

bash -x ./common/after.sh
