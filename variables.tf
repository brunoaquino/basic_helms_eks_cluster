variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "eks_cluster_name" {
  description = "Nome do cluster EKS"
  type        = string
}

variable "eks_cluster_endpoint" {
  description = "Endpoint do cluster EKS"
  type        = string
}

variable "eks_cluster_ca_cert" {
  description = "Certificado CA do cluster EKS"
  type        = string
}

variable "environment" {
  description = "Ambiente (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "base_domain" {
  description = "Nome de domínio base para o qual o External-DNS terá permissões"
  type        = string
}

variable "external_dns_namespace" {
  description = "Namespace para o External-DNS"
  type        = string
  default     = "external-dns"
}

variable "external_dns_chart_version" {
  description = "Versão do Helm chart do External-DNS"
  type        = string
}

variable "external_dns_domain_filters" {
  description = "Lista de domínios para os quais o External-DNS terá permissões"
  type        = list(string)
  default     = []
}

variable "external_dns_enabled" {
  description = "Flag para habilitar ou desabilitar o External-DNS"
  type        = bool
  default     = true
}

variable "external_dns_aws_zone_type" {
  description = "Tipo de zona Route53 (public ou private)"
  type        = string
  default     = "public"
}

variable "external_dns_policy" {
  description = "Política do External-DNS para criação/atualização de DNS records (sync, upsert-only, create-only)"
  type        = string
  default     = "sync"
}

variable "external_dns_txt_owner_id" {
  description = "ID do proprietário para registros TXT do External-DNS"
  type        = string
  default     = ""
}

variable "external_dns_aws_prefer_cname" {
  description = "Preferência por registros CNAME em vez de registros A"
  type        = bool
  default     = false
}

variable "external_dns_txt_prefix" {
  description = "Prefixo para os registros TXT do External-DNS"
  type        = string
  default     = "external-dns-"
}

# Variáveis para o Cert-Manager
variable "cert_manager_enabled" {
  description = "Flag para habilitar ou desabilitar o Cert-Manager"
  type        = bool
  default     = true
}

variable "cert_manager_namespace" {
  description = "Namespace para o Cert-Manager"
  type        = string
  default     = "cert-manager"
}

variable "cert_manager_chart_version" {
  description = "Versão do Helm chart do Cert-Manager"
  type        = string
  default     = "v1.13.3"
}

variable "cert_manager_create_namespace" {
  description = "Flag para criar o namespace"
  type        = bool
  default     = true
}

variable "cert_manager_letsencrypt_email" {
  description = "Email para registro no Let's Encrypt"
  type        = string
}

variable "cert_manager_create_clusterissuer" {
  description = "Flag para criar o ClusterIssuer"
  type        = bool
  default     = true
}

variable "cert_manager_letsencrypt_server" {
  description = "Servidor do Let's Encrypt (staging ou prod)"
  type        = string
  default     = "staging"

  validation {
    condition     = contains(["staging", "prod"], var.cert_manager_letsencrypt_server)
    error_message = "O valor de cert_manager_letsencrypt_server deve ser 'staging' ou 'prod'."
  }
}

variable "cert_manager_cpu_request" {
  description = "Requisição de CPU para o Cert Manager"
  type        = string
  default     = "100m"
}

variable "cert_manager_memory_request" {
  description = "Requisição de memória para o Cert Manager"
  type        = string
  default     = "128Mi"
}

variable "cert_manager_cpu_limit" {
  description = "Limite de CPU para o Cert Manager"
  type        = string
  default     = "200m"
}

variable "cert_manager_memory_limit" {
  description = "Limite de memória para o Cert Manager"
  type        = string
  default     = "256Mi"
}

# Variáveis para o módulo Metrics Server
variable "metrics_server_enabled" {
  description = "Habilita ou desabilita a instalação do Metrics Server"
  type        = bool
  default     = true
}

variable "metrics_server_namespace" {
  description = "Namespace onde o Metrics Server será instalado"
  type        = string
  default     = "kube-system"
}

variable "metrics_server_chart_version" {
  description = "Versão do chart Helm do Metrics Server"
  type        = string
  default     = "3.10.0"
}

variable "metrics_server_cpu_request" {
  description = "Requisição de CPU para o Metrics Server"
  type        = string
  default     = "100m"
}

variable "metrics_server_memory_request" {
  description = "Requisição de memória para o Metrics Server"
  type        = string
  default     = "128Mi"
}

variable "metrics_server_cpu_limit" {
  description = "Limite de CPU para o Metrics Server"
  type        = string
  default     = "300m"
}

variable "metrics_server_memory_limit" {
  description = "Limite de memória para o Metrics Server"
  type        = string
  default     = "512Mi"
}

# Variáveis para o módulo Nginx Ingress Controller
variable "nginx_ingress_enabled" {
  description = "Habilita ou desabilita a instalação do Nginx Ingress Controller"
  type        = bool
  default     = true
}

variable "nginx_ingress_namespace" {
  description = "Namespace onde o Nginx Ingress Controller será instalado"
  type        = string
  default     = "ingress-nginx"
}

variable "nginx_ingress_create_namespace" {
  description = "Se deve criar o namespace para o Nginx Ingress Controller"
  type        = bool
  default     = true
}

variable "nginx_ingress_chart_version" {
  description = "Versão do chart Helm do Nginx Ingress Controller"
  type        = string
  default     = "4.7.1"
}

variable "nginx_ingress_service_type" {
  description = "Tipo de serviço para o Nginx Ingress Controller (LoadBalancer ou NodePort)"
  type        = string
  default     = "LoadBalancer"
}

variable "nginx_ingress_load_balancer_type" {
  description = "Tipo de balanceador de carga AWS a ser utilizado (classic, nlb ou nlb-ip)"
  type        = string
  default     = "nlb"
}

variable "nginx_ingress_create_irsa" {
  description = "Se deve criar um perfil IAM para usar com Service Account (IRSA)"
  type        = bool
  default     = true
}

variable "nginx_ingress_is_default_class" {
  description = "Se o Nginx Ingress Controller deve ser a classe de ingress padrão"
  type        = bool
  default     = true
}

variable "nginx_ingress_cpu_request" {
  description = "Requisição de CPU para o Nginx Ingress Controller"
  type        = string
  default     = "100m"
}

variable "nginx_ingress_memory_request" {
  description = "Requisição de memória para o Nginx Ingress Controller"
  type        = string
  default     = "128Mi"
}

variable "nginx_ingress_cpu_limit" {
  description = "Limite de CPU para o Nginx Ingress Controller"
  type        = string
  default     = "300m"
}

variable "nginx_ingress_memory_limit" {
  description = "Limite de memória para o Nginx Ingress Controller"
  type        = string
  default     = "256Mi"
}

variable "external_dns_cpu_request" {
  description = "Requisição de CPU para o External DNS"
  type        = string
  default     = "50m"
}

variable "external_dns_memory_request" {
  description = "Requisição de memória para o External DNS"
  type        = string
  default     = "128Mi"
}

variable "external_dns_cpu_limit" {
  description = "Limite de CPU para o External DNS"
  type        = string
  default     = "100m"
}

variable "external_dns_memory_limit" {
  description = "Limite de memória para o External DNS"
  type        = string
  default     = "256Mi"
}
