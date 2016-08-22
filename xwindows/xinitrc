#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

exec i3


xss-lock -- i3exit lock &

autolock -time 10 -locker "i3exit lock" &

# be fast with the keyboard.  Not slow.
xset r rate 150 18

# Keep the trackpad from messing me up.
syndaemon -dt

#exec xterm
#exec wmii
#exec xmonad
# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
[[ -f ~/.Xresources ]] && xrdb -load ~/.Xresources
