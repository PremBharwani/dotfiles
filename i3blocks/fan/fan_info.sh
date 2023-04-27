#!/bin/bash

# Get fan RPM
fan_rpm=$(sensors | grep 'fan1:' | awk '{print $2}' | cut -c1-)

# Output the temperature with a temprature symbol
echo "󰈐 $fan_rpm"

# Output yellow color hexcode #Test
echo "#00C234" # Test

# Output the color on the basis of temprature range



if (( $(echo "${fan_rpm//[^0-9.]/} < 4200" | bc -l) )); then
    color="#00C234"  # <70 green
elif (( $(echo "${fan_rpm//[^0-9.]/} > 4200" | bc -l) ) && ( $(echo "${fan_rpm//[^0-9.]/} < 4500" | bc -l) )); then
    color="#FFFF00"  # 70-80 yellow
else
    color="#CC0E00"  # >80 red
fi

echo "$color"