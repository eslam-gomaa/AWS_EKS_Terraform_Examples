# AWS_EKS_Terraform_Examples
Different strategies to deploy EKS on AWS with Terraform along with different use case

<br>

This repo will be organized & populated Over time.  


<br>

### Deploy EKS with Terraform 

* [Cluster with only Public subnets](terraform-eks-1)
* [Cluster with Private & Public subnets](terraform-eks-2)

<br>

## Use Cases

* [Install HAProxy Ingress Controller](Use-Cases/HAProxy-Ingress-Controller/)
* Use your custom DNS name instead of the AWS LB
    * Create a CNAME record in your DNS Provider to the AWS LB
    * Register your DNS to AWS Route53
* [A Sample Application -- Nginx](Use-Cases/sample-app-nginx)
* [Install Prometheus, Grafana, AlertManager](Use-Cases/install_prometheus_grafana_alertmanager)
    * Create `service monitor` (Monitor HAProxy)
    * Create a `service monitor` (Monitor Nginx)
    * 

**Note:** The default Load Balancer Controller is "`AWS cloud provider load balancer controller`"

* Install `AWS Load Balancer Controller`



<br>

