xset +dpms &
~/scripts/monitor.sh &
~/scripts/poll.sh &
tint2 &
conky &
xterm -e "~/scripts/tc.sh" &
yakuake &
~/scripts/thunderbird.sh &
easystroke &
keepass2 &
gnome-do &
xscreensaver -no-splash &
setxkbmap de nodeadkeys &
setxkbmap -option ctrl:nocaps &
owncloud &
kmix &
dunst &
gvim ~/ownCloud/TODO.txt &
gtk-redshift -l 50.11:8.68 &
nm-applet &
kill -HUP $(pidof conky) & # TODO dirty hack
xset b off
