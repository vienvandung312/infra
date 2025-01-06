#!/bin/bash

# Install K3s
curl -sfL https://get.k3s.io | sh -

# Install Helm
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# Add Bitnami repository
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

# Create namespace
kubectl create namespace kafka

# Deploy Kafka in KRaft mode
helm install kafka bitnami/kafka -f values.yaml --namespace kafka
