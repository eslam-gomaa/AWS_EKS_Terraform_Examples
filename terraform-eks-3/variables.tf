
variable "region" {
  type = string
  default = "us-east-1"
}

variable "bastion_host_ami" {
  type = string
  default = "ami-0e322da50e0e90e21"
}

variable "key_pair_name" {
    type    = string
    default = "key1"
}

variable "vpcCidrBlock" {
  type = string
  default = "10.0.0.0/16"
}

# Subnets when the Nodes will be launched
variable "private_subnets" {
  type = list
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

# 2 small Subnets dedicated for EKS network interfaces
# Nodes & Load balancers will be launched in seperate subnets.
variable "eks_interfaces_subnets" {
  type = list
  default = ["10.0.200.0/28", "10.0.201.0/28"]
}

# Subnets when the External Load balancers will be launched
variable "public_subnets" {
  type = list
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "ssh_ingress_cidrBlock" {
  type   = list
  default = ["0.0.0.0/0"]
}

variable "eks_cluster_name" {
  type = string
  default = "my_eks_cluster"
}

variable "instance_typ" {
  type    = string
  default = "t2.small"
}

variable "eks_cluster_version" {
  type = number
  default = 1.19
}

variable "opensearch_cluster_name" {
  type = string
  default = "benchmarking-test"
}



### Not needed ###

//
//variable "map_accounts" {
//  description = "Additional AWS account numbers to add to the aws-auth configmap."
//  type        = list(string)
//
//  default = [
//    "777777777777",
//    "888888888888",
//  ]
//}
//
//variable "map_roles" {
//  description = "Additional IAM roles to add to the aws-auth configmap."
//  type = list(object({
//    rolearn  = string
//    username = string
//    groups   = list(string)
//  }))
//
//  default = [
//    {
//      rolearn  = "arn:aws:iam::66666666666:role/role1"
//      username = "role1"
//      groups   = ["system:masters"]
//    },
//  ]
//}
//
//variable "map_users" {
//  description = "Additional IAM users to add to the aws-auth configmap."
//  type = list(object({
//    userarn  = string
//    username = string
//    groups   = list(string)
//  }))
//
//  default = [
//    {
//      userarn  = "arn:aws:iam::66666666666:user/user1"
//      username = "user1"
//      groups   = ["system:masters"]
//    }
//  ]
//}