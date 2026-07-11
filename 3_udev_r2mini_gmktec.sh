#!/bin/bash

echo "YD LiDAR (USB Serial) : /dev/ttyUSBx to /dev/ttyLIDAR :"
if [ -f "/etc/udev/rules.d/97-r2mini-lidar.rules" ]; then
    echo '97-r2mini-lidar.rules file already exist.'
else
    echo 'SUBSYSTEM=="tty", KERNELS=="1-3", MODE:="0666", GROUP:="dialout", SYMLINK+="ttyLIDAR"' > /etc/udev/rules.d/97-r2mini-lidar.rules
    echo '97-r2mini-lidar.rules created'
fi


echo "Motor Driver (USB Serial from RS232) : /dev/ttyUSBx to /dev/ttyMCU:"
if [ -f "/etc/udev/rules.d/98-r2mini-mcu.rules" ]; then
    echo '98-r2mini-mcu.rules file already exist.'
else
    echo 'SUBSYSTEM=="tty", KERNELS=="1-4", MODE:="0666", GROUP:="dialout", SYMLINK+="ttyMCU"' > /etc/udev/rules.d/98-r2mini-mcu.rules
    echo '98-r2mini-mcu.rules created'
fi


echo "@@@@@ reload udev rules @@@@@"
udevadm control --reload-rules
udevadm trigger
exit 0
