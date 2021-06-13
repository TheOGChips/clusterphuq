#!/bin/bash
###### IMPORTANT: Run this script as root! It will not work properly if you don't!!! ######

# just do this through raspi-config
#hostname clusterphuq"$0" # number of the cluster node

# configure static Ethernet IP address
filepath=/etc/dhcpcd.conf
echo "interface eth0" >> "$filepath"
echo "static ip_address=10.10.10.$1/16" >> "$filepath"	# $1 should be the same as the # of the node

# configure Wi-Fi connection
#filepath=/etc/wpa_supplicant/wpa_supplicant.conf	#TODO: Check if first 3 lines are already in file
#echo "network={" >> "$filepath"
#echo "        ssid=\"Eagle Summit 5g\"" >> "$filepath"
#echo "        psk=\"Tenant@ES\!\"" >> "$filepath"
#echo "}" >> "$filepath"
