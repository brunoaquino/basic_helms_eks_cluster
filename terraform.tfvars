aws_region           = "us-east-1"
eks_cluster_name     = "app-cluster"
eks_cluster_endpoint = "https://17F4AC49E6AF341685DAA9D22DAC976E.gr7.us-east-1.eks.amazonaws.com"
eks_cluster_ca_cert  = "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJSXJyUnJZTjZqWE13RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TlRBME1qa3hOakExTlRoYUZ3MHpOVEEwTWpjeE5qRXdOVGhhTUJVeApFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLCkFvSUJBUUN2Rm05TEpjbFFzSWRHZnd4TlFYUThkb2dOeUwwekk2cWwzWExjN2F2Wmx3TVpsUmE5MkFPY3p0R0oKZ3RmREZ3aklNRE1YcG5WM0IwWEFHVlhrR0s2QWxMZENrQUNEcHErMlBJcUxXVjdEcHEwcXd2RGx4Z1JqYmNoWQpSaHowekRjQjVEZnRiWThDUWZ4NVNJdFZKRGgveFFFVSswM09oNGdDdUcyd3dJY2ZNQ1VDdG51OWdUUHRWSTRoCkVNS2ZaeWtQUTMzSFFwK1RGYUZ0ZGQ2Zm9WUGxyUTNzem1TRVBqZ01DVXhXaEFIQURFTzBqZm9wU0VyVmp2YkcKVjExVHdjQVAvYTF4WlpQZFpyOGU3T21MaWNwVHQwTTlqWmpVZlltVFYyOEd1WGZWWTlRTG9RdXdWcXowa3c5bApKNVh4S1A2Z0dLVk1UTkpyUnljTDRIb25oNG1YQWdNQkFBR2pXVEJYTUE0R0ExVWREd0VCL3dRRUF3SUNwREFQCkJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJSaFMydXhMNUhxZ2R5c2NqSm54d3U2bDVUVU5EQVYKQmdOVkhSRUVEakFNZ2dwcmRXSmxjbTVsZEdWek1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRQ2RBV3UxNVJwawp3d3RLaE1HdWVVcmdVTW9EMWloMmltbEY4Ly9keDlRNjFjSmJiWXNiQzdGTFlkc2d4YjZBZnF2Z0laSEhiRU9tCnh4RldEVHFFcjFUNjA1SS82aXJvbVRNOGJuTmlyOW5TNjdWeVo2QWhMbDJIZGN6T0lqOE1ncXFJdW5rOFlnN3gKOGgvcHM4SG4xTlVWN0lPbFZkOFlqWUF1WUczVHdGZTUyeDFHUjE0Qm5Xd093eC9mbzFERDZIRHMxZHA2QXdHagovRFk1TTd4M2VWb2V1bExqclg3Q1ArSTFFOFBHdnhFN25xL0dpMS9EcTlDZW0rcWZjd3V4VU1tU3N3S3ZRYU56CmZVVVlTTEphYTZnQ2k2WmhxdlJSUUNLVGtZZDFDVE8wTzhubHhTekpKRHJKaHNEOHl4bEJJNHkyZ1o3ak1laloKVGV6RnRBa2NXbGplCi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"

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
metrics_server_enabled        = false
metrics_server_namespace      = "kube-system"
metrics_server_chart_version  = "3.10.0"
metrics_server_cpu_request    = "100m"
metrics_server_memory_request = "128Mi"
metrics_server_cpu_limit      = "300m"
metrics_server_memory_limit   = "512Mi"
