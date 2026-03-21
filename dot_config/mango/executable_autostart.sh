#!/bin/bash

set +e # continue script execution on failure

# some env can't auto run the portal, so need this
/usr/lib/xdg-desktop-portal-wlr >/dev/null 2>&1 &

# bars
waybar -c ~/.config/mango/waybar/config.jsonc >/dev/null 2>&1 &

# passwords
keepass-xc >/dev/null 2>&1 &

# wallpaper
swaybg -i ~/Nextcloud/aizhai_bridge-1.jpg -m fill >/dev/null 2>&1 &
