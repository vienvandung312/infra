provider "aws" {
    region = "ap-southeast-1"
}

module "networking" {
    source = "../../modules/networking"
    vpc_cidr_block = "10.0.1.0/16"
}

