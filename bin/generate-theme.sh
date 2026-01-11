#!/bin/bash

wallpaper=$1

if [[ $(gsettings get org.gnome.desktop.interface gtk-theme) =~ 'Dark' ]]  then 
	hellwal --check-contrast --skip-term-colors -i $wallpaper
else 
	hellwal --check-contrast --skip-term-colors --light -i $wallpaper
fi
