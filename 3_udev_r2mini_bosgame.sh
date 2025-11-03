#!/bin/bash

echo "YD LiDAR (USB Serial) : /dev/ttyUSBx to /dev/ttyLIDAR :"
if [ -f "/etc/udev/rules.d/97-r2mini-tminipro.rules" ]; then
    echo '97-r2mini-tminipro.rules file already exist.'
else
    echo 'SUBSYSTEM=="tty", KERNELS=="3-2", MODE:="0666", GROUP:="dialout", SYMLINK+="ttyLIDAR"' > /etc/udev/rules.d/97-r2mini-tminipro.rules
    echo '97-r2mini-tminipro.rules created'
fi


echo "Motor Driver (USB Serial from RS232) : /dev/ttyTHS1 to /dev/ttyMCU:"
if [ -f "/etc/udev/rules.d/98-r2mini-mcu.rules" ]; then
    echo '98-r2mini-mcu.rules file already exist.'
else
    echo 'SUBSYSTEM=="tty", KERNELS=="3-3", MODE:="0666", GROUP:="dialout", SYMLINK+="ttyMCU"' > /etc/udev/rules.d/98-r2mini-mcu.rules
    echo '98-r2mini-mcu.rules created'
fi


echo "@@@@@ enable jetson nano serial and reload rules @@@@@"
udevadm control --reload-rules
udevadm trigger
exit 0
