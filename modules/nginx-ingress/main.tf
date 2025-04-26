# Criação do namespace para o Nginx Ingress Controller
resource "kubernetes_namespace" "nginx_ingress" {
  count = var.enabled && var.create_namespace ? 1 : 0

  metadata {
    name = var.namespace
    labels = merge(
      {
        "app.kubernetes.io/managed-by" = "terraform"
        "app.kubernetes.io/name"       = "nginx-ingress"
      },
      var.tags
    )
  }
}

# Criação da política IAM para o Nginx Ingress Controller
resource "aws_iam_policy" "nginx_ingress" {
  count       = var.enabled && var.create_irsa ? 1 : 0
  name        = "nginx-ingress-controller-${var.eks_cluster_name}-policy"
  description = "Política para o Nginx Ingress Controller gerenciar load balancers na AWS"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "elasticloadbalancing:Describe*",
          "elasticloadbalancing:AddTags",
          "elasticloadbalancing:CreateListener",
          "elasticloadbalancing:DeleteListener",
          "elasticloadbalancing:CreateRule",
          "elasticloadbalancing:DeleteRule",
          "elasticloadbalancing:CreateTargetGroup",
          "elasticloadbalancing:ModifyTargetGroupAttributes",
          "elasticloadbalancing:ModifyLoadBalancerAttributes",
          "elasticloadbalancing:DeleteTargetGroup",
          "elasticloadbalancing:RegisterTargets",
          "elasticloadbalancing:DeregisterTargets",
          "elasticloadbalancing:SetSecurityGroups",
          "elasticloadbalancing:SetIpAddressType",
          "elasticloadbalancing:SetSubnets"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })

  tags = var.tags
}

# Criação da IAM Role para o Nginx Ingress Controller (IRSA)
module "irsa" {
  count   = var.enabled && var.create_irsa ? 1 : 0
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.20.0"

  role_name = "nginx-ingress-controller-${var.eks_cluster_name}"

  role_policy_arns = {
    policy = aws_iam_policy.nginx_ingress[0].arn
  }

  oidc_providers = {
    main = {
      provider_arn               = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.oidc_provider_url}"
      namespace_service_accounts = ["${var.namespace}:${local.service_account_name}"]
    }
  }

  tags = var.tags
}

# Instalação do Nginx Ingress Controller via Helm
resource "helm_release" "nginx_ingress" {
  count = var.enabled ? 1 : 0

  name       = "ingress-nginx"
  namespace  = var.create_namespace ? kubernetes_namespace.nginx_ingress[0].metadata[0].name : var.namespace
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = var.chart_version

  # Configurações básicas
  set {
    name  = "controller.service.type"
    value = var.service_type
  }

  # Configuração do tipo de serviço (LoadBalancer ou NodePort)
  dynamic "set" {
    for_each = var.service_type == "LoadBalancer" ? [1] : []
    content {
      name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
      value = var.load_balancer_type
    }
  }

  # Configurações para AWS (se aplicável)
  dynamic "set" {
    for_each = var.service_type == "LoadBalancer" ? [1] : []
    content {
      name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-backend-protocol"
      value = "tcp"
    }
  }

  # Configurações de recursos de CPU e memória
  set {
    name  = "controller.resources.requests.cpu"
    value = var.resources.requests.cpu
  }

  set {
    name  = "controller.resources.requests.memory"
    value = var.resources.requests.memory
  }

  set {
    name  = "controller.resources.limits.cpu"
    value = var.resources.limits.cpu
  }

  set {
    name  = "controller.resources.limits.memory"
    value = var.resources.limits.memory
  }

  # Configuração da conta de serviço
  set {
    name  = "controller.serviceAccount.create"
    value = "true"
  }

  set {
    name  = "controller.serviceAccount.name"
    value = local.service_account_name
  }

  # Se a integração com IAM for habilitada
  dynamic "set" {
    for_each = var.create_irsa ? [1] : []
    content {
      name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = module.irsa[0].iam_role_arn
    }
  }

  # Configurações de ingress class
  set {
    name  = "controller.ingressClassResource.name"
    value = "nginx"
  }

  set {
    name  = "controller.ingressClassResource.enabled"
    value = "true"
  }

  set {
    name  = "controller.ingressClassResource.default"
    value = var.is_default_ingress_class
  }

  depends_on = [
    kubernetes_namespace.nginx_ingress,
    module.irsa
  ]
}

# Recursos adicionais
data "aws_caller_identity" "current" {}

locals {
  service_account_name = "nginx-ingress-controller"
  oidc_provider_url    = trimprefix(data.aws_eks_cluster.this.identity[0].oidc[0].issuer, "https://")
}

# Dados do cluster EKS
data "aws_eks_cluster" "this" {
  name = var.eks_cluster_name
}
