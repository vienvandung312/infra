data "aws_availability_zones" "available" {}

variable "key_pair_name" {
    description = "The name of the key pair to use for the instances"
    type = string
}

resource "aws_lightsail_instance" "k8s_master" {
    count = 1
    name = "k8s-master-${count.index}"
    availability_zone = element(data.aws_availability_zones.available.names, count.index)
    blueprint_id = "ubuntu_24_04"
    bundle_id = "small_3_0"
    tags = {
        Name = "k8s-master-${count.index}"
        Type = "control-plane"
    }
    key_pair_name = var.key_pair_name
}

output "k8s_master_public_ips" {
    value = aws_lightsail_instance.k8s_master[*].public_ip_address
}

