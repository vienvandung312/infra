data "aws_availability_zones" "available" {}

variable "key_pair_name" {
    description = "The name of the key pair to use for the instance"
    type = string
}

resource "aws_lightsail_instance" "k3s_node" {
    name = "k3s-lightsail"
    availability_zone = data.aws_availability_zones.available.names[0]
    blueprint_id = "ubuntu_22_04"
    bundle_id = "nano_2_0"
    key_pair_name = var.key_pair_name
    tags = {
        Name = "k3s-lightsail"
    }
}

output "instance_ip" {
    value = aws_lightsail_instance.k3s_node.public_ip_address
}