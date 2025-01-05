module "eks" {
    source = "terraform-aws-modules/eks/aws"
    cluster_name = "eks-cluster"
    cluster_version = "1.27"
    subnets = module.networking.private_subnets
}