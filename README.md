# AWS_EKS_Terraform_Examples
Different strategies to deploy EKS on AWS with Terraform


<br>

```bash
export AWS_ACCESS_KEY_ID=''
export AWS_SECRET_ACCESS_KEY=''
export AWS_REGION='us-east-1'
```

<br>





| Deploy EKS with Terraform                          | Comments                                                     |
| -------------------------------------------------- | ------------------------------------------------------------ |
| [Cluster with only Public subnets](Example-1)      | Cluster Nodes & Load balancers will be deployed in the public subnets |
| [Cluster with Private & Public subnets](Example-2) | - Nodes will be deployed in the private subnets <br />- Load balancers will be deployed in the public subnets<br />- the EKS elastic interfaces will be deployed in dedicated private subnets |
|                                                    |                                                              |



| Use Cases                                                    | Comments                                                     |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [Install HAProxy Ingress Controller](Use-Cases/HAProxy-Ingress-Controller/) v1 | Using the default Load Balancer Controller  "`AWS cloud provider load balancer controller`" |
| [A Sample Application -- Siyuan Note](Use-Cases/sample-app-Siyuan/) | Deploy the sample app to th Kubernetes cluster & use the HAProxy Ingress controller to access the app |
|                                                              |                                                              |

