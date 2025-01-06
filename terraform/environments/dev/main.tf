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

module "vm" {
    source = "../../modules/vm"
    key_pair_name = "k3s-lightsail-key"  
}