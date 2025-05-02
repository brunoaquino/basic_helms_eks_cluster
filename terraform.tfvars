aws_region           = "us-east-1"
eks_cluster_name     = "app-cluster"
eks_cluster_endpoint = "https://AFFF35229632EC007175C7278792B95A.yl4.us-east-1.eks.amazonaws.com"
eks_cluster_ca_cert  = "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJUFVsUG5yUFFhYmt3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TlRBME16QXhNakEwTXpoYUZ3MHpOVEEwTWpneE1qQTVNemhhTUJVeApFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLCkFvSUJBUURxbElrUFRGa2RmeDcvajdpZ0wvU01ZeEZIQStCcEF1VTlSTFNtaStRRjBnNlJSMWxUWngvVzB2Ky8KVFZBRFI1Slo0SUJJWGFQRHNQR1ozSjFrd0RzNU1DZGZDYmt3VXV5SDRZeW9CU3o0Vzc3M3pyNWFZSGY2Q3lsdApsRVZlcHJBZUJWV1VUc0NBRU1xcHJtTXVuWGh2QVVnZW9pYXlGamJaTkJ5NWw4ZU4xUkNDckYzcVZ6eVl5M2xPCmx5Skt0TFBLek9IbStOZFY5SHJjRm56d1NXajNNRkNsbUpxdDZJTWhHNmJnN1VMQmtjcGRBOWJhb1FuS3FzVjEKNHhTbkNCbElxMEQ0SXBtZ1R6NU9NVHV4Q0FDNGEzbVBXMlErNWdMY1hvR2Fsa29IUHovQm1qNDdIU1Fzc0RyZQpmbDFXUnBmYmhHY0dKdWRzU25IY2dBSHB5c3hiQWdNQkFBR2pXVEJYTUE0R0ExVWREd0VCL3dRRUF3SUNwREFQCkJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJRcUl5Wk9yc3AvUEJ0UUJ6QkY0S1VWVWlVU01EQVYKQmdOVkhSRUVEakFNZ2dwcmRXSmxjbTVsZEdWek1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRRE9DV2NsSmNyRAp0VmxuUkN1NXBGVldSZndzMUVxeUt5dldaZTBUN05NWklKeVBCZGNHTit3SmZHdUo1T2ZRcGdDU0FzcVdWaFpOCnNUMk01TGQrMXJxeGlhdGRubUdQZ1FhajhVTUNmdDkwZ2FNWi85QWNPVlh3VVZtd1hEUTFPWkF4T241QVRHSTIKQkd0bE1JMDRGL25vNlFFZ1h4TkRjWnpjbTdzK0gxZXdOSm01Sk12VG8rN2E0R2EyelJKTWpkZllsMS93clU3OApYZHA2SzVCRFh0NEtoUHJqMW81S00rYUh5SStHd3VJTWxIMWlEMjZaVE1ER0NuSHNBWFQwMHBLcnUvMXNuNThyCnJXMGdKQnNEK2VhVXdNYXA2RjB3VWpFdW1TWnJPdi95MkZ3VE5GYTdsNHVaNlVNQk5wVFJHT0pIaVlxMnpsV3MKYStQVEJHTUVxRGg1Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"

# Ambiente
environment = "dev"

# Cert Manager
cert_manager_enabled              = true
cert_manager_namespace            = "cert-manager"
cert_manager_chart_version        = "v1.13.3"
cert_manager_create_namespace     = true
cert_manager_letsencrypt_email    = "bruno-smv2@hotmail.com"
cert_manager_letsencrypt_server   = "prod" # Altere para "staging" em ambiente de testes
cert_manager_create_clusterissuer = true
cert_manager_cpu_request          = "50m"
cert_manager_memory_request       = "64Mi"
cert_manager_cpu_limit            = "100m"
cert_manager_memory_limit         = "128Mi"

# External DNS
external_dns_enabled          = true
external_dns_namespace        = "external-dns"
external_dns_chart_version    = "6.13.1"
external_dns_domain_filters   = ["mixnarede.com.br"]
external_dns_aws_zone_type    = "public"
external_dns_policy           = "sync"
external_dns_txt_owner_id     = "app-cluster"
external_dns_txt_prefix       = "external-dns-"
external_dns_aws_prefer_cname = false
external_dns_cpu_request      = "25m"
external_dns_memory_request   = "64Mi"
external_dns_cpu_limit        = "50m"
external_dns_memory_limit     = "128Mi"

# Domínio Base
base_domain = "mixnarede.com.br"

# Metrics Server
metrics_server_enabled        = true # ativar por causa do kubectl top e HPA
metrics_server_namespace      = "kube-system"
metrics_server_chart_version  = "3.10.0"
metrics_server_cpu_request    = "25m"
metrics_server_memory_request = "64Mi"
metrics_server_cpu_limit      = "50m"
metrics_server_memory_limit   = "128Mi"

# NGINX Ingress Controller
nginx_ingress_enabled            = true
nginx_ingress_namespace          = "ingress-nginx"
nginx_ingress_create_namespace   = true
nginx_ingress_chart_version      = "4.7.1"
nginx_ingress_service_type       = "LoadBalancer"
nginx_ingress_load_balancer_type = "nlb"
nginx_ingress_create_irsa        = true
nginx_ingress_is_default_class   = true
# sugerido NGINX Ingress 250m 500m 256Mi 512Mi
nginx_ingress_cpu_request    = "100m"
nginx_ingress_memory_request = "128Mi"
nginx_ingress_cpu_limit      = "300m"
nginx_ingress_memory_limit   = "256Mi"
