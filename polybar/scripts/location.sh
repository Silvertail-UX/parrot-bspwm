#!/bin/bash

country="$(mullvad status | tail -n1 | awk '{print $3}' | tr -d ",")"
statuss="$(mullvad status | head -n 1)"
city="$(mullvad status | tail -n1 | awk '{print $4}' | tr -d ".")"
if [ "$statuss" == "Connected" ]; then
  echo -e "%{F#ffff00}    %{u-}%{F#a2fe8c}$country - $city%{u-}"
else [ "${statuss}" == "Disconnected" ];
  echo -e "%{F#ffff00}    %{u-}%{F#a2fe8c}Visible Location %{F#ff0000} %{u-}"
fi
