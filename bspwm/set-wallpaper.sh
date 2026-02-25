#!/bin/sh

echo "Cambió a escritorio: $1" >> /tmp/wallpaper.log

case "$1" in
  I)   feh --bg-fill $HOME/Desktop/fondos/fondo1.jpg ;;
  II)  feh --bg-fill $HOME/Desktop/fondos/fondo2.jpg ;;
  III) feh --bg-fill $HOME/Desktop/fondos/fondo3.jpg ;;
  IV)  feh --bg-fill $HOME/Desktop/fondos/fondo4.jpg ;;
  V)   feh --bg-fill $HOME/Desktop/fondos/fondo5.jpg ;;
  VI)  feh --bg-fill $HOME/Desktop/fondos/fondo6.jpg ;;
  VII) feh --bg-fill $HOME/Desktop/fondos/fondo7.jpg ;;
  VIII) feh --bg-fill $HOME/Desktop/fondos/fondo8.jpg ;;
  IX)  feh --bg-fill $HOME/Desktop/fondos/fondo9.jpg ;;
  X)   feh --bg-fill $HOME/Desktop/fondos/fondo10.jpg ;;
esac

