variable "aws_region" {
  description = "Região da AWS onde os recursos serão criados"
  type        = string
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
