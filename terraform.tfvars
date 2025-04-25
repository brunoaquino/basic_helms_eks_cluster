aws_region           = "us-east-1"
eks_cluster_name     = "app-cluster"
eks_cluster_endpoint = "https://1E75E8DF4F59764160DC6537E07D732E.gr7.us-east-1.eks.amazonaws.com"
eks_cluster_ca_cert  = "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJV3JBRm41QzROdHN3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TlRBME1qVXhNakV3TXpOYUZ3MHpOVEEwTWpNeE1qRTFNek5hTUJVeApFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLCkFvSUJBUUMzOGhYTW94ZExiMEdZc094Sk5lTEloU2VqZ04vQnFsRWdhZkJOR0xqbVMvRmFaNjc2aGNrTk5YQWUKRThmbVUrWC8zdVRSa2N4NGJBYlBpdTh4SDRYSUFKMHpESnpyby9GZ3Q5b1ptSFlZYWYzSzJYVk8vK0c2akZMSQp2UWpjc1dmSnROVWhxS0x6Nit2R1VuVGU2b1pHQkRNK1g5ZFB5RUNPMGx5VGhnRUdybGlpL2VXTzhyWjJKbmJZCjdFVExOUGdkNytZSURUK0k3MlVlQVg0NFk5RzFWOTNRN2JYWlpaVDhQdkY0bHBISGlKTit2SGJZcWdiZFhGYXQKU1FzUHlBcHBEQlV3Qnh4TUtZZ1RscHdWT1U3SElIT3FoUjZRNWFGV016OVRnYVdMVUZ6VnNkdHloWDJpR3EvWQo1Wktja1JLVTNDaW53aFNKN3hVY0pscFl3Vzc1QWdNQkFBR2pXVEJYTUE0R0ExVWREd0VCL3dRRUF3SUNwREFQCkJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJTZzc5TnArTzZLMVl3dWQ1a0VNbWlMUUdaM1B6QVYKQmdOVkhSRUVEakFNZ2dwcmRXSmxjbTVsZEdWek1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRQ3ZGcjB5ZnJubQp0N1pjSnQ0NjBUbnQ3OWljN3hGQWZnclpqZUtvWUlUSTV4LzBrS3VpTkdma2xPZjdTcTkvNlB2SnI5MVJHTW1xCnZqMmdDWi93dUc2Q2kzRWNzeXdYN1Jtb3d2TDg1amc1Mk1lc2tid3h5UDV5eUdaMHNYK3lGMm5VRitUalUvdkMKMG1GQkRVU0Y4eldnNnE3bmtWTHloNDNnS0xZZVFpVWkyamIxSmRZZ0V5NkZHTHBwVGY0VnFETUl3SjBIeXRhcwpKbk85MWlkWmNpNWhzNGpkVm1taFlORXFqNTA2c0ViQ09jV01QMG1SMkJPbVltUnFCU3d1WFc3aXo4dCs1blYwCnIwMk0wOThIK2lKYmY2aVQ3SkR3MWx1dlFnNm1QalAvSkNWSllYY0VORHVzaGlkTEdqTm1kT1dBajRyYmM2V3MKMDBXcEd1UHRQdVVGCi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"

# Domínio Base
base_domain = "mixnarede.com.br"

# Cert Manager
# cert_manager_namespace     = "cert-manager"
# cert_manager_chart_version = "v1.13.3"
# letsencrypt_email          = "bruno-smv2@hotmail.com"
# letsencrypt_server         = "https://acme-v02.api.letsencrypt.org/directory" # Production
# # letsencrypt_server  = "https://acme-staging-v02.api.letsencrypt.org/directory" # Staging (para testes)
# cluster_issuer_name = "letsencrypt-prod"

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

# # Istio
# istio_namespace             = "istio-system"
# istio_chart_version_base    = "1.20.2"
# istio_chart_version_istiod  = "1.20.2"
# istio_chart_version_gateway = "1.20.2"

# # Loki e Grafana
# loki_grafana_namespace = "monitoring"
# loki_chart_version     = "2.9.9"
# grafana_chart_version  = "6.60.4"
# grafana_admin_password = "admin" # Altere para uma senha forte
# # grafana_domain será gerado automaticamente como "grafana.example.com" 
