output "metrics_server_enabled" {
  description = "Indica se o Metrics Server está habilitado"
  value       = var.enabled
}

output "metrics_server_namespace" {
  description = "Namespace onde o Metrics Server está instalado"
  value       = var.namespace
}

output "metrics_server_version" {
  description = "Versão do chart do Metrics Server instalada"
  value       = var.chart_version
} 
