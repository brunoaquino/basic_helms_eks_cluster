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

# Outputs do Nginx Ingress Controller
output "nginx_ingress_namespace" {
  description = "Namespace onde o Nginx Ingress Controller foi instalado"
  value       = module.nginx_ingress.ingress_namespace
}

output "nginx_ingress_class_name" {
  description = "Nome da classe de ingress do Nginx Ingress Controller"
  value       = module.nginx_ingress.ingress_class_name
}

output "nginx_ingress_service_account" {
  description = "Nome da Service Account do Nginx Ingress Controller"
  value       = module.nginx_ingress.service_account_name
}

output "nginx_ingress_iam_role_arn" {
  description = "ARN do IAM Role para o Nginx Ingress Controller (quando IRSA está habilitado)"
  value       = module.nginx_ingress.iam_role_arn
}

output "nginx_ingress_load_balancer" {
  description = "Informações sobre como obter o hostname do balanceador de carga do Nginx Ingress Controller"
  value       = module.nginx_ingress.load_balancer_hostname
}

# Métricas Server outputs
output "metrics_server_enabled" {
  description = "Indica se o Metrics Server está habilitado"
  value       = module.metrics_server.metrics_server_enabled
}

output "metrics_server_namespace" {
  description = "Namespace onde o Metrics Server está instalado"
  value       = module.metrics_server.metrics_server_namespace
}

output "metrics_server_version" {
  description = "Versão do chart do Metrics Server instalada"
  value       = module.metrics_server.metrics_server_version
}
