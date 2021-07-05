#!/bin/bash
# Run this script as a non-root user

# change cursor type from being that annoying "X" shape
filepath=/home/"$user_name"/.vnc/xstartup
echo -e "Altering mouse cursor settings in $filepath...\n"
sed -i "s;xsetroot -solid grey;xsetroot -solid grey -cursor_name left_ptr;" "$filepath"	# replaces the line inside the file at $filepath without needing to use text editor
echo -e "NOTICE: Altering the mouse cursor settings may not have worked. You may need to change it yourself in $filepath..."
