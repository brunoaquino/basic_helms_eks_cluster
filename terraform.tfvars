aws_region           = "us-east-1"
eks_cluster_name     = "app-cluster"
eks_cluster_endpoint = "https://36BA79EDA58C5A04E9A4D3F84A1A9792.gr7.us-east-1.eks.amazonaws.com"
eks_cluster_ca_cert  = "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJVkdUS1lPYTdhWW93RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TlRBME1qVXhOak00TWpWYUZ3MHpOVEEwTWpNeE5qUXpNalZhTUJVeApFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLCkFvSUJBUURZMVlvZWY2bmxuR0RIUy84NFYzdVNSazB6aHZsNlJVYUZnMDZYMFphVEswU09zMkpsRDJaS3grLzQKK1k3SWpqVEROSng3YTJxc09Qakk4Y3VHVEVLRmtaTW1Bd0dmcyswbm85ZmozRXFZVTJsM1U3OG92d0FEQzU2NApEcjR4d0dvNTZvWmVnWFNxek1VRVI5aWkwOGR6SURsUlhoZ0lRQ2pEVXFFekljNGxTSmtPVmUrQkFjNC82RTVMCmxwMW04eUJSb21saUVzeWFvWHVZTmhLbVdTSUNoMk93T2xHajVzSUpRemtEYnhjNGVNTkJYTFArN25pbjhCNmcKZ0IxWDRKK2V5Z1NuT2xidVU0R3lTRDlnZjBDTWFkQ1lwQklrUkpFQ01vZktMRmdMN0ZBWVBoVXRFQkJrRDltNwpZWDhZd3o2VjhvL1BkV3NRR1l4SHZKRld6ZEdGQWdNQkFBR2pXVEJYTUE0R0ExVWREd0VCL3dRRUF3SUNwREFQCkJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJSVVVUNjhyWS9qSzMzQnVCbEVWbUc3Q1dIM0hqQVYKQmdOVkhSRUVEakFNZ2dwcmRXSmxjbTVsZEdWek1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRQk51Y1NZTm0xVQpUN1kvTnYvanppY1B5TGtVRDhiaTBXcHFncDduQ2YvL29WN0k0ZnNidk9KSHd2aGJWNWVxclM3Tk1nRzJNYW9NCkw5dGpPSmh2Uk1zUjcwM21BT1B0aVVsUFhvZ0JVeEpMZzRvWEpmMWhRVFFBLzBMODg2a0tYV3V4bDRqMm1sTVAKamZ0RUxzS0QwSlBrUzBYVXRwcE1qWWZMT1grSHBZUDhtOUVXcVh0dTAwTlVFbWZVSDFqL0NOK0pOTXVOZzY0cgp0NFgzZjljdUovVHpXWXVEOXB4azU0dXNBWGI3aG8xWmJzY21mVXV4T3dwbWQ5RXl5OEV3ZTVMdTU5eERvZDByCnpxellkYWRQNkNaRUVRKzN3b1gybkMwU3pvTkpzeDJMUkMxOWNpZGhzNXZoUll5Nmd1V25vU2FIbnU0eDBYaGwKc2lIR2p0MTVpVmo5Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"

# Domínio Base
base_domain = "mixnarede.com.br"

# Cert Manager
cert_manager_enabled              = true
cert_manager_namespace            = "cert-manager"
cert_manager_chart_version        = "v1.13.3"
cert_manager_letsencrypt_email    = "bruno-smv2@hotmail.com"
cert_manager_letsencrypt_server   = "staging" # Altere para "prod" em produção
cert_manager_create_clusterissuer = true

# External DNS
external_dns_namespace     = "external-dns"
external_dns_chart_version = "6.13.1"
# Domínios serão filtrados por base_domain por padrão
# external_dns_domain_filters = ["mixnarede.com.br"]
# Configuração adicional do External-DNS
external_dns_enabled       = true
external_dns_aws_zone_type = "public"
external_dns_policy        = "sync"
external_dns_txt_owner_id  = "app-cluster"
external_dns_txt_prefix    = "external-dns-"

# Metrics Server
metrics_server_enabled        = true
metrics_server_namespace      = "kube-system"
metrics_server_chart_version  = "3.10.0"
metrics_server_cpu_request    = "100m"
metrics_server_memory_request = "128Mi"
metrics_server_cpu_limit      = "300m"
metrics_server_memory_limit   = "512Mi"
