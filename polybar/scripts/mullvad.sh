#!/bin/bash

status="$(mullvad status | head -n1)"
ip_public="$(mullvad status | tail -n1 | awk 'NF{print $NF}')"

if [ "$status" = "Connected" ]; then
  country="$(mullvad status | tail -n1 | awk '{print $3}' | tr -d ',')"
  city="$(mullvad status | tail -n1 | awk '{print $4}' | tr -d '.')"
  echo -e "%{F#fff000}󰗹  $ip_public%{u-}"
else
  echo -e "%{F#ff7aed}󰁵  $status 󱦃 %{u-}"
fi

# Link GUI: sudo ln -s /opt/Mullvad VPN/mullvad-gui /usr/local/bin/mullvad-vpn
