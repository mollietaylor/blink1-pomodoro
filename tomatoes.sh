#!/bin/bash
# makes blink(1) turn red for 25 minutes (starting on the hour and half-hour) and then green for five minutes

blink_path=".././blink1-tool"

tomato_color="255,0,0"

break_color="0,255,0"

# light blink(1)
while true; do
	minute=$(date +"%M")
	minute=`echo $minute|sed 's/^0*//'`
	if [[ "$minute" -lt 25 || "$minute" -ge 30 && "$minute" -lt 55 ]]
	then
		$blink_path --rgb $tomato_color > /dev/null 2>&1
	else
		$blink_path --rgb $break_color > /dev/null 2>&1
	fi
	sleep 5 # loop only runs every 5 seconds
done
