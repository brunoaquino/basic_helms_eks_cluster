output "namespace" {
  description = "Namespace onde o Cert-Manager foi instalado"
  value       = var.enabled ? (var.create_namespace ? kubernetes_namespace.cert_manager[0].metadata[0].name : var.namespace) : null
}

output "service_account_name" {
  description = "Nome da Service Account criada para o Cert-Manager"
  value       = local.service_account_name
}

output "iam_role_arn" {
  description = "ARN do IAM Role criado para o Cert-Manager"
  value       = module.irsa.iam_role_arn
}

output "letsencrypt_issuers" {
  description = "Lista de ClusterIssuers criados"
  value       = var.enabled && var.create_clusterissuer ? ["letsencrypt-staging", "letsencrypt-prod"] : []
}

output "version" {
  description = "Versão do Cert-Manager instalada"
  value       = var.enabled ? var.chart_version : null
}
