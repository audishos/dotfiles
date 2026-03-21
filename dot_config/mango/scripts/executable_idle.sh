#!/usr/bin/bash

swayidle -w \
  `# Lock after 5 minutes` \
  timeout $((60 * 5)) 'swaylock -fF' \
  `# Turn off displays after 10 minutes and turn on when activity resumes` \
  timeout $((60 * 10)) 'mmsg -d disable_monitor,' resume 'mmsg -d enable_monitor,' \
  `# Suspend after 20 minutes` \
  timeout $((60 * 20)) 'systemctl suspend' \
  `# Lock before suspend` \
  before-sleep 'swaylock -fF'
