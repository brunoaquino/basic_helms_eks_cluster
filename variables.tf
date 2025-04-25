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
