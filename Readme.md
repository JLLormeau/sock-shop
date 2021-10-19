# Deploy Sock-Shop 
on bare metal k3s with ingress controler  
and namespace = sock-shop  

Deploy :

    curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.21.5+k3s2 K3S_KUBECONFIG_MODE="644" sh -s - 
    kubectl create -f https://raw.githubusercontent.com/JLLormeau/sock-shop/main/sock-shop.yaml
    

Uninstall : 

    /usr/local/bin/k3s-uninstall.sh
    
    
    cd ~
    git clone https://github.com/JLLormeau/sock-shop.git
    cd sock-shop
    kubectl create namespace sock-shop
    kubectl apply -f complete-demo.yaml
    kubectl patch svc front-end --type='json' -p '[{"op":"replace","path":"/spec/type","value":"ClusterIP"}]' -n sock-shop
    kubectl apply -f ingress.yaml
