#!/bin/bash

# Get system temperature
temp=$(sensors | grep 'Core 0' | awk '{print $3}' | cut -c2-)

# Output the temperature with a temprature symbol
echo " $temp"

# Output yellow color hexcode #Test
echo "#00C234" # Test

# Output the color on the basis of temprature range



if (( $(echo "${temp//[^0-9.]/} < 70" | bc -l) )); then
    echo "#00C234"  # <70 green
elif (( $(echo "${temp//[^0-9.]/} > 70" | bc -l) )) && (( $(echo "${temp//[^0-9.]/} < 80" | bc -l) )); then
    echo "#FFFF00"  # 70-80 yellow
else
    echo "#CC0E00"  # >80 red
fi