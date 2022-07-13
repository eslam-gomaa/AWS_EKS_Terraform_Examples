
#######################
#      EKS output     #
#######################
output "region" {
  description = "AWS region"
  value       = var.region
}

output "EKS_cluster_name" {
  description = "Kubernetes Cluster Name"
  value = var.eks_cluster_name
}

output "update_kubeconfig_command" {
  value = "aws eks --region ${var.region} update-kubeconfig --name ${var.eks_cluster_name}"
}

output "NLB_dns_name_command" {
  value = "aws elbv2 describe-load-balancers --region ${var.region} --query 'LoadBalancers[*].DNSName' | jq -r 'to_entries[ ] | .value'"
}

output "NLB_dns_status_command" {
  value = "aws elbv2 describe-load-balancers --region ${var.region} --query 'LoadBalancers[*].State.Code' | jq -r 'to_entries[ ] | .value'"
}

#######################
#  OpenSearch output  #
#######################
output "kibana_url" {
  description = "Kibana dashboard URL"
  value = element(aws_elasticsearch_domain.elasticsearch_cluster[*].kibana_endpoint, 0)
}

output "opensearch_username" {
  value = var.opensearch_username
}

output "opensearch_password" {
  value = var.opensearch_password
}

output "OpenSearch_domain_name" {
  value = element(aws_elasticsearch_domain.elasticsearch_cluster[*].domain_name, 0)
}

output "opensearch_endpoint" {
  value = element(aws_elasticsearch_domain.elasticsearch_cluster[*].endpoint, 0)
}



############################
# Test EC2 instance output #
############################


output "ssh_login_command" {
  value = "ssh -i ./${var.key_pair_name}.pem ec2-user@${aws_instance.Bastion_Host.public_ip}"
}

output "public_ec2_key_pair_name" {
  value = var.key_pair_name
}

output "public_ec2_public_ip" {
  value = aws_instance.Bastion_Host.public_ip
}






### Not needed ###

# output "endpoint" {
#   value = aws_eks_cluster.eks_cluster.endpoint
# }

# output "kubeconfig-certificate-authority-data" {
#   value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
# }


# aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw EKS_cluster_name)
