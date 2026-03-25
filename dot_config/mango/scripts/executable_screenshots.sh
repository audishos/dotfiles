#!/usr/bin/env bash

# Area
grim -g "$(slurp -d -c '#ff0000ff')" -t ppm - | satty --filename - --output-filename ~/Pictures/Screenshots/capture-$(date '+%Y%m%d-%H:%M:%S').png

# Active window
# grim -g "$(mmsg -x | sed 's/[a-zA-Z]*-[0-9]*[[:space:]][a-z]*[[:space:]]\([0-9]*\)/\1/' | sed -z 's/\([0-9]*\)\n\([0-9]*\)\n\([0-9]*\)\n\([0-9]*\)\n/\1,\2 \3x\4/')" -t ppm - | satty --filename - --output-filename ~/Pictures/Screenshots/capture-$(date '+%Y%m%d-%H:%M:%S').png

# Selected monitor
# grim -g "$(slurp -o)" -t ppm - | satty --filename - --output-filename ~/Pictures/Screenshots/capture-$(date '+%Y%m%d-%H:%M:%S').png
