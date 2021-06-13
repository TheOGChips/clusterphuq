#!/bin/bash
###### IMPORTANT: Run this script as root! It will not work properly if you don't!!! ######

# just do this via raspi-config
#hostname clusterphuq"$1" # number of the cluster node

# configure static Ethernet IP address
filepath=/etc/dhcpcd.conf
echo "interface eth0" >> "$filepath"
echo "static ip_address=10.10.10.$1/16" >> "$filepath"	# $1 should be the same as the # of the node

# configure Wi-Fi connection (alternatively, can also be done via raspi-config)
#filepath=/etc/wpa_supplicant/wpa_supplicant.conf
#echo "network={" >> "$filepath"
#echo "        ssid=\"<put Wi-Fi SSID here>\"" >> "$filepath"
#echo "        psk=\"<put Wi-Fi password here>\"" >> "$filepath"
#echo "}" >> "$filepath"
