#Deploy Sock-Shop on bare metal microk8s


microk8S : 

    cd ~
    git clone https://github.com/JLLormeau/sock-shop.git
    cd sock-shop
    chmod +x install-microk8s.sh
    ./install-microk8s.sh

sock-shop : 

    cd ~/sock-shop
    kubectl create namespace sock-shop
    kubectl apply -f complete-demo.yaml
    kubectl patch svc front-end --type='json' -p '[{"op":"replace","path":"/spec/type","value":"ClusterIP"}]' -n sock-shop
    kubectl apply -f ingress.yaml
    kubectl -n sock-shop create rolebinding default-view --clusterrole=view --serviceaccount=sock-shop:default![image](https://user-images.githubusercontent.com/40337213/137643555-f9c7e290-4f56-42c6-b6b8-6beebddfeff6.png)

