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

variable "key_pair_name" {
    type = string
}

variable "public_key" {
    type = string
}   

module "vm" {
    source = "../../modules/vm"
    key_pair_name = var.key_pair_name
    public_key = var.public_key
}

output "instance_ip" {
    value = module.vm.instance_ip
}