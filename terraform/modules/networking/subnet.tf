variable "vpc_id" {
    description = "The ID of the VPC"
    type        = string
}

resource "aws_subnet" "private_subnets" {
    count = 1 
    vpc_id = var.vpc_id
    cidr_block = cidrsubnet(var.vpc_cidr_block, 8, count.index)
}

resource "aws_subnet" "public_subnets" {
    count = 1
    vpc_id = var.vpc_id
    cidr_block = cidrsubnet(var.vpc_cidr_block, 8, count.index + 1)
}

output "private_subnets_ids" {
    value = aws_subnet.private_subnets[*].id
}

output "public_subnets_ids" {
    value = aws_subnet.public_subnets[*].id
}