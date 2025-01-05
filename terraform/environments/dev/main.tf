terraform {
  backend "s3" {
    bucket = "main-terraform-state-79810"
    key    = "global/terraform.tfstate"
    region = "ap-southeast-1"
    dynamodb_table = "terraform-state-lock"
  }
}

provider "aws" {
    region = "ap-southeast-1"
}

module "networking" {
    source = "../../modules/networking"
    vpc_cidr_block = "10.0.0.0/16"
}

module "eks" {
    source = "../../modules/eks"
    cluster_name = "main-eks-cluster"
    subnets = module.networking.private_subnets_ids
    vpc_id = module.networking.vpc_id
    desired_capacity = 2
    instance_type = "t3.medium"
}
