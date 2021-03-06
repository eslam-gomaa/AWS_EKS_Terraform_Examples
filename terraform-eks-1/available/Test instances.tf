
variable "ami" {
    type    = string
    default = "ami-077e31c4939f6a2f3"
}

resource "aws_instance" "Bastion_Host" {
  ami             = var.ami
  key_name        = var.key_pair_name
  instance_type   = "t2.micro"
  subnet_id       = "${element(aws_subnet.public.*.id, 0)}"
  security_groups = [aws_security_group.Public_Security_Group.id]
  tags = {
    Name = "Public Host - Testing"
  }
}

resource "aws_instance" "Private_Host" {
  ami             = var.ami
  key_name        = var.key_pair_name
  instance_type   = "t2.micro"
  subnet_id       = "${element(aws_subnet.private.*.id, 0)}"
  security_groups = [aws_security_group.Private_Security_Group.id]
  tags = {
    Name = "Private Host - Testing"
  }
}
