
output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.demo_ec2.id
}

output "private_ip" {
  description = "Private IP address of EC2"
  value       = aws_instance.demo_ec2.private_ip
}

output "ami_id" {
  description = "Amazon Linux AMI selected for deployment"
  value       = data.aws_ami.amazon_linux.id
}
