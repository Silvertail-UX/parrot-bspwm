#!/usr/bin/env bash
set -euo pipefail
 
# Mata cualquier picom vivo
pkill -x picom 2>/dev/null || true
while pgrep -x picom >/dev/null; do sleep 0.2; done
 
# Da un respiro al servidor X
sleep 1
 
# Intenta con tu config (GLX si lo tienes ahí)
if ! picom --config "$HOME/.config/picom/picom.conf" -b; then
  # Si falla, relanza forzando xrender (más estable)
  picom --config "$HOME/.config/picom/picom.conf" --backend xrender --vsync -b
fi
 
