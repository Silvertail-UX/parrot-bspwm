#!/bin/bash

pkill -u "$UID" -x eww

## Wait until the processes have been shut down
while pgrep -u $UID -x eww >/dev/null; do sleep 1; done

eww daemon &
sleep 0.1
eww open logo &
