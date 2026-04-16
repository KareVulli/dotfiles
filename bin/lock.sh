#!/usr/bin/env bash
for o in HDMI-A-1 DP-1
do
	(grim -l 0 -o "$o" "/tmp/$o.png" && magick "/tmp/$o.png" -resize 10% -fill black -colorize 20% -blur 0x2 "/tmp/$o.png") &
done
wait
gtklock -s /home/karevulli/.config/gtklock/style.css "$@"
