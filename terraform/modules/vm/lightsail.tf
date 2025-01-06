data "aws_availability_zones" "available" {}

resource "aws_lightsail_instance" "k3s_node" {
    name = "k3s-lightsail"
    availability_zone = data.aws_availability_zones.available.names[0]
    blueprint_id = "ubuntu_22_04"
    bundle_id = "nano_2_0"
    tags = {
        Name = "k3s-lightsail"
    }
}

output "instance_ip" {
    value = aws_lightsail_instance.k3s_node.public_ip_address
}