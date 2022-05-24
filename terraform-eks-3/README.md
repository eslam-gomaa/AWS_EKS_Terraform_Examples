
# Terraform EKS Example 3

<br>

- This terraform code implements the follwing
  - Provision the basic infrastructure (vpc, subnets, security groups ... etc.)
  - Provisons and EKS cluster
  - Provisons an openSearch cluster (ElasticSearch + Kibana)

- The [post-script.sh](post-script.sh) script deploys the following (with Helm):
  - Deploy HAProxy Ingress controller
  - Deploy Nginx (as a test)
  - Install LogStash & Filebeat (And connect them to ElasticSearch)

<br>


---

## Usage

#### Provide the AK/SK

```bash
export AWS_ACCESS_KEY_ID=''
export AWS_SECRET_ACCESS_KEY=''
export AWS_REGION='us-east-1'
```


### Run
```bash
cd terraform-eks-23

terraform init
terraform plan
terraform apply
```


##### Get the kubeconfig file
```bash
 aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)
```


##### Test
```
kubectl get nodes
```

### Run Post Script (if not run as part of Terraform)

```
bash post-script.sh
```


---


