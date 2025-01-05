variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default = "10.0.0.0/16"
}

resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr_block
}

output "vpc_id" {
    value = aws_vpc.main.id
}