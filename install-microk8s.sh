#!/bin/sh

export user=`whoami`

#before installation
sudo apt udpate
sudo apt -y install snapd
sudo apt -y install parter
sudo apt -y install docker.io
sudo apt -y install python3-jmespath
sudo apt -y install ntp
sudo apt -y install vim
sudo apt -y install tree

#install microk8s v1.22
sudo snap install microk8s --classic --channel=1.22/stable


