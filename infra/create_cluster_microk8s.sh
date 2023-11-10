hosts=('192.168.0.150' '192.168.0.151' '192.168.0.152')
echo "Creating infrastructure"
vagrant up

echo "Creating cluster"
cd ansible
ansible-playbook -i hosts install-microk8s.yaml

echo "Updating ssh key"
for host in $hosts; do
  ssh-keygen -f "/home/${USER}/.ssh/known_hosts" -R  "$host"; ssh-keyscan "$host"  >> $HOME/.ssh/known_hosts
done

echo "Geting Kubeconfig"
ssh -i /home/${USER}/.vagrant.d/insecure_private_key vagrant@"${hosts[1]}" "microk8s config" > /home/${USER}/.kube/cluster

echo "Adding node 1 to cluster"
ssh -i /home/${USER}/.vagrant.d/insecure_private_key vagrant@"${hosts[1]}" "microk8s add-node" | grep "${hosts[1]}" > join-token
token=`cat join-token`; ssh -i /home/${USER}/.vagrant.d/insecure_private_key vagrant@"${hosts[2]}" "$token"
echo "Adding node 2 to cluster"
ssh -i /home/${USER}/.vagrant.d/insecure_private_key vagrant@"${hosts[1]}" "microk8s add-node" | grep "${hosts[1]}" > join-token
token=`cat join-token`; ssh -i /home/${USER}/.vagrant.d/insecure_private_key vagrant@"${hosts[3]}" "$token"

rm join-token