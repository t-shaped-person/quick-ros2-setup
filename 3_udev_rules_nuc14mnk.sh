#!/bin/bash

echo "YD LiDAR (USB Serial) : /dev/ttyUSBx to /dev/ttyLIDAR :"
if [ -f "/etc/udev/rules.d/97-omorobot-lidar.rules" ]; then
    echo '97-omorobot-lidar.rules file already exist.'
else
    echo 'SUBSYSTEM=="tty", KERNELS=="3-3", MODE:="0666", GROUP:="dialout", SYMLINK+="ttyLIDAR"' > /etc/udev/rules.d/97-omorobot-lidar.rules
    echo '97-omorobot-lidar.rules created'
fi


echo "Motor Driver (USB Serial from RS232) : /dev/ttyUSBx to /dev/ttyMCU:"
if [ -f "/etc/udev/rules.d/98-omorobot-mcu.rules" ]; then
    echo '98-omorobot-mcu.rules file already exist.'
else
    echo 'SUBSYSTEM=="tty", KERNELS=="3-4", MODE:="0666", GROUP:="dialout", SYMLINK+="ttyMCU"' > /etc/udev/rules.d/98-omorobot-mcu.rules
    echo '98-omorobot-mcu.rules created'
fi


echo "@@@@@ reload udev rules @@@@@"
udevadm control --reload-rules
udevadm trigger
exit 0
