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

variable "namespace" {
  description = "Namespace para o External-DNS"
  type        = string
  default     = "external-dns"
}

variable "chart_version" {
  description = "Versão do Helm chart do External-DNS"
  type        = string
}

variable "domain_filters" {
  description = "Lista de domínios para os quais o External-DNS terá permissões"
  type        = list(string)
  default     = []
}

variable "enabled" {
  description = "Flag para habilitar ou desabilitar o External-DNS"
  type        = bool
  default     = true
}

variable "aws_zone_type" {
  description = "Tipo de zona Route53 (public ou private)"
  type        = string
  default     = "public"
}

variable "policy" {
  description = "Política do External-DNS para criação/atualização de DNS records (sync, upsert-only, create-only)"
  type        = string
  default     = "sync"
}

variable "txt_owner_id" {
  description = "ID do proprietário para registros TXT do External-DNS"
  type        = string
  default     = ""
}

variable "aws_prefer_cname" {
  description = "Preferência por registros CNAME em vez de registros A"
  type        = bool
  default     = false
}

variable "txt_prefix" {
  description = "Prefixo para os registros TXT do External-DNS"
  type        = string
  default     = "external-dns-"
}

variable "resources" {
  description = "Recursos para o External DNS"
  type = object({
    requests = object({
      cpu    = string
      memory = string
    })
    limits = object({
      cpu    = string
      memory = string
    })
  })
  default = {
    requests = {
      cpu    = "50m"
      memory = "128Mi"
    }
    limits = {
      cpu    = "100m"
      memory = "256Mi"
    }
  }
}

variable "tags" {
  description = "Tags a serem aplicadas aos recursos"
  type        = map(string)
  default     = {}
}
