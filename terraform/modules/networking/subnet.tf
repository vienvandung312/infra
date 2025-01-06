data "aws_availability_zones" "available" {}

resource "aws_subnet" "private_subnets" {
    count = 2
    vpc_id = local.vpc_id
    cidr_block = cidrsubnet(var.vpc_cidr_block, 8, count.index)
    availability_zone = element(data.aws_availability_zones.available.names, count.index)
    map_public_ip_on_launch = false
    tags = {
        Name = "Private Subnet ${count.index + 1}"
    }
}

resource "aws_subnet" "public_subnets" {
    count = 2
    vpc_id = local.vpc_id
    cidr_block = cidrsubnet(var.vpc_cidr_block, 8, count.index + length(aws_subnet.private_subnets))
    availability_zone = element(data.aws_availability_zones.available.names, count.index)
    map_public_ip_on_launch = true
    tags = {
        Name = "Public Subnet ${count.index + 1}"
    }
}

output "private_subnets_ids" {
    value = aws_subnet.private_subnets[*].id
}

output "public_subnets_ids" {
    value = aws_subnet.public_subnets[*].id
}

locals {
    private_subnets_ids = aws_subnet.private_subnets[*].id
    public_subnets_ids = aws_subnet.public_subnets[*].id
}