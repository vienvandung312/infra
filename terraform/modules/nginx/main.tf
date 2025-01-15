data "aws_availability_zones" "available" {}

variable "key_pair_name" {
    description = "The name of the key pair to use for the instances"
    type = string
}

resource "aws_lightsail_instance" "nginx_instance" {
    count = 1 
    name = "nginx-${count.index}"
    availability_zone = element(data.aws_availability_zones.available.names, count.index)
    blueprint_id = "ubuntu_24_04"
    bundle_id = "nano_3_0"
    tags = {
        Name = "nginx-${count.index}"
    }
    key_pair_name = var.key_pair_name
}

output "nginx_public_ips" {
    value = aws_lightsail_instance.nginx_instance[*].public_ip_address
}
