#!/bin/bash
# makes blink(1) turn red for $pomodoro_length minutes and then green for $break_length minutes

blink_path="`which blink1-tool`"

pomodoro_color="255,0,0"

break_color="0,255,0"

pomodoro_length=25 # length of tomato in minutes

break_length=5 # length of break in minutes

let pomodoro_secs=$pomodoro_length*60
let break_secs=$break_length*60
let total_length=$pomodoro_length+$break_length

pomodoro=0

trap ctrl_c INT

function ctrl_c() {
	$blink_path --off
	exit 0
}

while true; do
	echo "$pomodoro_secs"
	let pomodoro+=1
	echo "Now beginning pomodoro # $pomodoro"
	$blink_path --rgb $pomodoro_color --blink 4 > /dev/null 2>&1
	$blink_path --rgb $pomodoro_color > /dev/null 2>&1
	sleep $pomodoro_secs
	$blink_path --rgb $break_color --blink 4 > /dev/null 2>&1
	$blink_path --rgb $break_color > /dev/null 2>&1
	sleep $break_secs
done
