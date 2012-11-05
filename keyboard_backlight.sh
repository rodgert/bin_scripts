#!/bin/sh
cur=`dbus-send --print-reply=literal --type=method_call --system --dest=org.freedesktop.UPower /org/freedesktop/UPower/KbdBacklight org.freedesktop.UPower.KbdBacklight.GetBrightness | sed s/...int32.//g`
max=`dbus-send --print-reply=literal --type=method_call --system --dest=org.freedesktop.UPower /org/freedesktop/UPower/KbdBacklight org.freedesktop.UPower.KbdBacklight.GetMaxBrightness | sed s/...int32.//g`

case "$1" in
    incr)
        val=$(($cur + 1))
        lim=$(($val <= $max))
    ;;
    decr)
        val=$(($cur - 1))
        lim=$(($val >= 0))
    ;;
esac

if (( "$lim" > 0 )) 
then
    echo "Setting Brightness to " $val
    dbus-send --print-reply=literal --type=method_call --system --dest=org.freedesktop.UPower /org/freedesktop/UPower/KbdBacklight org.freedesktop.UPower.KbdBacklight.SetBrightness int32:$val
fi
