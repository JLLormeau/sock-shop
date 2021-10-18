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

#add privilege on local user
echo "usermod"
sudo usermod -a -G microk8s $user
sudo chown -f -R $user ~/.kube
echo "newgrp"
newgrp microk8s &

#alias kubectl
echo "alias kubectl"
snap alias microk8s.kubectl kubectl

#add on
echo "add on"
/snap/bin/microk8s.enable dns
/snap/bin/microk8s.enable storage
/snap/bin/microk8s.enable registry
/snap/bin/microk8s.enable ingress

#start
echo "start"
/snap/bin/microk8s.start
/snap/bin/microk8s.status --wait-ready

