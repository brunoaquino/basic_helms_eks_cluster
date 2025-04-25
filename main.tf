provider "aws" {
  region = var.aws_region
}

provider "kubernetes" {
  host                   = var.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(var.eks_cluster_ca_cert)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", var.eks_cluster_name]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = var.eks_cluster_endpoint
    cluster_ca_certificate = base64decode(var.eks_cluster_ca_cert)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", var.eks_cluster_name]
      command     = "aws"
    }
  }
}

# Módulo External-DNS
module "external_dns" {
  source = "./modules/external-dns"

  aws_region           = var.aws_region
  eks_cluster_name     = var.eks_cluster_name
  eks_cluster_endpoint = var.eks_cluster_endpoint
  eks_cluster_ca_cert  = var.eks_cluster_ca_cert

  base_domain   = var.base_domain
  chart_version = var.external_dns_chart_version

  # Configurações opcionais
  namespace        = var.external_dns_namespace
  domain_filters   = var.external_dns_domain_filters
  enabled          = var.external_dns_enabled
  aws_zone_type    = var.external_dns_aws_zone_type
  policy           = var.external_dns_policy
  txt_owner_id     = var.external_dns_txt_owner_id
  txt_prefix       = var.external_dns_txt_prefix
  aws_prefer_cname = var.external_dns_aws_prefer_cname

  tags = {
    Environment = "production"
    ManagedBy   = "terraform"
  }
}
