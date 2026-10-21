data "aws_availability_zones" "available" {
  state = "available"
}

terraform {
  backend "s3" {}
}


locals{
    name="${var.project_name}-${var.environment}"
    az = var.availability_zone != null ? var.availability_zone : data.aws_availability_zones.available.names[0]

    common_tags={
        name=var.project_name
        environment=var.environment
    }
}

resource "aws_vpc" "demo_vpc"{
    cidr_block=var.cidr_block
    enable_dns_hostnames=true
    tags=merge(local.common_tags,{Name="${local.name}-VPC"})
}

resource "aws_internet_gateway" "demo_igw"{
    vpc_id=aws_vpc.demo_vpc.id
    tags=merge(local.common_tags,{Name="${local.name}-IGW"})
}

resource "aws_subnet" "demo_public_subnet"{
    vpc_id=aws_vpc.demo_vpc.id
    cidr_block=var.public_subnet_cidr
    availability_zone=local.az
    map_public_ip_on_launch=true
    tags=merge(local.common_tags,{Name="${local.name}-Public-Subnet" 
                                    tier="public"})
}    

resource "aws_subnet" "demo_private_subnet"{
    vpc_id=aws_vpc.demo_vpc.id
    cidr_block=var.private_subnet_cidr
    availability_zone=local.az
    map_public_ip_on_launch=false
    tags=merge(local.common_tags,{Name="${local.name}-Private-Subnet" 
                                    tier="private"})
}

resource "aws_route_table" "demo_public_rt"{
    vpc_id=aws_vpc.demo_vpc.id
    tags=merge(local.common_tags,{Name="${local.name}-Public-Route-Table"})
}

resource "aws_route" "demo_public_route"{
    route_table_id=aws_route_table.demo_public_rt.id
    destination_cidr_block="0.0.0.0/0"
    gateway_id=aws_internet_gateway.demo_igw.id
}

resource "aws_route_table_association" "demo_public_rt_assoc"{
    subnet_id=aws_subnet.demo_public_subnet.id
    route_table_id=aws_route_table.demo_public_rt.id
}

resource "aws_route_table" "demo_private_rt"{
    vpc_id=aws_vpc.demo_vpc.id
    tags=merge(local.common_tags,{Name="${local.name}-Private-Route-table"})
}

resource "aws_route_table_association" "demo_private_rt_assoc"{
    subnet_id=aws_subnet.demo_private_subnet.id
    route_table_id=aws_route_table.demo_private_rt.id
}