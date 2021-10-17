#!/bin/sh

export user=`whoami`

sudo apt udpate
sudo apt install snapd
sudo apt install parter
sudo apt install docker.io
sudo apt install python3-jmespath
sudo apt install ntp
sudo apt install vim
sudo apt install tree

sudo snap install microk8s --classic --channel=1.22/stable
sudo usermod -a -G microk8s $user
sudo chown -f -R $user ~/.kube
newgrp microk8s


/snap/bin/microk8s.kubectl

#bash -c "echo \"--allow-privileged=true\" >> /var/snap/microk8s/current/args/kube-apiserver"
sudo snap alias microk8s.kubectl kubectl

/snap/bin/microk8s.enable dns
/snap/bin/microk8s.enable storage
/snap/bin/microk8s.enable registry
/snap/bin/microk8s.enable ingress


/snap/bin/microk8s.start
/snap/bin/microk8s.status --wait-ready

kubectl create namespace sock-shop
kubectl apply -f complete-demo.yaml
kubectl apply -f ingress.yaml
