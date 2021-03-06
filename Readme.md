# Deploy Sock-Shop on k3s with Istio
Rollout the Sock-Shop application on bare metal VM (VM on a cloud provider) with k3s and istio gateway.  
(tested with Azure VM Standard D2s v3 - 2 vCP, 8 GB)

    #install k3s
    cd ~
    curl -sfL https://get.k3s.io | INSTALL_K3S_CHANNEL=v1.19 K3S_KUBECONFIG_MODE="644" INSTALL_K3S_EXEC="--disable=traefik" sh -s -
    
    #install istio
    echo "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml" >> .profile; source ~/.profile
    curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.9.1 sh -
    sudo mv istio-1.9.1/bin/istioctl /usr/local/bin/istioctl
    istioctl install -y
    kubectl label namespace default istio-injection=enabled
    
    #sock-shop
    kubectl create -f https://raw.githubusercontent.com/JLLormeau/sock-shop/main/sock-shop.yaml
    
    #waiting for front-end pod report READY before installing istio gateway > 3 minutes
    while [[ `kubectl get pods -n sock-shop | grep front-end | grep "0/"` ]];do kubectl get pods -n sock-shop;echo "==> waiting for front-end pod ready";sleep 1; done
    kubectl apply -f https://raw.githubusercontent.com/JLLormeau/sock-shop/main/ingress-istio.yaml

Verify istio:

    istioctl analyze
    
Restart k3s server:

    sudo systemctl restart k3s

Uninstall k3s : 

    /usr/local/bin/k3s-uninstall.sh
    

# Deploy Sock-Shop on k3s with traefik
Rollout the Sock-Shop application on bare metal VM (VM on a cloud provider) with k3s and traefik ingress controler.  

Deploy k3s with trafik:

    #install k3s
    curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.21.5+k3s2 K3S_KUBECONFIG_MODE="644" sh -s -

    #ingress traefik
    ip=""; while [[ -z $ip ]]; do `kubectl get svc traefik -n kube-system`; export ip=`kubectl get svc traefik -n kube-system -o=json 2>&1 |grep \"ip\": | cut -d: -f2 | cut -d\" -f2`; sleep 1 ; done
    
    #sock-shop
    kubectl create -f https://raw.githubusercontent.com/JLLormeau/sock-shop/main/sock-shop.yaml
    kubectl create -f https://raw.githubusercontent.com/JLLormeau/sock-shop/main/ingress-traefik.yaml
    
    #access
    while [[ `wget $ip 2>&1| grep 404` ]];do echo "."; sleep 1;  done
    echo "=>> sock-shop is ready !!" 
    
Verify Traefik:

    kubectl get svc traefik -n kube-system

Restart Traefik:

    kubectl -n kube-system scale deploy traefik --replicas 0
    kubectl -n kube-system scale deploy traefik --replicas 1
    
Uninstall : 

    /usr/local/bin/k3s-uninstall.sh
    


# Deploy Sock-Shop on microk8s
Rollout the Sock-Shop application on bare metal VM (VM on a cloud provider) with k3s and traefik ingress controler.
   

Install microk8S : 

    cd ~
    git clone https://github.com/JLLormeau/sock-shop.git
    cd sock-shop
    sh ./install-microk8s.sh
    
Configure microk8S : 

    cd ~/sock-shop
    sh ./config-microk8s.sh
    
Deploy Sock-Shop : 

    cd ~/sock-shop
    kubectl create namespace sock-shop
    kubectl apply -f complete-demo.yaml
    kubectl patch svc front-end --type='json' -p '[{"op":"replace","path":"/spec/type","value":"ClusterIP"}]' -n sock-shop
    kubectl apply -f ingress.yaml
    kubectl -n sock-shop create rolebinding default-view --clusterrole=view --serviceaccount=sock-shop:default

Uninstall  :

    microk8s.reset
    snap remove microk8s

# Useful commands

Sock-Shop : 

    kubectl get all -n sock-shop

Verify Ingress : 

    kubectl get ingress -n sock-shop
    
Restart sock-shop: 

    kubectl -n sock-shop rollout restart deploy
    
# Dynatrace Operator Installation

Settings > Processes and containers > Container monitoring  
    Containerd containers => Enable  
