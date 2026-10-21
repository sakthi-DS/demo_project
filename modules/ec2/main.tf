data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}


terraform {
  backend "s3" {}
}


locals{
    name="${var.project_name}-${var.environment}"
}

resource "aws_instance" "demo_ec2" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_id

  tags = {
    Name        = "${local.name}-EC2"
    environment = var.environment
    
  }
}