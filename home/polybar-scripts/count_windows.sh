#!/bin/sh

windows=$(bspc query -N -d focused -n .window)
count=$(echo "$windows" | wc -l)
if [ $count -le 1 ]; then
    echo ""
else
    focused_window=$(bspc query -N -d focused -n .window.focused)
    index=$(echo "$windows" | grep "$focused_window" -Fn | cut -d: -f1)
    echo "$index/$count"
fi
