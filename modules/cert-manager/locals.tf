locals {
  service_account_name = "cert-manager"

  letsencrypt_servers = {
    staging = "https://acme-staging-v02.api.letsencrypt.org/directory"
    prod    = "https://acme-v02.api.letsencrypt.org/directory"
  }

  letsencrypt_issuer_name = "letsencrypt-${var.letsencrypt_server}"

  oidc_provider_url = trimprefix(data.aws_eks_cluster.this.identity[0].oidc[0].issuer, "https://")
} 
