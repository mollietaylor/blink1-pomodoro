#!/bin/bash
# makes blink(1) turn red for 25 minutes (starting on the hour and half-hour) and then green for five minutes

blink_path=".././blink1-tool"

tomato_color="255,0,0"

break_color="0,255,0"

# initial color:
minute=$(date +"%M")
minute=`echo $minute|sed 's/^0*//'`
if [[ "$minute" -lt 25 || "$minute" -ge 30 && "$minute" -lt 55 ]]
then
	$blink_path --rgb $tomato_color > /dev/null 2>&1
else
	$blink_path --rgb $break_color > /dev/null 2>&1
fi

# change colors and beep:
while true; do
	minute=$(date +"%M")
	minute=`echo $minute|sed 's/^0*//'`
	second=$(date +"%S")
	second=`echo $second|sed 's/^0*//'`
	if [[ "$second" -eq 0 ]]
	then
		if [[ "$minute" -eq 0 || "$minute" -eq 30 ]]
		then
			paplay /usr/share/sounds/KDE-Im-Highlight-Msg.ogg # beep
			$blink_path --rgb $tomato_color --blink 4 > /dev/null 2>&1
			$blink_path --rgb $tomato_color > /dev/null 2>&1
		elif [[ "$minute" -eq 25 || "$minute" -eq 55 ]]
		then
			paplay /usr/share/sounds/KDE-Im-Highlight-Msg.ogg # beep
			$blink_path --rgb $break_color --blink 4 > /dev/null 2>&1
			$blink_path --rgb $break_color > /dev/null 2>&1
		fi
		sleep 5 # loop runs every 5 seconds
	fi
done
