variable "key_pair_name" {
  type = string
  default = "test_key"
}

# Genreate Private Key
resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create KeyPair on AWS
resource "aws_key_pair" "test_key_pair" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.private_key.public_key_openssh

# Save the KeyPair to the disk
  # provisioner "local-exec" {
  #   command = "echo '${tls_private_key.private_key.private_key_pem}' > ./${var.key_pair_name}.pem"
  # }
}

resource "local_file" "pem_file" {
  filename = pathexpand("~/${var.key_pair_name}.pem")
  file_permission = "600"
  directory_permission = "700" 
  sensitive_content = tls_private_key.private_key.private_key_pem
}


# Privision a Public instance for testing
resource "aws_instance" "Bastion_Host" {
  ami             = var.bastion_host_ami
  key_name        = var.key_pair_name
  instance_type   = "t2.micro"
  subnet_id       = "${element(aws_subnet.public.*.id, 0)}"
  security_groups = [aws_security_group.Public_Security_Group.id]
  tags = {
    Name = "Public Host - Testing"
  }
}

