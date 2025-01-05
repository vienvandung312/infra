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
    vpc_cidr_block = "10.0.1.0/16"
}

