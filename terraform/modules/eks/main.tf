variable "cluster_name" {
    description = "The name of the EKS cluster"
}

variable "subnets" {
    description = "The subnets to deploy the EKS cluster into"
    type = list(string)
}

variable "vpc_id" {
    description = "The ID of the VPC"
    type = string
  
}

variable "desired_capacity" {
    description = "The desired capacity of the EKS node group"
    type = number
  
}

variable "instance_type" {
    description = "The instance type of the EKS node group"
    type = string
  
}

module "eks" {
    source = "terraform-aws-modules/eks/aws"
    cluster_name = var.cluster_name
    cluster_version = "1.27"
    subnet_ids = var.subnets
    vpc_id = var.vpc_id
    eks_managed_node_groups = {
        eks_node = {
            desired_capacity = var.desired_capacity
            instance_type = var.instance_type
            metadata_options = {
                instance_metadata_tags = "disabled"
            }
        }
        
    }
}

