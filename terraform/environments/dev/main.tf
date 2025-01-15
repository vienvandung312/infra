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
    description = "The name of the key pair to use for the instances"
    type = string
  
}
module "k8s" {
    source = "../../modules/k8s"
    key_pair_name = var.key_pair_name
}

module "nginx" {
  source = "../../modules/nginx"
  key_pair_name = var.key_pair_name
}

output "nginx_public_ips" {
    value = module.nginx.nginx_public_ips
}

output "k8s_node_public_ips" {
    value = module.k8s.k8s_node_public_ips
}