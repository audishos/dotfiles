#!/usr/bin/env sh

TMP_BLUR_BG=$(mktemp /tmp/swaylock_XXXXXX.jpg)

grim -t jpeg /tmp/screenshot.jpg &&
  ffmpeg -loglevel panic -y -i /tmp/screenshot.jpg -vf "gblur=sigma=25" "$TMP_BLUR_BG" &&
  swaylock -fF -i "$TMP_BLUR_BG"

rm "$TMP_BLUR_BG"
