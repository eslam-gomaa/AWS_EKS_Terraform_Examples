// https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearch_domain

resource "aws_opensearch_domain" "example" {
  domain_name    = "example"
  engine_version = "Elasticsearch_7.10"

  cluster_config {
    instance_type = "r4.large.search"
  }

  tags = {
    Domain = "TestDomain"
  }
}