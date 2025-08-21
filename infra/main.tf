module "vpc" {
source = "terraform-aws-modules/vpc/aws"
version = "~> 5.0"


name = "${var.project_name}-vpc"
cidr = "10.0.0.0/16"


azs = slice(data.aws_availability_zones.available.names, 0, 2)
public_subnets = ["10.0.0.0/24", "10.0.1.0/24"]
private_subnets = ["10.0.10.0/24", "10.0.11.0/24"]


enable_nat_gateway = true
single_nat_gateway = true


public_subnet_tags = {
"kubernetes.io/role/elb" = 1
}
private_subnet_tags = {
"kubernetes.io/role/internal-elb" = 1
}
}


module "eks" {
source = "terraform-aws-modules/eks/aws"
version = "~> 20.0"


cluster_name = "${var.project_name}-eks"
cluster_version = var.cluster_version


vpc_id = module.vpc.vpc_id
subnet_ids = module.vpc.private_subnets


eks_managed_node_groups = {
default = {
desired_size = 2
min_size = 1
max_size = 3
instance_types = ["t3.small"]
}
}


enable_cluster_creator_admin_permissions = true
}


output "cluster_name" {
value = module.eks.cluster_name
}


output "region" {
value = var.aws_region
}