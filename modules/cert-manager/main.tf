# Criação do namespace para o Cert-Manager
resource "kubernetes_namespace" "cert_manager" {
  count = var.enabled && var.create_namespace ? 1 : 0

  metadata {
    name = var.namespace
    labels = merge(
      {
        "app.kubernetes.io/managed-by" = "terraform"
        "app.kubernetes.io/name"       = "cert-manager"
      },
      var.tags
    )
  }
}

# Criação da política IAM para o Cert-Manager
resource "aws_iam_policy" "cert_manager" {
  name        = "cert-manager-${var.eks_cluster_name}-policy"
  description = "Política para o Cert-Manager gerenciar registros DNS no Route 53"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "route53:GetChange",
          "route53:ChangeResourceRecordSets",
          "route53:ListResourceRecordSets"
        ]
        Resource = [
          "arn:aws:route53:::hostedzone/*",
          "arn:aws:route53:::change/*"
        ]
      },
      {
        Effect   = "Allow"
        Action   = ["route53:ListHostedZonesByName"]
        Resource = ["*"]
      }
    ]
  })

  tags = var.tags
}

# Criação da IAM Role para o Cert-Manager (IRSA)
module "irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.20.0"

  role_name = "cert-manager-${var.eks_cluster_name}"

  role_policy_arns = {
    policy = aws_iam_policy.cert_manager.arn
  }

  oidc_providers = {
    main = {
      provider_arn               = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.oidc_provider_url}"
      namespace_service_accounts = ["${var.namespace}:${local.service_account_name}"]
    }
  }

  tags = var.tags
}

# Instalação do Cert-Manager via Helm
resource "helm_release" "cert_manager" {
  count = var.enabled ? 1 : 0

  name       = "cert-manager"
  namespace  = var.create_namespace ? kubernetes_namespace.cert_manager[0].metadata[0].name : var.namespace
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = var.chart_version

  set {
    name  = "installCRDs"
    value = "true"
  }

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = local.service_account_name
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.irsa.iam_role_arn
  }

  set {
    name  = "prometheus.enabled"
    value = "true"
  }

  set {
    name  = "securityContext.enabled"
    value = "true"
  }

  depends_on = [
    kubernetes_namespace.cert_manager,
    module.irsa
  ]
}

# Aguarda que o Cert-Manager esteja pronto antes de criar o ClusterIssuer
resource "null_resource" "wait_for_cert_manager" {
  count = var.enabled && var.create_clusterissuer ? 1 : 0

  provisioner "local-exec" {
    command = <<-EOT
      kubectl wait --for=condition=available --timeout=300s deployment/cert-manager -n ${var.namespace}
      kubectl wait --for=condition=available --timeout=300s deployment/cert-manager-webhook -n ${var.namespace}
      # Aguarda mais tempo para que os CRDs sejam registrados
      echo "Aguardando 60 segundos para que os CRDs do cert-manager sejam registrados..."
      sleep 60
      # Verifica se o CRD ClusterIssuer existe
      kubectl get crd clusterissuers.cert-manager.io
    EOT
  }

  depends_on = [
    helm_release.cert_manager
  ]
}

# Criação do ClusterIssuer para Let's Encrypt Staging via kubectl
resource "null_resource" "letsencrypt_staging_issuer" {
  count = var.enabled && var.create_clusterissuer ? 1 : 0

  provisioner "local-exec" {
    command = <<-EOT
      cat <<EOF | kubectl apply -f -
      apiVersion: cert-manager.io/v1
      kind: ClusterIssuer
      metadata:
        name: letsencrypt-staging
      spec:
        acme:
          email: ${var.letsencrypt_email}
          server: ${local.letsencrypt_servers["staging"]}
          privateKeySecretRef:
            name: letsencrypt-staging-account-key
          solvers:
          - http01:
              ingress:
                class: nginx
      EOF
    EOT
  }

  depends_on = [null_resource.wait_for_cert_manager]
}

# Criação do ClusterIssuer para Let's Encrypt Production via kubectl
resource "null_resource" "letsencrypt_prod_issuer" {
  count = var.enabled && var.create_clusterissuer ? 1 : 0

  provisioner "local-exec" {
    command = <<-EOT
      cat <<EOF | kubectl apply -f -
      apiVersion: cert-manager.io/v1
      kind: ClusterIssuer
      metadata:
        name: letsencrypt-prod
      spec:
        acme:
          email: ${var.letsencrypt_email}
          server: ${local.letsencrypt_servers["prod"]}
          privateKeySecretRef:
            name: letsencrypt-prod-account-key
          solvers:
          - http01:
              ingress:
                class: nginx
      EOF
    EOT
  }

  depends_on = [null_resource.letsencrypt_staging_issuer]
}
