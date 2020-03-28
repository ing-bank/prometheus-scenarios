#!/bin/bash
echo "Wait 3 seconds for katacoda"
sleep 3

KCTL="kubectl --kubeconfig=/etc/kubernetes/admin.conf"


echo "Waiting for kubernetes to start"
i=0
while [ $i -lt 10 ]; do
  i=$((i+1))
  echo "Attempt nr $i"
  ($KCTL get nodes --no-headers | grep "Ready") && break
  sleep 2
done

# deploy apps
echo "Deploying apps"
$KCTL apply -f /tmp/deployment.yml
