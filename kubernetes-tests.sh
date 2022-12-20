minikube start --nodes 3 --container-runtime=containerd --cpus='2' --memory=2000 --kubernetes-version='1.24.7' -p cluster-multinode --driver=docker 

# Habilitar ingress nginx no minikube:
minikube addons enable ingress

----------------------------------
# Prometheus:
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus prometheus-community/prometheus
kubectl expose service prometheus-server --type=NodePort --target-port=9090 --name=prometheus-server-np
----------------------------------

# Grafana
helm repo add grafana https://grafana.github.io/helm-charts
helm install grafana grafana/grafana
kubectl expose service grafana --type=NodePort --target-port=3000 --name=grafana-np

kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
N5I0TxDmJKfOlJGO3LdV4SBF7VfJVOX2t3qyPGvf
--------------------------------
# Jenkins

docker run -d -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts-jdk11
6da3bd0fb2d04760ae25eaeeeb0bb525

--------------------------------
Longhorn:

# Requirements to install Longhorn:
sudo apt-get install dialog apt-utils
sudo apt install -y open-iscsi
sudo service iscsi start
sudo apt install nfs-common

helm repo add longhorn https://charts.longhorn.io
helm repo update
helm install longhorn longhorn/longhorn --values values.yaml --namespace longhorn-system --create-namespace

# Change default storage class:
kubectl get storageclass
kubectl patch storageclass standard -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
--------------------------------
# Microk8s:
https://www.youtube.com/watch?v=pRVCxNSf-Oo

snap install microk8s
# now enable some essential stuff
microk8s.enable dns storage rbac
 
# install some stuff that might be more optional
microk8s.enable ingress registry
 
# make sure you have ufw disabled or your pods won't have network!
ufw disable
 
# now get the config
mkdir -p ~/.kube
microk8s.config >> ~/.kube/config
---------------------------------
# Nginx:
helm repo add metallb https://metallb.github.io/metallb


helm repo add ingress-nginx  https://kubernetes.github.io/ingress-nginx
helm install nginx ingress-nginx/ingress-nginx --namespace ingress --values values.yaml --create-namespace

