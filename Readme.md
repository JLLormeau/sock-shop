#Deploy Sock-Shop on bare metal microk8s


microk8S : 

    cd ~
    git clone https://github.com/JLLormeau/sock-shop.git
    cd sock-shop
    chmod +x deploy-sock-shop-on-microk8s.sh
    ./install-microk8s.sh
    ./configure-microk8s.sh

sock-shop : 

    cd ~/sock-shop
    kubectl create namespace sock-shop
    kubectl apply -f complete-demo.yaml
    kubectl patch svc front-end --type='json' -p '[{"op":"replace","path":"/spec/type","value":"ClusterIP"}]' -n sock-shop
    kubectl apply -f ingress.yaml

