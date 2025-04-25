data "aws_eks_cluster" "this" {
  name = var.eks_cluster_name
}

data "aws_caller_identity" "current" {} 
