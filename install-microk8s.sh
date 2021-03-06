#!/bin/sh
export user=`whoami`


#before installation
echo "**********sudo apt ...."
sudo apt udpate
sudo apt -y install snapd
sudo apt -y install parter
sudo apt -y install docker.io
sudo apt -y install python3-jmespath
sudo apt -y install ntp
sudo apt -y install vim
sudo apt -y install tree

#install microk8s v1.22
echo "**********snap install ...."
sudo snap install microk8s --classic --channel=1.22/stable

#add privilege on local user
echo "**********usermod"
sudo usermod -a -G microk8s $user
sudo chown -f -R $user ~/.kube
echo "**********newgrp"
newgrp microk8s
