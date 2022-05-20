

# Creating IAM role for Kubernetes clusters to make calls to other AWS services on your behalf to manage the resources that you use with the service.

resource "aws_iam_role" "iam-role-eks-cluster" {
  name = "terraformekscluster"
  assume_role_policy = <<POLICY
{
 "Version": "2012-10-17",
 "Statement": [
   {
   "Effect": "Allow",
   "Principal": {
    "Service": "eks.amazonaws.com"
   },
   "Action": "sts:AssumeRole"
   }
  ]
 }
POLICY
}

# Attaching the EKS-Cluster policies to the terraformekscluster role.

resource "aws_iam_role_policy_attachment" "eks-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.iam-role-eks-cluster.name}"
}

resource "aws_iam_role_policy_attachment" "eks-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.iam-role-eks-cluster.name}"
}


# Security group for network traffic to and from AWS EKS Cluster.

# resource "aws_security_group" "eks-cluster" {
#   name        = "SG-eks-cluster"
#   vpc_id      = aws_vpc.main.id 

# # Egress allows Outbound traffic from the EKS cluster to the  Internet 

#   egress {                   # Outbound Rule
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# # Ingress allows Inbound traffic to EKS cluster from the  Internet 

#   ingress {                  # Inbound Rule
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

# }

# Creating the EKS cluster

resource "aws_eks_cluster" "eks_cluster" {
  name     = var.eks_cluster_name
  role_arn =  "${aws_iam_role.iam-role-eks-cluster.arn}"
  version  = var.eks_cluster_version

# Adding VPC Configuration

# Configure EKS with vpc and network settings 
  vpc_config {
  #  security_group_ids = ["${aws_security_group.eks-cluster.id}"]
   security_group_ids = [aws_security_group.Public_Security_Group.id]
   subnet_ids         = aws_subnet.eks_interfaces.*.id
   endpoint_private_access = true # Enable EKS private API server endpoint
   endpoint_public_access  = true # Default is True
    }

  depends_on = [
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSServicePolicy,
   ]
}

# Creating IAM role for EKS nodes to work with other AWS Services. 


resource "aws_iam_role" "eks_nodes" {
  name = "eks-node-group"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# Attaching the different Policies to Node Members.

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_nodes.name
}

# Create EKS cluster node group

resource "aws_eks_node_group" "node" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "node_group1"
  node_role_arn   = aws_iam_role.eks_nodes.arn
  subnet_ids      = aws_subnet.private.*.id

  scaling_config {
    desired_size = 6
    max_size     = 10
    min_size     = 3
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}

// Update the kubeconfig file.
resource "null_resource" "kubectl" {
  depends_on = [aws_eks_cluster.eks_cluster]
  
  provisioner "local-exec" {
    command = "aws eks --region ${var.region} update-kubeconfig --name ${aws_eks_cluster.eks_cluster.name}"
  }

}

// Install the ingress controller
resource "null_resource" "haproxy_ingress_controller" {
  depends_on = [null_resource.kubectl]

  provisioner "local-exec" {
    command = "sh scripts/install-haproxy-controller.sh"
  }

  provisioner "local-exec" {
    command = "sh scripts/nginx-example.sh"
  }

}