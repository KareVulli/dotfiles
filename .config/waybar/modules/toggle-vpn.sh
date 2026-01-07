#!/bin/bash

if $(ip add show | grep -qF wg0); then 
    nmcli connection down wg0;
    nmcli connection modify wg0 connection.autoconnect no; 
else 
    nmcli connection up wg0;
    nmcli connection modify wg0 connection.autoconnect yes;
fi