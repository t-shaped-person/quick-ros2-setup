#!/bin/bash

echo "Motor Driver (USB Serial from RS232) : /dev/ttyTHS1 to /dev/ttyMCU or /dev/ttyMotor:"
if [ -f "/etc/udev/rules.d/98-omo-r1-mini-mcu.rules" ]; then
    echo "98-omo-r1-mini-mcu.rules file already exist."
else 
    echo 'KERNEL=="ttyTHS1", MODE:="0666", GROUP:="dialout", SYMLINK+="ttyMCU"' > /etc/udev/rules.d/98-omo-r1-mini-mcu.rules   
    echo '98-omo-r1-mini-mcu.rules created'
fi

if [ -f "/etc/udev/rules.d/98-omo-r1-mini-mcu-1.rules" ]; then
    echo "98-omo-r1-mini-mcu-1.rules file already exist."
else 
    echo 'KERNEL=="ttyTHS1", MODE:="0666", GROUP:="dialout", SYMLINK+="ttyMotor"' > /etc/udev/rules.d/98-omo-r1-mini-mcu-1.rules   
    echo '98-omo-r1-mini-mcu-1.rules created'
fi


echo "YD LiDAR (USB Serial) : /dev/ttyUSBx to /dev/ttyLIDAR or /dev/ttyLiDAR :"
if [ -f "/etc/udev/rules.d/97-omo-r1-mini-lidar.rules" ]; then
    echo "97-omo-r1-mini-lidar.rules file already exist."
else 
    echo 'KERNEL=="ttyUSB*", ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="ea60", MODE:="0666", GROUP:="dialout",  SYMLINK+="ttyLIDAR"' > /etc/udev/rules.d/97-omo-r1-mini-lidar.rules
    echo '97-omo-r1-mini-lidar.rules created'
fi

if [ -f "/etc/udev/rules.d/97-omo-r1-mini-lidar-1.rules" ]; then
    echo "97-omo-r1-mini-lidar-1.rules file already exist."
else 
    echo 'KERNEL=="ttyUSB*", ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="ea60", MODE:="0666", GROUP:="dialout",  SYMLINK+="ttyLiDAR"' > /etc/udev/rules.d/97-omo-r1-mini-lidar-1.rules
    echo '97-omo-r1-mini-lidar-1.rules created'
fi


echo "@@@@@ enable jetson nano serial and reload rules @@@@@"
systemctl stop nvgetty
systemctl disable nvgetty
udevadm control --reload-rules
udevadm trigger
exit 0
