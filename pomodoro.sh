#!/bin/bash
# makes blink(1) turn red for $pomodoro_length minutes and then green for $break_length minutes

blink_path=".././blink1-tool"

pomodoro_color="255,0,0"

break_color="0,255,0"

pomodoro_length=25 # length of tomato in minutes

break_length=5 # length of break in minutes

let total_length=$pomodoro_length+$break_length

pomodoro=0

while true; do
	i=0
	let pomodoro+=1
	echo "Now beginning pomodoro # $pomodoro"
	while [ "$i" -lt "$total_length" ]; do
		if [[ "$i" -eq 0 ]]
		then
			if [[ "$i" -ge "$total_length" ]]
			then
				let i=0
			fi
			$blink_path --rgb $pomodoro_color --blink 4 > /dev/null 2>&1
			$blink_path --rgb $pomodoro_color > /dev/null 2>&1
		elif [[ "$i" -eq "$pomodoro_length" ]]
		then
			$blink_path --rgb $break_color --blink 4 > /dev/null 2>&1
			$blink_path --rgb $break_color > /dev/null 2>&1
		fi
		sleep 60 # loop runs once a minute
		let i+=1
	done
done