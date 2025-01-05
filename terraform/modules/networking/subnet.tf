data "aws_availability_zones" "available" {}

resource "aws_subnet" "private_subnets" {
    count = 2
    vpc_id = local.vpc_id
    cidr_block = cidrsubnet(var.vpc_cidr_block, 8, count.index)
    availability_zone = element(data.aws_availability_zones.available.names, count.index)
}

resource "aws_subnet" "public_subnets" {
    count = 2
    vpc_id = local.vpc_id
    cidr_block = cidrsubnet(var.vpc_cidr_block, 8, count.index + 1)
    availability_zone = element(data.aws_availability_zones.available.names, count.index)
}

output "private_subnets_ids" {
    value = aws_subnet.private_subnets[*].id
}

output "public_subnets_ids" {
    value = aws_subnet.public_subnets[*].id
}