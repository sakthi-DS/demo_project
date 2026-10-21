variable "project_name"{
    description = "The name of the project"
    type        = string
    default     = "demo-project"
    
}

variable "environment" {
    description = "The environment for the project"
    type        = string
    default     = "dev"
}

variable "vpc_id"{
    description = "The ID of the VPC"
    type        = string
}

variable "private_subnet_id"{
    description = "The ID of the private subnet"
    type        = string
}

variable "instance_type" {
    description = "The type of EC2 instance"
    type        = string
    default     = "t2.micro"
}