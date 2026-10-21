
include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../modules/vpc"
}
inputs = {
  availability_zone = "ap-south-1a"
}

inputs = {
  project_name        = "demo-project"
  environment         = "dev"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
}
