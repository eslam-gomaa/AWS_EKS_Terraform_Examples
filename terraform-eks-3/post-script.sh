#!/bin/bash

sleep 3

# Update the kubeconfig file.
aws eks --region $(terraform output --raw region) update-kubeconfig --name $(terraform output --raw EKS_cluster_name)

sleep 3

# Install HAProxy Ingress controller
sh scripts/install-haproxy-controller.sh

# Install Nginx (as an test)
sh scripts/install-nginx-example.sh

# nstall LogStash & FileBeat 
bash scripts/install-logstash-filebeat.sh $(terraform output --raw opensearch_endpoint)