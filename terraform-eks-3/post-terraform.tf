

// Update the kubeconfig file.
resource "null_resource" "kubectl" {
  depends_on = [aws_eks_cluster.eks_cluster]
  
  provisioner "local-exec" {
    command = "aws eks --region ${var.region} update-kubeconfig --name ${aws_eks_cluster.eks_cluster.name}"
  }
}

// Install the ingress controller
resource "null_resource" "haproxy_ingress_controller" {
  depends_on = [null_resource.kubectl]

  provisioner "local-exec" {
    command = "sh scripts/install-haproxy-controller.sh"
  }

  provisioner "local-exec" {
    command = "sh scripts/install-nginx-example.sh"
  }
}
