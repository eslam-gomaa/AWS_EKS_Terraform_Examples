# AWS_EKS_Terraform_Examples
Different strategies to deploy EKS on AWS with Terraform along with different use case

<br>

This repo will be organized & populated Over time.  


<br>

### Deploy EKS with Terraform 

* [Cluster with only Public subnets](Example-1)
* [Cluster with Private & Public subnets](Example-2)

<br>

## Use Cases

* [Install HAProxy Ingress Controller](Use-Cases/HAProxy-Ingress-Controller/)
* [A Sample Application -- Siyuan Note](Use-Cases/sample-app-siyuan/)


<br>


---


| Deploy EKS with Terraform                          | Comments                                                     |
| -------------------------------------------------- | ------------------------------------------------------------ |
| [Cluster with only Public subnets](Example-1)      |  |
| [Cluster with Private & Public subnets](Example-2) |  |
|                                                    |                                                              |


| Use Cases                                                    | Comments                                                     |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [Install HAProxy Ingress Controller](Use-Cases/HAProxy-Ingress-Controller/) | Using the default Load Balancer Controller  "`AWS cloud provider load balancer controller`" |
| [A Sample Application -- Siyuan Note](Use-Cases/sample-app-siyuan/) | Deploy a sample app to the Kubernetes cluster & use the `HAProxy Ingress controller` to access the app Externally. |
| Install & Use the `AWS Load Balancer Controller `              |                                                              |
|                                                              |                                                              |

