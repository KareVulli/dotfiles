#!/usr/bin/bash

TARGET_HOST='10.57.90.1'
RECONNECTING=0

if $(ip add show | grep -qF wg0); then
	echo "Checking connectivity..."
	PING=$(ping -c 1 $TARGET_HOST | grep from* | wc -l)
	if [ $PING -eq 0 ]; then
		echo "Could not ping Wireguard host, reconnecting..."
		notify-send "Could not ping Wireguard host" "Restarting Wireguard connection..."
		nmcli connection down wg0
		nmcli connection up wg0
		RECONNECTING=1
	else
		if [ $RECONNECTING -eq 1 ]; then
			echo "Reconnected to Wireguard!"
		else
			echo "All good!"
		fi
		RECONNECTING=0
	fi
else
	echo "wg0 not active, exiting..."
fi
