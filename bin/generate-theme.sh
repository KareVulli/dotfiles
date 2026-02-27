#!/bin/bash

wallpaper=$1

if [[ $(gsettings get org.gnome.desktop.interface gtk-theme) =~ 'Dark' ]]  then 
	hellwal -b 0.1 --skip-term-colors -i $wallpaper
else 
	hellwal -b 0.1 --check-contrast --skip-term-colors --light -i $wallpaper
fi
