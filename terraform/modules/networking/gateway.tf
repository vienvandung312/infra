resource "aws_internet_gateway" "main" {
    vpc_id = local.vpc_id
    tags = {
        Name = "main-igw"
    }
}

resource "aws_eip" "nat" {
    count = 1
    tags = {
        Name = "main-nat-eip"
    }
}

resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.nat.id
    subnet_id = element(local.private_subnets_ids, 0)
    tags = {
        Name = "main-nat"
    }
  
}

locals {
    main_igw_id = aws_internet_gateway.main.id
    main_nat_id = aws_nat_gateway.nat.id
}