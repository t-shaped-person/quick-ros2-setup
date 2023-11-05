#!/bin/bash

echo "@@@@@ Set locale @@@@@"
locale  # check for UTF-8
sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8
locale  # verify settings


echo "@@@@@ Setup Sources @@@@@"
sudo apt install software-properties-common
sudo add-apt-repository universe
sudo apt update && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null


echo "@@@@@ Install ROS 2 packages @@@@@"
sudo apt update
sudo apt upgrade -y
sudo apt install -y \
	ros-humble-desktop \
	ros-dev-tools \
	nano git net-tools openssh-server \
	python3-pip \
	ros-humble-gazebo-ros \
	ros-humble-navigation2 \
	ros-humble-nav2-bringup \
	ros-humble-gazebo-ros-pkgs \
	ros-humble-cartographer-ros \
	python3-colcon-common-extensions


echo "@@@@@ Sourcing the setup script @@@@@"
echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
source ~/.bashrc
sudo rosdep init
rosdep update


echo -e "\033[31m"ros2 humble installation is done"\033[0m"
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
