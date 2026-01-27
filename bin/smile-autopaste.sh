#!/usr/bin/env bash

# Monitor D-Bus signals and trigger dotool command
# See https://raw.githubusercontent.com/mijorus/smile/refs/heads/master/extras/autopaste-service-install.sh
dbus-monitor --session "type='signal',interface='it.mijorus.smile',member='CopiedEmojiBroadcast',path='/it/mijorus/smile/actions'" | \
while read -r line; do
    if echo "$line" | grep -q "member=CopiedEmojiBroadcast"; then
        # Trigger paste
        wlrctl keyboard type 'v' modifiers CTRL
    fi
done