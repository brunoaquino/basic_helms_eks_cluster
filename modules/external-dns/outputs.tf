output "namespace" {
  description = "O namespace onde o External-DNS foi instalado"
  value       = var.enabled ? kubernetes_namespace.external_dns[0].metadata[0].name : ""
}

output "service_account_name" {
  description = "Nome da conta de serviço criada para o External-DNS"
  value       = var.enabled ? "external-dns" : ""
}

output "role_arn" {
  description = "ARN da função IAM criada para o External-DNS"
  value       = module.irsa.iam_role_arn
}

output "domain_filters" {
  description = "Lista de domínios configurados para o External-DNS"
  value       = length(var.domain_filters) > 0 ? var.domain_filters : [var.base_domain]
}
