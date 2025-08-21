variable "aws_region" {
description = "AWS region"
type = string
default = "eu-west-2"
}


variable "project_name" {
description = "Project name prefix"
type = string
default = "beginner-devops"
}


variable "cluster_version" {
description = "EKS Kubernetes version"
type = string
default = "1.29"
}