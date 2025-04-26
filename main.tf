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

# Módulo Cert-Manager
module "cert_manager" {
  source = "./modules/cert-manager"

  aws_region           = var.aws_region
  eks_cluster_name     = var.eks_cluster_name
  eks_cluster_endpoint = var.eks_cluster_endpoint
  eks_cluster_ca_cert  = var.eks_cluster_ca_cert

  base_domain       = var.base_domain
  letsencrypt_email = var.cert_manager_letsencrypt_email

  # Configurações opcionais
  namespace            = var.cert_manager_namespace
  chart_version        = var.cert_manager_chart_version
  enabled              = var.cert_manager_enabled
  create_namespace     = var.cert_manager_create_namespace
  create_clusterissuer = var.cert_manager_create_clusterissuer
  letsencrypt_server   = var.cert_manager_letsencrypt_server

  tags = {
    Environment = "production"
    ManagedBy   = "terraform"
  }

  # Adiciona dependência explícita do external_dns
  depends_on = [module.external_dns]
}

# Módulo Nginx Ingress Controller
module "nginx_ingress" {
  source = "./modules/nginx-ingress"

  aws_region           = var.aws_region
  eks_cluster_name     = var.eks_cluster_name
  eks_cluster_endpoint = var.eks_cluster_endpoint
  eks_cluster_ca_cert  = var.eks_cluster_ca_cert

  # Configurações principais
  enabled                  = var.nginx_ingress_enabled
  namespace                = var.nginx_ingress_namespace
  create_namespace         = var.nginx_ingress_create_namespace
  chart_version            = var.nginx_ingress_chart_version
  service_type             = var.nginx_ingress_service_type
  load_balancer_type       = var.nginx_ingress_load_balancer_type
  create_irsa              = var.nginx_ingress_create_irsa
  is_default_ingress_class = var.nginx_ingress_is_default_class

  # Configurações de recursos
  resources = {
    requests = {
      cpu    = var.nginx_ingress_cpu_request
      memory = var.nginx_ingress_memory_request
    }
    limits = {
      cpu    = var.nginx_ingress_cpu_limit
      memory = var.nginx_ingress_memory_limit
    }
  }

  tags = {
    Environment = "production"
    ManagedBy   = "terraform"
  }

  # Adiciona dependência dos outros módulos
  depends_on = [module.cert_manager]
}

# Módulo Metrics Server (substituindo o Prometheus)
module "metrics_server" {
  source = "./modules/metrics-server"

  aws_region           = var.aws_region
  eks_cluster_name     = var.eks_cluster_name
  eks_cluster_endpoint = var.eks_cluster_endpoint
  eks_cluster_ca_cert  = var.eks_cluster_ca_cert

  # Configurações principais
  enabled   = var.metrics_server_enabled
  namespace = var.metrics_server_namespace

  # Versão do chart
  chart_version = var.metrics_server_chart_version

  # Configurações de recursos
  resources = {
    requests = {
      cpu    = var.metrics_server_cpu_request
      memory = var.metrics_server_memory_request
    }
    limits = {
      cpu    = var.metrics_server_cpu_limit
      memory = var.metrics_server_memory_limit
    }
  }

  tags = {
    Environment = "production"
    ManagedBy   = "terraform"
  }
}
