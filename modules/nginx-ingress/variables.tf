variable "aws_region" {
  description = "Região AWS onde o cluster EKS está implantado"
  type        = string
}

variable "eks_cluster_name" {
  description = "Nome do cluster EKS"
  type        = string
}

variable "eks_cluster_endpoint" {
  description = "Endpoint da API do cluster EKS"
  type        = string
}

variable "eks_cluster_ca_cert" {
  description = "Certificado CA do cluster EKS"
  type        = string
}

variable "enabled" {
  description = "Habilita ou desabilita a instalação do Nginx Ingress Controller"
  type        = bool
  default     = true
}

variable "namespace" {
  description = "Namespace onde o Nginx Ingress Controller será instalado"
  type        = string
  default     = "ingress-nginx"
}

variable "create_namespace" {
  description = "Se deve criar o namespace para o Nginx Ingress Controller"
  type        = bool
  default     = true
}

variable "create_irsa" {
  description = "Se deve criar um perfil IAM para usar com Service Account (IRSA)"
  type        = bool
  default     = true
}

variable "chart_version" {
  description = "Versão do chart Helm do Nginx Ingress Controller"
  type        = string
  default     = "4.7.1" # Ajuste para a versão mais recente recomendada
}

variable "service_type" {
  description = "Tipo de serviço para o Nginx Ingress Controller (LoadBalancer ou NodePort)"
  type        = string
  default     = "LoadBalancer"
}

variable "load_balancer_type" {
  description = "Tipo de balanceador de carga AWS a ser utilizado (classic, nlb ou nlb-ip)"
  type        = string
  default     = "nlb"
}

variable "is_default_ingress_class" {
  description = "Se o Nginx Ingress Controller deve ser a classe de ingress padrão"
  type        = bool
  default     = true
}

variable "resources" {
  description = "Recursos de CPU e memória para o Nginx Ingress Controller"
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
      memory = "256Mi"
    }
  }
}

variable "tags" {
  description = "Tags a serem aplicadas aos recursos criados"
  type        = map(string)
  default     = {}
} 
