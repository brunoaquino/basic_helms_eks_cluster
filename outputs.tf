output "external_dns_namespace" {
  description = "O namespace onde o External-DNS foi instalado"
  value       = module.external_dns.namespace
}

output "external_dns_service_account_name" {
  description = "Nome da conta de serviço criada para o External-DNS"
  value       = module.external_dns.service_account_name
}

output "external_dns_role_arn" {
  description = "ARN da função IAM criada para o External-DNS"
  value       = module.external_dns.role_arn
}

output "external_dns_domain_filters" {
  description = "Lista de domínios configurados para o External-DNS"
  value       = module.external_dns.domain_filters
}

# Outputs do Cert-Manager
output "cert_manager_namespace" {
  description = "Namespace onde o Cert-Manager foi instalado"
  value       = module.cert_manager.namespace
}

output "cert_manager_service_account" {
  description = "Nome da Service Account do Cert-Manager"
  value       = module.cert_manager.service_account_name
}

output "cert_manager_iam_role_arn" {
  description = "ARN do IAM Role para o Cert-Manager"
  value       = module.cert_manager.iam_role_arn
}

output "cert_manager_letsencrypt_issuers" {
  description = "ClusterIssuers do Let's Encrypt configurados"
  value       = module.cert_manager.letsencrypt_issuers
}
