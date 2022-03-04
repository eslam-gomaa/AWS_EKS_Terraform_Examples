
# Following AWS Best Practices for deploying EKS



##### Get the kubeconfig file
```bash

 aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)
```


##### Test
```
kubectl get svc
```






