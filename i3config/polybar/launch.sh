#! /bin/sh
#
# launch.sh
# Copyright (C) 2019 clay <clay@clay-pc>
#
# Distributed under terms of the MIT license.
#


#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
polybar bar1 &
polybar bar2 &

echo "Bars launched..."
