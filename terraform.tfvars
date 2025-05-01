aws_region           = "us-east-1"
eks_cluster_name     = "app-cluster"
eks_cluster_endpoint = "https://AFFF35229632EC007175C7278792B95A.yl4.us-east-1.eks.amazonaws.com"
eks_cluster_ca_cert  = "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJUFVsUG5yUFFhYmt3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TlRBME16QXhNakEwTXpoYUZ3MHpOVEEwTWpneE1qQTVNemhhTUJVeApFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLCkFvSUJBUURxbElrUFRGa2RmeDcvajdpZ0wvU01ZeEZIQStCcEF1VTlSTFNtaStRRjBnNlJSMWxUWngvVzB2Ky8KVFZBRFI1Slo0SUJJWGFQRHNQR1ozSjFrd0RzNU1DZGZDYmt3VXV5SDRZeW9CU3o0Vzc3M3pyNWFZSGY2Q3lsdApsRVZlcHJBZUJWV1VUc0NBRU1xcHJtTXVuWGh2QVVnZW9pYXlGamJaTkJ5NWw4ZU4xUkNDckYzcVZ6eVl5M2xPCmx5Skt0TFBLek9IbStOZFY5SHJjRm56d1NXajNNRkNsbUpxdDZJTWhHNmJnN1VMQmtjcGRBOWJhb1FuS3FzVjEKNHhTbkNCbElxMEQ0SXBtZ1R6NU9NVHV4Q0FDNGEzbVBXMlErNWdMY1hvR2Fsa29IUHovQm1qNDdIU1Fzc0RyZQpmbDFXUnBmYmhHY0dKdWRzU25IY2dBSHB5c3hiQWdNQkFBR2pXVEJYTUE0R0ExVWREd0VCL3dRRUF3SUNwREFQCkJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJRcUl5Wk9yc3AvUEJ0UUJ6QkY0S1VWVWlVU01EQVYKQmdOVkhSRUVEakFNZ2dwcmRXSmxjbTVsZEdWek1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRRE9DV2NsSmNyRAp0VmxuUkN1NXBGVldSZndzMUVxeUt5dldaZTBUN05NWklKeVBCZGNHTit3SmZHdUo1T2ZRcGdDU0FzcVdWaFpOCnNUMk01TGQrMXJxeGlhdGRubUdQZ1FhajhVTUNmdDkwZ2FNWi85QWNPVlh3VVZtd1hEUTFPWkF4T241QVRHSTIKQkd0bE1JMDRGL25vNlFFZ1h4TkRjWnpjbTdzK0gxZXdOSm01Sk12VG8rN2E0R2EyelJKTWpkZllsMS93clU3OApYZHA2SzVCRFh0NEtoUHJqMW81S00rYUh5SStHd3VJTWxIMWlEMjZaVE1ER0NuSHNBWFQwMHBLcnUvMXNuNThyCnJXMGdKQnNEK2VhVXdNYXA2RjB3VWpFdW1TWnJPdi95MkZ3VE5GYTdsNHVaNlVNQk5wVFJHT0pIaVlxMnpsV3MKYStQVEJHTUVxRGg1Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"

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
metrics_server_enabled        = true #ativar por causa do kubectl top e HPA
metrics_server_namespace      = "kube-system"
metrics_server_chart_version  = "3.10.0"
metrics_server_cpu_request    = "100m"
metrics_server_memory_request = "128Mi"
metrics_server_cpu_limit      = "300m"
metrics_server_memory_limit   = "512Mi"
