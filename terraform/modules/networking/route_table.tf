resource "aws_route_table" "public" {
    vpc_id = local.vpc_id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = local.main_igw_id
    }
}

resource "aws_route_table" "private" {
    vpc_id = local.vpc_id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = local.main_nat_id
    }
}

resource "aws_route_table_association" "public" {
    count = length(local.public_subnets_ids)
    subnet_id = element(local.public_subnets_ids, count.index)
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
    count = length(local.private_subnets_ids)
    subnet_id = element(local.private_subnets_ids, count.index)
    route_table_id = aws_route_table.private.id
}