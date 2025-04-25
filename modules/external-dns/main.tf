# Criação do namespace para o External-DNS
resource "kubernetes_namespace" "external_dns" {
  count = var.enabled ? 1 : 0

  metadata {
    name = var.namespace
    labels = merge(
      {
        "app.kubernetes.io/managed-by" = "terraform"
        "app.kubernetes.io/name"       = "external-dns"
      },
      var.tags
    )
  }
}

# Criação da Policy IAM para o External-DNS
module "irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.20.0"

  role_name = "external-dns-${var.eks_cluster_name}"

  attach_external_dns_policy    = true
  external_dns_hosted_zone_arns = ["*"] # Em produção, especifique as ARNs das zonas hospedadas

  oidc_providers = {
    main = {
      provider_arn               = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${trimprefix(data.aws_eks_cluster.this.identity[0].oidc[0].issuer, "https://")}"
      namespace_service_accounts = ["${var.namespace}:external-dns"]
    }
  }

  tags = var.tags
}

# Instalação do External-DNS via Helm
resource "helm_release" "external_dns" {
  count = var.enabled ? 1 : 0

  name       = "external-dns"
  namespace  = kubernetes_namespace.external_dns[0].metadata[0].name
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"
  version    = var.chart_version

  set {
    name  = "provider"
    value = "aws"
  }

  set {
    name  = "aws.region"
    value = var.aws_region
  }

  set {
    name  = "aws.zoneType"
    value = var.aws_zone_type
  }

  set {
    name  = "policy"
    value = var.policy
  }

  set {
    name  = "registry"
    value = "txt"
  }

  set {
    name  = "txtOwnerId"
    value = var.txt_owner_id != "" ? var.txt_owner_id : var.eks_cluster_name
  }

  set {
    name  = "txtPrefix"
    value = var.txt_prefix
  }

  set {
    name  = "interval"
    value = "1m"
  }

  # Configuração de segurança
  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = "external-dns"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.irsa.iam_role_arn
  }

  # Configuração de domínios
  dynamic "set" {
    for_each = length(var.domain_filters) > 0 || var.base_domain != "" ? [1] : []
    content {
      name  = "domainFilters"
      value = "{${join(",", length(var.domain_filters) > 0 ? var.domain_filters : [var.base_domain])}}"
    }
  }

  set {
    name  = "aws.preferCNAME"
    value = var.aws_prefer_cname
  }

  depends_on = [
    kubernetes_namespace.external_dns,
    module.irsa
  ]
}
