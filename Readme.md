# Deploy Sock-Shop on bare metal k3s with ingress controler
--namespace = sock-shop

Deploy :

    curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.21.2+k3s1 K3S_KUBECONFIG_MODE="644" sh -s - 
    kubectl create -f https://raw.githubusercontent.com/JLLormeau/sock-shop/main/sock-shop.yaml
    

Uninstall : 

    /usr/local/bin/k3s-uninstall.sh
    
    
