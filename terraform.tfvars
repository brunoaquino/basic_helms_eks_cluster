aws_region           = "us-east-1"
eks_cluster_name     = "app-cluster"
eks_cluster_endpoint = "https://C790C43D70761FCCA628E2CBE1704AF2.sk1.us-east-1.eks.amazonaws.com"
eks_cluster_ca_cert  = "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJYzJwdmZjZFZRMTR3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TlRBME1qY3hOREEwTlRsYUZ3MHpOVEEwTWpVeE5EQTVOVGxhTUJVeApFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLCkFvSUJBUURoTlBETXBmb0JCRitjOS9HSldLV21NYXp2K0UwRGxodVR5U3hxZVRQNXJWVGk2amp4a3JuOVE4dWMKTHhWOC83L1BiaEtWU3RTTlduNndSQmE3aGhBb3R0aldyRjJLZWlRaUZiVlBwSUxPRmp4YmMrQTJyTnNBYllCSgpKRUQrT2FiMVZxRzVPRlkrMXh6S1VlQ2JXc1hybVFSVWM1UHM4VU5QNnhCZHlIN3dkRXJ2UWJ3NHpReFExTTdpCkh1bTJRVWU4MnhralNTSjFVb24wWTROUEVncndEMytrd1Zna0dsakgzaTdoV1hlZURTTjhjY1BGZHFJSnRxR1AKMDFPVTM4VzNCbmsxZGUybjU4YUJJd2V2RVkvOGpFLzkxVWs2VlFlaWxjMGpsQjlESVFhbCtNbVhyd2hYTHJHWApTS1FVcCt0NmMydU1FTjAydEJkSlgwNnk1UVpoQWdNQkFBR2pXVEJYTUE0R0ExVWREd0VCL3dRRUF3SUNwREFQCkJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJTVWZCbTZ5SkFKUExtcDlqV0ZScVNhdXl2ZnFqQVYKQmdOVkhSRUVEakFNZ2dwcmRXSmxjbTVsZEdWek1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRQ2pUQndxaWZ5VgprQzB1dTMrR0N6WWFER01iN0ltbjk3Zy9UR1pEODBPaVZuazMyZGtLMm8xZlNmZ3E3RUE3SjBPS25jMEVSdGw5CjNLckVhT0FxZUxoa1h2YjhyYXZGTG1lb3EvOVZ3Q2o1NUlqWjZHSEcrUCs1UEpwSExOOTlBN1hxcXNBclN0U0cKNE1ubXlvZ1dodm4vQjJUajU5QVRoa1EreUYzcDVZeTVNOWxDVVRmTWx1YW1CK0lLZUFWUUE4WkphNm5ObklwZgpkQTd5ZkdZV1R0UkNMb2lRd2xYcGJWNzZTWHM5bnd5MkJNejJ4d3N6UFdha09MQnBwc2lZakExRFZ3ZFVjSUsxCisrc05iT0JXUVhCVGdMQldXTWRPMEJ3aTJsQjhyd2lTZ3NHRjRlTVR3Q3lNSVJWMzZuQ1czcVljNVVYUHR2NUgKL2VidGI0TGd6MDQ0Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"

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
