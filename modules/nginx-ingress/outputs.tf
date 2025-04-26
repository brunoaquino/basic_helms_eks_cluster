output "ingress_namespace" {
  description = "Namespace onde o Nginx Ingress Controller foi instalado"
  value       = var.enabled ? (var.create_namespace ? kubernetes_namespace.nginx_ingress[0].metadata[0].name : var.namespace) : null
}

output "ingress_class_name" {
  description = "Nome da classe de ingress criada"
  value       = var.enabled ? "nginx" : null
}

output "is_default_ingress_class" {
  description = "Se o Nginx Ingress Controller é a classe de ingress padrão"
  value       = var.enabled ? var.is_default_ingress_class : null
}

output "service_account_name" {
  description = "Nome da conta de serviço do Nginx Ingress Controller"
  value       = var.enabled ? local.service_account_name : null
}

output "iam_role_arn" {
  description = "ARN do perfil IAM criado para o Nginx Ingress Controller (se IRSA estiver habilitado)"
  value       = var.enabled && var.create_irsa ? module.irsa[0].iam_role_arn : null
}

output "ingress_controller_release_name" {
  description = "Nome da release Helm do Nginx Ingress Controller"
  value       = var.enabled ? helm_release.nginx_ingress[0].name : null
}

output "load_balancer_hostname" {
  description = "Hostname do balanceador de carga criado para o Nginx Ingress Controller (quando service_type é LoadBalancer)"
  value       = var.enabled && var.service_type == "LoadBalancer" ? "Para obter o nome do host do balanceador de carga, execute: kubectl get svc -n ${var.namespace} ingress-nginx-controller -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'" : null
} 
