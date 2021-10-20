# Deploy Sock-Shop 
on bare metal k3s with ingress controler  
and namespace = sock-shop  

Deploy k3s :

    curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.21.5+k3s2 K3S_KUBECONFIG_MODE="644" sh -s - 
    
Verify Traefik:

    kubectl get svc traefik -n kube-system

Restart Traefik:

    kubectl -n kube-system scale deploy traefik --replicas 0
    kubectl -n kube-system scale deploy traefik --replicas 1

Deploy sock-shop:

    kubectl create -f https://raw.githubusercontent.com/JLLormeau/sock-shop/main/sock-shop.yaml
    
Verify Ingress : 

    kubectl get ingress -n sock-shop
    

Restart sock-shop: 

    kubectl -n sock-shop rollout restart deploy


Uninstall : 

    /usr/local/bin/k3s-uninstall.sh
    
   
