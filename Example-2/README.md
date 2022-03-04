
# Following AWS Best Practices for deploying EKS


##### Create the key pair 
```bash
aws ec2 create-key-pair --key-name key1  --egion us-east-1 --query 'KeyMaterial' --output text > key1.pem
```

##### Run
```bash
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





