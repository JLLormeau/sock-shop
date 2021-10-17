#!/bin/sh

export user=`whoami`

#add privilege on local user
#sudo usermod -a -G microk8s $user
sudo chown -f -R $user ~/.kube
newgrp microk8s

#alias kubecetl
sudo snap alias microk8s.kubectl kubectl

#add on
/snap/bin/microk8s.enable dns
/snap/bin/microk8s.enable storage
/snap/bin/microk8s.enable registry
/snap/bin/microk8s.enable ingress

#start
/snap/bin/microk8s.start
/snap/bin/microk8s.status --wait-ready

