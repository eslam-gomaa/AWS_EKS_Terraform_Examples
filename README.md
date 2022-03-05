# AWS_EKS_Terraform_Examples
Different strategies to deploy EKS on AWS with Terraform


<br>

```bash
export AWS_ACCESS_KEY_ID=''
export AWS_SECRET_ACCESS_KEY=''
export AWS_REGION='us-east-1'
```

<br>


| col2                                               | col3                                                         |
| -------------------------------------------------- | ------------------------------------------------------------ |
| [Cluster with only Public subnets](Example-1)      | Cluster Nodes & Load balancers will be deployed in the public subnets |
| [Cluster with Private & Public subnets](Example-2) | - Nodes will be deployed in the private subnets - Load balancers will be deployed in the public subnets |
| [Test Case](Test-Case)                             | HAProxy Ingress controller                                   |