#!/usr/bin/bash

set +e # continue script execution on failure

# some env can't auto run the portal, so need this
/usr/lib/xdg-desktop-portal-wlr >/dev/null 2>&1 &

# bars
waybar -c ~/.config/mango/waybar/config.jsonc >/dev/null 2>&1 &

# wallpaper
swaybg -i ~/Nextcloud/aizhai_bridge-1.jpg -m fill >/dev/null 2>&1 &

# notifications
mako >/dev/null 2>&1 &

# automatic lock and sleep
~/.config/mango/scripts/idle.sh >/dev/null 2>&1 &

# inhibit idle
wayland-pipewire-idle-inhibit >/dev/null 2>&1 &

# passwords
sleep 5 && keepassxc >/dev/null 2>&1 & # sleep fixes tray icon not mounting

# file sync
sleep 5 && nextcloud >/dev/null 2>&1 &
