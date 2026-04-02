#!/bin/bash

#Retrieves Bluetooth Keys from Windows Registry.
#Uses the function 'reged' from 'chntpw'
#
#This is the file where the retrieved keys are stored: '/home/[user]/bt_keys.reg'
#Better remove the newly created key files after update

reged -x "[WIndows mount point]/Windows/System32/config/SYSTEM" "HKEY_LOCAL_MACHINE\SYSTEM" "\ControlSet001\Services\BTHPORT\Parameters\Keys" "/home/[user]/bt_keys.reg"

#Need to edit the file '/var/lib/bluetooth/[Unique ID]/[Mac Address]/info' and Replace the Key value in the [LinkKey] section with the retrieved pairing key. 

echo "#################################################################"
echo "#################################################################"
echo "Copy the key corresponding to the MAC address of the device"
echo ""
echo "Access the file /var/lib/bluetooth/[bluetooth]/[Mac Address]/info"
echo ""
echo "Replace key value in the [LinkKey] section"
echo ""
echo "Remove the commas from the key and save"
echo ""
echo "Restart the bluetooth service"
echo "#################################################################"
echo "#################################################################"
