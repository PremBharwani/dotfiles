#!/bin/bash

# If ACPI was not installed, this probably is a battery-less computer.
ACPI_RES=$(acpi -b)
ACPI_CODE=$?
if [ $ACPI_CODE -eq 0 ]
then
    # Get essential information. Due to som bug with some versions of acpi it is
    # worth filtering the ACPI result from all lines containing "unavailable".
    BAT_LEVEL_ALL=$(echo "$ACPI_RES" | grep -v "unavailable" | grep -E -o "[0-9][0-9]?[0-9]?%")
    BAT_LEVEL=$(echo "$BAT_LEVEL_ALL" | awk -F"%" 'BEGIN{tot=0;i=0} {i++; tot+=$1} END{printf("%d%%\n", tot/i)}')
    TIME_LEFT=$(echo "$ACPI_RES" | grep -v "unavailable" | grep -E -o "[0-9]{2}:[0-9]{2}:[0-9]{2}")
    #IS_CHARGING=$(echo "$ACPI_RES" | grep -v "unavailable" | awk '{ printf("%s\n", substr($3, 0, length($3)-1) ) }')

    # If there is no 'time left' information (when almost fully charged) we 
    # provide information ourselvs.
    if [ -z "$TIME_LEFT" ]
    then
        TIME_LEFT="00:00:00"
    fi

    # Print full text. The charging data.
    TIME_LEFT=$(echo $TIME_LEFT | awk '{ printf("%s\n", substr($1, 0, 5)) }')
    # echo " $BAT_LEVEL  $TIME_LEFT "

    CHARGE_ICON=""
#     MESSAGE="$CHARGE_ICON $CHARGING_STATUS_ICON $BAT_LEVEL  $TIME_LEFT "
    COLOR="#FFFFFF"
    
#    # if charging change the CHARGIN_STATUS_ICON
#    if [ "$IS_CHARGING" = "Charging" ]
#    then
#        CHARGING_STATUS_ICON=""
#    else
#        CHARGING_STATUS_ICON="ia"
#    fi

# Look for discharging status by grepping "Battery 0"
    IS_DISCHARGING=$(echo "$(acpi -b)" | grep "Battery 0" | grep -E -o "Discharging")



    # Conditions to check range of battery level <20, <40, <60, <80, <100
    if [ "${BAT_LEVEL%?}" -le 15 ]
    then
        # Battery very low. Red color.
        CHARGE_ICON=""
        COLOR="#FA1E44"
    elif [ "${BAT_LEVEL%?}" -le 35 ]
    then
        # Battery low. Orange color.
        CHARGE_ICON=""
        COLOR="#FFA500"
    elif [ "${BAT_LEVEL%?}" -le 55 ]
    then
        # Battery medium. Yellow color.
        CHARGE_ICON=""
        COLOR="#FFFF00"
    elif [ "${BAT_LEVEL%?}" -le 75 ]
    then
        # Battery high. Green color.
        CHARGE_ICON=""
        COLOR="#00FF00"
    elif [ "${BAT_LEVEL%?}" -le 99 ]
    then
        # Battery very high. Green color.
        CHARGE_ICON=""
        COLOR="#00FF00"
    else
        # Battery not charging but at decent level. Green color.
        CHARGE_ICON=""
        COLOR="#007872"
    fi


    # Use the command $(acpi -a | grep -E -o on) to check if the laptop is plugged in & save the variable as IS_CHARGING
    IS_CHARGING=$(acpi -a | grep -E -o 'on')
    # echo "IS_CHARGING : $IS_CHARGING"
    
    if [[ "$IS_CHARGING" == "on" ]]  # Check if laptop is charging
    then
        # echo "Hwllo"
        echo "$CHARGE_ICON 󱐋 $BAT_LEVEL  $TIME_LEFT"
    else
        echo "$CHARGE_ICON $BAT_LEVEL  $TIME_LEFT"
    fi

    
    echo "#FFFFFF"
    echo "$COLOR"
fi