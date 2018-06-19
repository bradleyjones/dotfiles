#!/bin/sh
# shell script to prepend i3status with more stuff

i3status -c ~/.i3/i3status.conf | while :
do
  read line
  echo "$(weechat-notification show) | $line" || exit 1
done
