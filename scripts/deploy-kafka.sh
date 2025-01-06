#!/bin/bash

# Add Bitnami repository
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

# Create namespace
kubectl create namespace kafka

# Deploy Kafka in KRaft mode
helm install kafka bitnami/kafka -f ./kafka/values.yaml --namespace kafka
