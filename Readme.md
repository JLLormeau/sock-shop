#Deploy Sock-Shop on bare metal microk8s


install microk8S : 

    cd ~
    git clone https://github.com/JLLormeau/sock-shop.git
    cd sock-shop
    sh ./install-microk8s.sh
    
configure microk8S : 

    cd ~/sock-shop
    sh ./config-microk8s.sh
    
sock-shop : 

    cd ~/sock-shop
    kubectl create namespace sock-shop
    kubectl apply -f complete-demo.yaml
    kubectl patch svc front-end --type='json' -p '[{"op":"replace","path":"/spec/type","value":"ClusterIP"}]' -n sock-shop
    kubectl apply -f ingress.yaml
    kubectl -n sock-shop create rolebinding default-view --clusterrole=view --serviceaccount=sock-shop:default


#############
uninstall all :

    microk8s.reset
    snap remove microk8s


############

    curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.21.2+k3s1 K3S_KUBECONFIG_MODE="644" sh -s - 
    kubectl create namespace sock-shop
    kubectl create -f https://raw.githubusercontent.com/JLLormeau/sock-shop/main/sock-shop.yaml
    
###########

    /usr/local/bin/k3s-uninstall.sh
    
    
