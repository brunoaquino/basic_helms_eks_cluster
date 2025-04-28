aws_region           = "us-east-1"
eks_cluster_name     = "app-cluster"
eks_cluster_endpoint = "https://F91C9D34C29F5A4C781708AA122A342A.gr7.us-east-1.eks.amazonaws.com"
eks_cluster_ca_cert  = "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJSDU2NUsvejR5Nnd3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TlRBME1qZ3hNekU1TlRkYUZ3MHpOVEEwTWpZeE16STBOVGRhTUJVeApFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLCkFvSUJBUURPK0gvUUoyR3dVVkJKZFJPNXF1MWNPOEM2V2J0RTRCc0JaMERMS09ocUVJNngzLzhoWWdMeGFRR1YKSUIrYmh6TXZHQnduV2wySkhYOHB4N0VLcGdIcGcydjkrZ2prQ0ZRRncwNmhPU3RlL2dnMFNXbmwrUEFINVNyNgpWMXFWbm5uZTVsdnZqbmt5NjlqMU1CWCtPZndtVnhPa0ZaTU5JanJRNWpsRkI2c2NlYnlvYUhSQWlsQmNIVkdSCnRyWFBXQ2lSTUpEQ3RJeVp5K2dGWkZ4emsyMzREMTdLMWgvYjZMUzZzNytPL3BxTnlma0NlOG1nWFRQZVdlRmgKc29kSEVxK3VyeEVNSkZhZFpBYkZKdzBoQ3NtN05ocTkzK2NtRGp0NFZQbzRSWC9vU2w0SFFyRzBBd0FjeXJvUQpnUEpLTVoyazI0cm1Gc2xsZ2d0THpiTFRlajNkQWdNQkFBR2pXVEJYTUE0R0ExVWREd0VCL3dRRUF3SUNwREFQCkJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJSeTYybTVSc1pCSktUamJWYml5cmd1RW5KdTR6QVYKQmdOVkhSRUVEakFNZ2dwcmRXSmxjbTVsZEdWek1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRQUVlcGZtZU5PRQpzOElyZFg3MHUrNDFaU09XbUdWMUk0YmVPUHQ0TEZkOFU0ekNadzJtV2tMNFFTd2ZSVnRPVXJWSDZZRlVUZ2pOCjltWUhrSCsxNk41OWZuRUJIUS9pSXNzU0pPYUlNdzFLNGluSFBrZjlrMi9vczBSakpGandSUUtLUzJmcklhRXUKVnZmaTM5SmJDYXJ5c3B0VFNya0V2aDJrWlhFaHdpQVZjTnpLVVBJNU13aTc2dmF3SzAzd2NqWWlMRlFLL1lYVgpMbTUrL1MwL2xYRTNqcFk0WnlNUUhaU2VLTWhUTlBSSXZXeCtUcVNlMUp2OUh4czJTRWFMMXZyYm03Tlg1RVByCkJBc3BXSkF0MXlPNVBOaVhNbTFNckhwbGw1SHF3SmRIOVpaeS9JQUIrUmlnZ3ZmRlhlNzM2anlqK0d3N1c2UVcKZVZBd3ZWaUxoSkx2Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"

# Cert Manager
cert_manager_enabled              = true
cert_manager_namespace            = "cert-manager"
cert_manager_chart_version        = "v1.13.3"
cert_manager_letsencrypt_email    = "bruno-smv2@hotmail.com"
cert_manager_letsencrypt_server   = "prod" # Altere para "prod" em produção
cert_manager_create_clusterissuer = true

# External DNS
external_dns_namespace     = "external-dns"
external_dns_chart_version = "6.13.1"

# Domínio Base
base_domain = "mixnarede.com.br"

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
