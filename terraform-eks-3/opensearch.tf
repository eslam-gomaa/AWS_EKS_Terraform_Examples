// https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearch_domain

data "aws_caller_identity" "current" {}

resource "aws_elasticsearch_domain" "elasticsearch_cluster" {
count = 1
domain_name = var.opensearch_cluster_name
elasticsearch_version = "7.4"
  cluster_config {
    # Data nodes settings
    instance_type = "r5.2xlarge.elasticsearch"
    instance_count = 6
    # Master Nodes settings
    dedicated_master_enabled = true
    dedicated_master_count = 3
    dedicated_master_type = "r5.2xlarge.elasticsearch"
    # Warm Nodes settings
    warm_enabled = true
    warm_count = 2
    warm_type = "ultrawarm1.medium.elasticsearch" # options: [ultrawarm1.medium.elasticsearch ultrawarm1.large.elasticsearch ultrawarm1.xlarge.elasticsearch]

    zone_awareness_enabled = true
    zone_awareness_config {
      availability_zone_count = 2
    } 
  }

  ebs_options {
    ebs_enabled = true
    # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volume-types.html
    volume_type = "gp2" # options: [standard gp2 io1]
    # iops = ""
    volume_size = "1800" 
  }
  
  # Required by advanced_security_options
  domain_endpoint_options {
    enforce_https = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  auto_tune_options {
    desired_state = "ENABLED"
    rollback_on_disable = "NO_ROLLBACK"
  }

  # Required by advanced_security_options
  node_to_node_encryption {
    enabled = true
  }

  # Required by advanced_security_options
  encrypt_at_rest {
    enabled = true
  }

  advanced_security_options {
    enabled = true
    internal_user_database_enabled = true
    master_user_options {
      master_user_name = "admin"
      master_user_password = "Password_123"
    }
  }

  snapshot_options {
    automated_snapshot_start_hour = 00  ## Go with the default
  }
  
  tags = {
    Domain = "TestDomain"
  }

  depends_on = [
    aws_eks_cluster.eks_cluster
   ]
}

resource "aws_elasticsearch_domain_policy" "main" {
  depends_on = [
    aws_elasticsearch_domain.elasticsearch_cluster
   ]
  domain_name     = element(aws_elasticsearch_domain.elasticsearch_cluster[*].domain_name, 0)
  access_policies = <<POLICIES
  {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "es:*",
      "Resource": "${element(aws_elasticsearch_domain.elasticsearch_cluster[*].arn, 0)}/*"
    }
  ]
}
POLICIES
}



### Error: ValidationException: Apply a restrictive access policy to your domain
# https://stackoverflow.com/questions/64426133/deployment-of-servless-app-fails-enable-fine-grained-access-control-or-apply-a
# https://aws.amazon.com/premiumsupport/knowledge-center/anonymous-not-authorized-opensearch/
# resource "aws_elasticsearch_domain_policy" "ip_based" {
#   domain_name = element(aws_elasticsearch_domain.elasticsearch_cluster[*].domain_name, 0)
#   access_policies = <<POLICIES
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "arn:aws:iam::549308533038:role/${aws_iam_role.iam-role-eks-cluster.name}"
#       },
#       "Action": "es:*",
#       "Resource": "${element(aws_elasticsearch_domain.elasticsearch_cluster[*].arn, 0)}/*"
#     },
#     {
#       "Sid": "",
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "*"
#       },
#       "Action": "es:*",
#       "Resource": "${element(aws_elasticsearch_domain.elasticsearch_cluster[*].arn, 0)}/*",
#       "Condition": {
#         "IpAddress": {
#           "aws:SourceIp": [
#             "197.42.171.14/32"
#           ]
#         }
#       }
#     }
#   ]
# }
# POLICIES
# }

