#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

## Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

## Launch

## Right bar
polybar informacion -c ~/.config/polybar/current.ini &
polybar boton -c ~/.config/polybar/current.ini &
polybar cpu -c ~/.config/polybar/cpu_bar.ini &
#polybar location -c ~/.config/polybar/gps_bar.ini

## Center bar
polybar workspace -c ~/.config/polybar/workspace.ini &

## Left bar
#polybar log -c ~/.config/polybar/current.ini &
polybar hora -c ~/.config/polybar/current.ini &
polybar ip_status -c ~/.config/polybar/vpn_bar.ini &

