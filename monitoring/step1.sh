#!/bin/bash
echo "Wait 3 seconds for katacoda"
sleep 3

check_k8s_ready() {
  return kubectl get nodes --no-headers | grep "Ready"
}

echo "Waiting for kubernetes to start"
i=0
while [ $i -lt 10 ]; do
  i=$((i+1))
  echo "Attempt nr $i"
  [ check_k8s_ready ] && break
  sleep 2
done

# deploy apps
echo "Deploying apps"
export KUBECONFIG="/etc/kubernetes/admin.conf"
kubectl apply -f /tmp/deployment.yml
