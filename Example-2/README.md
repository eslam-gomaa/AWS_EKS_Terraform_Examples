
# Following AWS Best Practices for deploying EKS


**Note**
##### To create 2 test instacnes (one in Private & one in Public subnet)

```bash
# Move the terrafom file to the main directory so that the resources declared within it will be provisioned
mv available/Test_instances.tf .

# Create the key pair will be used to provision the instances
aws ec2 create-key-pair --key-name key1  --egion us-east-1 --query 'KeyMaterial' --output text > key1.pem
```

---


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





