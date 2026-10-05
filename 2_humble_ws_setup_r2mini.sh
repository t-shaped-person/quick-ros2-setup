#!/bin/bash

echo "@@@@@ install additional packages @@@@@"
sudo apt install -y \
	tilix
pip3 install -U pyserial transforms3d flask
pip3 install setuptools==58.2.0


echo "@@@@@ make workspace and colcon build @@@@@"
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws
colcon build


echo "@@@@@ modify bashrc - shotcut, export @@@@@"
echo "source ~/ros2_ws/install/setup.bash" >> ~/.bashrc
echo "alias sai='sudo apt install'" >> ~/.bashrc
echo "alias cw='cd ~/ros2_ws'" >> ~/.bashrc
echo "alias cs='cd ~/ros2_ws/src'" >> ~/.bashrc
echo "alias cb='cd ~/ros2_ws && colcon build --symlink-install'" >> ~/.bashrc
echo "alias eb='nano ~/.bashrc'" >> ~/.bashrc
echo "alias sb='source ~/.bashrc'" >> ~/.bashrc
echo "#alias nuc='ssh nuc@192.168.1.1'" >> ~/.bashrc
echo "[ -r ~/omorobot_web_data/ros_domain_id ] && export ROS_DOMAIN_ID=$(cat ~/omorobot_web_data/ros_domain_id)" >> ~/.bashrc
echo "export LIDAR_MODEL=TMINIPRO" >> ~/.bashrc
echo "export MOTOR_MODEL=NEW" >> ~/.bashrc
echo "export ROBOT_MODEL=R2MINI" >> ~/.bashrc


echo "@@@@@ ros2 packages clone and colcon build @@@@@"
cd ~/ros2_ws/src
git clone https://github.com/t-shaped-person/omorobot.git -b humble
git clone https://github.com/YDLIDAR/ydlidar_ros2_driver.git -b humble
git clone https://github.com/YDLIDAR/YDLidar-SDK.git
cd ~/ros2_ws
mkdir ~/ros2_ws/src/YDLidar-SDK/build
cd ~/ros2_ws/src/YDLidar-SDK/build
cmake ..
make
sudo make install
cd ~/ros2_ws
colcon build --symlink-install
colcon build --symlink-install


cd ~
echo -e '#!/bin/bash\n\ngnome-terminal -- bash -c "export LIDAR_MODEL="TMINIPRO" && export ROBOT_MODEL="R2MINI" && export MOTOR_MODEL="NEW" && source /opt/ros/humble/setup.bash && source ~/ros2_ws/install/setup.bash && ros2 launch omorobot_web web_launch.py; exec bash"' > ~/web_server.sh
chmod 777 web_server.sh


echo -e "\033[31m"workspace setup is done"\033[0m"
echo -e "\033[31m"system is rebooting in 5sec"\033[0m"
sleep 1
echo -e "\033[31m"system is rebooting in 4sec"\033[0m"
sleep 1
echo -e "\033[31m"system is rebooting in 3sec"\033[0m"
sleep 1
echo -e "\033[31m"system is rebooting in 2sec"\033[0m"
sleep 1
echo -e "\033[31m"system is rebooting in 1sec"\033[0m"
sleep 1
sudo reboot now
exit 0
