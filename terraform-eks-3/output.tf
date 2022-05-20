output "region" {
  description = "AWS region"
  value       = var.region
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value = var.eks_cluster_name
}

# output "endpoint" {
#   value = aws_eks_cluster.eks_cluster.endpoint
# }

# output "kubeconfig-certificate-authority-data" {
#   value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
# }


# aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)
