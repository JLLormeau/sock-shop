# Deploy Sock-Shop 
Rollout the Sock-Shop application on bare metal VM (VM on a cloud provider) with k3s and traefik ingress controler.


Deploy k3s :

    #k3s
    echo "\n*****install k3s"
    curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.21.5+k3s2 K3S_KUBECONFIG_MODE="644" sh -s -

    #ingress traefik
    echo "\n*****waiting for traefik ~1 minute"
    ip=""; while [[ -z $ip ]]; do `kubectl get svc traefik -n kube-system`; export ip=`kubectl get svc traefik -n kube-system -o=json 2>&1 |grep \"ip\": | cut -d: -f2 | cut -d\" -f2`; sleep 1 ; done
    
    #sock-shop
    echo "\n*****install sock-shop (namespace=sock-shop)"
    kubectl create -f https://raw.githubusercontent.com/JLLormeau/sock-shop/main/sock-shop.yaml
    
    #access
    echo "\n*****waiting for sock-shop access > 5 minutes"
    while [[ `wget $ip 2>&1| grep 404` ]];do echo "."; sleep 1;  done
    echo "=>> sock-shop is ready !!" 
    
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
    
   
