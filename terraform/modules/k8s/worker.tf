data "aws_availability_zones" "available" {}


resource "aws_lightsail_instance" "k8s_worker" {
    count = 2
    name = "k8s-worker-${count.index}"
    availability_zone = element(data.aws_availability_zones.available.names, count.index)
    blueprint_id = "ubuntu_24_04"
    bundle_id = "small_3_0"
    tags = {
        Name = "k8s-worker-${count.index}"
        Type = "worker"
    }
    key_pair_name = var.key_pair_name
}

output "k8s_worker_public_ips" {
    value = aws_lightsail_instance.k8s_worker[*].public_ip_address
}

