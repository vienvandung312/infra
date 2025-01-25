#!/bin/bash

echo "[nginx]" > ./ansible/inventory.ini
NGINX_IPS=$(terraform -chdir=$TF_PATH output -json nginx_public_ips | jq -r '.[]')
i=0
for ip in $NGINX_IPS; do
  echo "$ip ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa hostname=nginx$i" >> ./ansible/inventory.ini
  i=$((i+1))
done

echo "[k8s_master]" >> ./ansible/inventory.ini
K8S_IPS=$(terraform -chdir=$TF_PATH output -json k8s_master_public_ips | jq -r '.[]')
i=0
for ip in $K8S_IPS; do
  echo "$ip ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa hostname=master$i" >> ./ansible/inventory.ini
  i=$((i+1))
done

echo "[k8s_worker]" >> ./ansible/inventory.ini
K8S_IPS=$(terraform -chdir=$TF_PATH output -json k8s_worker_public_ips | jq -r '.[]')
i=0
for ip in $K8S_IPS; do
  echo "$ip ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa hostname=worker$i" >> ./ansible/inventory.ini
  i=$((i+1))
done
