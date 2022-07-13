
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

This will do the following:
1. Update the kubeconfig file
2. Install HAProxy ingress controller (Will provision an NLB)
3. Install Nginx (as a test)
4. Install FileBeat & Logtash (configured to send the ELK cluster logs to the provisioned opensearch cluster)

```
bash post-script.sh
```


---

> Kibana Dashboard

![image](https://user-images.githubusercontent.com/33789516/170109479-14aa1ae8-091b-467e-b795-5ec30e9163db.png)

<br>

> Terraform Output

![image](https://user-images.githubusercontent.com/33789516/170109650-9562c405-5562-463d-a473-27993c1e1394.png)

<br>

> The Test nginx app

Get the Network LB dns name

```
aws elbv2 describe-load-balancers --region us-east-1 --query 'LoadBalancers[*].DNSName' | jq -r 'to_entries[ ] | .value'
```

![image](https://user-images.githubusercontent.com/33789516/170110846-f3467821-02c4-4aff-9cb1-b00870985318.png)

<br>


The End.

