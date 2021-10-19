#!/bin/sh

#alias kubectl
echo "**********alias kubectl"
sudo snap alias microk8s.kubectl kubectl

#add on
echo "**********add on"
sudo /snap/bin/microk8s.enable dns
sudo /snap/bin/microk8s.enable storage
sudo /snap/bin/microk8s.enable registry
sudo /snap/bin/microk8s.enable ingress

#start
echo "**********start microk8s...."
sudo /snap/bin/microk8s.start
sudo /snap/bin/microk8s.status --wait-ready
