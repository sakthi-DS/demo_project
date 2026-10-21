
include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../modules/ec2"
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  project_name  = "demo-project"
  environment   = "dev"
  instance_type = "t3.micro"

  vpc_id            = dependency.vpc.outputs.vpc_id
  private_subnet_id = dependency.vpc.outputs.private_subnet_id
}
