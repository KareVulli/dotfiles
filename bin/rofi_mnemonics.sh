#!/usr/bin/bash

if [ x"$@" = x"docker" ]
then
    coproc ( systemctl is-active --quiet docker && (systemctl stop docker docker.socket && notify-send "Docker stopped" -t 2000)  || (systemctl start docker && notify-send "Docker started" -t 2000) > /dev/null 2>&1 )
    exit 0
fi
echo -en "docker\0meta\x1fdk\n"