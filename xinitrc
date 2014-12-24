#!/bin/bash
#
# ~/.xinitrc
#

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xsetroot -solid "#80a0af"
feh --bg-center "$HOME/.config/wallpaper.png"

SSH_CONFIG="$HOME/.ssh/config"
SSH_RSA="$HOME/.ssh/id_rsa"

if [ -x /usr/bin/ssh-agent ] && [ -f $SSH_CONFIG -o -f $SSH_RSA ];
then 
  eval `ssh-agent -s`
  ssh-add < /dev/null
fi

BROWSER='firefox'

xrdb -merge "$HOME/.Xresources"

xset r rate 200 60
xset b 100 0

xset +fp "$HOME/.fonts/Misc"
xset +fp "$HOME/.fonts/OTF"
xset +fp "$HOME/.fonts/TTF"
xset +fp "$HOME/.fonts/Type1"

setxkbmap -layout "gb"
setxkbmap -option "ctrl:nocaps"
setxkbmap -option "terminate:ctrl_alt_bksp"
#setxkbmap -option "compose:ralt"

#xbacklight -set 65%
unclutter -grab 
urxvtd -f -o -q

#autocutsel -fork
#autocutsel -selection PRIMARY -fork 
#udiskie -qN

/usr/bin/start-pulseaudio-x11

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

xsetroot -cursor_name left_ptr
wmname LG3D

#exec $HOME/bin/dwm-start

# while true
# do
#   VOL=$(amixer get Master | tail -1 | sed 's/.*\[\([0-9]*%\)\].*/\1/')
#   LOCALTIME=$(date +%Z\=%Y-%m-%dT%H:%M)
#   OTHERTIME=$(TZ=Europe/London date +%Z\=%H:%M)
#   IP=$(for i in `ip r`; do echo $i; done | grep -A 1 src | tail -n1) # can get confused if you use vmware
#   TEMP="$(($(cat /sys/class/thermal/thermal_zone0/temp) / 1000))C"

# if acpi -a | grep off-line > /dev/null 
# then
#   BAT="Bat. $(acpi -b | awk '{ print $4 " " $5 }' | tr -d ',')"
#   xsetroot -name "$IP $BAT $VOL $TEMP $LOCALTIME $OTHERTIME"
# else
#   xsetroot -name "$IP $VOL $TEMP $LOCALTIME $OTHERTIME"
# fi
# sleep 20s
# done &

# exec dwm

exec xmonad
