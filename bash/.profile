# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.config/bash/.bashrc" ]; then
  . "$HOME/.config/bash/.bashrc"
  # include .bashrc if it exists
  elif [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
  fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi

# launch hyprland in graphical displays only
#if [ -z "$DISPLAY" ] && [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
#  [ -x /usr/bin/hyprland ] && exec hyprland
#fi

#if uwsm check may-start; then
#  exec systemd-cat -t uwsm_start uwsm start defaultuwsm start hyprland.desktop
#fi
