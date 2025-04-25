variable "aws_region" {
  description = "Região AWS onde o cluster EKS está localizado"
  type        = string
}

variable "eks_cluster_name" {
  description = "Nome do cluster EKS onde o Metrics Server será instalado"
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

variable "enabled" {
  description = "Define se o módulo está habilitado ou não"
  type        = bool
  default     = true
}

variable "namespace" {
  description = "Namespace onde o Metrics Server será instalado"
  type        = string
  default     = "kube-system"
}

variable "chart_version" {
  description = "Versão do chart Helm do Metrics Server"
  type        = string
  default     = "3.10.0"
}

variable "resources" {
  description = "Recursos para o Metrics Server"
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
      cpu    = "300m"
      memory = "512Mi"
    }
  }
}

variable "tags" {
  description = "Tags a serem aplicadas aos recursos"
  type        = map(string)
  default     = {}
} 
