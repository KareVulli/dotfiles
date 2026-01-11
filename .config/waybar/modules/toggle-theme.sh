#!/bin/bash

wallpaper=$(awk -F " = " '$1 == "wallpaper" {print $2}' ~/.config/waypaper/config.ini)

if [[ $(gsettings get org.gnome.desktop.interface gtk-theme) =~ 'Dark' ]]  then 
    # gsettings set org.gnome.desktop.interface color-scheme "prefer-light"
    gsettings set org.gnome.desktop.interface gtk-theme "Breeze"
    hellwal --check-contrast --light --skip-term-colors -i $wallpaper
else 
    # gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
    gsettings set org.gnome.desktop.interface gtk-theme "Breeze-Dark"
    hellwal --check-contrast --skip-term-colors -i $wallpaper
fi