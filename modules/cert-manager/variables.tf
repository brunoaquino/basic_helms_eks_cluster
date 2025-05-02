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

variable "namespace" {
  description = "Namespace para o Cert-Manager"
  type        = string
  default     = "cert-manager"
}

variable "chart_version" {
  description = "Versão do Helm chart do Cert-Manager"
  type        = string
}

variable "enabled" {
  description = "Flag para habilitar ou desabilitar o Cert-Manager"
  type        = bool
  default     = true
}

variable "create_namespace" {
  description = "Flag para criar o namespace"
  type        = bool
  default     = true
}

variable "letsencrypt_email" {
  description = "Email para registro no Let's Encrypt"
  type        = string
}

variable "base_domain" {
  description = "Domínio base para o qual o Cert-Manager terá permissões"
  type        = string
}

variable "create_clusterissuer" {
  description = "Flag para criar o ClusterIssuer"
  type        = bool
  default     = true
}

variable "letsencrypt_server" {
  description = "Servidor do Let's Encrypt (staging ou prod)"
  type        = string
  default     = "staging"

  validation {
    condition     = contains(["staging", "prod"], var.letsencrypt_server)
    error_message = "O valor de letsencrypt_server deve ser 'staging' ou 'prod'."
  }
}

variable "resources" {
  description = "Recursos para o Cert Manager"
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
      cpu    = "100m"
      memory = "128Mi"
    }
    limits = {
      cpu    = "200m"
      memory = "256Mi"
    }
  }
}

variable "tags" {
  description = "Tags a serem aplicadas aos recursos"
  type        = map(string)
  default     = {}
}
