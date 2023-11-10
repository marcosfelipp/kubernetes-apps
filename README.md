### Requirements:
- virtualbox
- ansible
- vagrant
- helm
- kubectl

### In the ./infra/ execute:
```bash
vagrant up
```

### In directory ./infra/ansible execute:
```bash
ansible-playbook -i hosts install-microk8s.yaml
```

### SSH to master and init get token to add nodes
```bash
microk8s add-node
```
### From master, get the kubeconfig
```bash
cd $HOME
mkdir .kube
cd .kube
microk8s config > config
```
### Install Longhorn
```bash
helm repo add longhorn https://charts.longhorn.io
helm repo update
helm install longhorn longhorn/longhorn --values values.yaml --namespace longhorn-system --create-namespace
```

