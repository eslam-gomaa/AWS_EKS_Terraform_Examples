

// Update the kubeconfig file.
resource "null_resource" "kubectl" {
  depends_on = [aws_eks_cluster.eks_cluster, aws_elasticsearch_domain.elasticsearch_cluster]

   provisioner "local-exec" {
    command = "sleep 10"
  }
  
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


// Install LogStash & FileBeat
resource "null_resource" "install_logstash_filebeat" {
  depends_on = [aws_eks_cluster.eks_cluster, aws_elasticsearch_domain.elasticsearch_cluster]

  provisioner "local-exec" {
    command = "bash scripts/install-logstash-filebeat.sh $(terraform output --raw opensearch_endpoit)"
  }
}

