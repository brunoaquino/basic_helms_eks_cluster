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
