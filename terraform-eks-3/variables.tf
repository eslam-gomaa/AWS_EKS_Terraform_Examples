
variable "region" {
  type = string
  default = "us-east-1"
}

variable "bastion_host_ami" {
  type = string
  default = "ami-0e322da50e0e90e21"
}

# variable "key_pair_name" {
#     type    = string
#     default = "key1"
# }

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

variable "opensearch_version" {
  type = string
  default = "7.10"
}

variable "opensearch_username" {
  type = string
  default = "admin"
}

variable "opensearch_password" {
  type = string
  default = "Password_123"
}

variable "opensearch_master_nodes_instance_type" {
  type = string
  default = "r5.2xlarge.elasticsearch"
}

variable "opensearch_master_nodes_count" {
  type = number
  default = 3
}

variable "opensearch_data_nodes_instance_type" {
  type = string
  default = "r5.2xlarge.elasticsearch"
}

variable "opensearch_data_nodes_count" {
  type = number
  default = 2
}

variable "opensearch_warm_nodes_instance_type" {
  type = string
  default = "ultrawarm1.medium.elasticsearch"
  # options: [ultrawarm1.medium.elasticsearch ultrawarm1.large.elasticsearch ultrawarm1.xlarge.elasticsearch]
}

variable "opensearch_warm_nodes_count" {
  type = number
  default = 2
}
