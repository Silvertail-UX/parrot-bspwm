#!/bin/bash

Relay="$(mullvad status | head -n 2 | tail -n 1 | awk '{print $2}')"
country="$(mullvad status | tail -n1 | awk '{print $3}' | tr -d ",")"
city="$(mullvad status | tail -n1 | awk '{print $4}' | tr -d ".")"

echo -e "%{F#ffff00}    %{u-}%{F#a2fe8c}$country, $city.%{u-}"

