# Módulo Cert-Manager com Let's Encrypt para Amazon EKS

Este módulo implementa o Cert-Manager com configuração de emissor (Issuer) Let's Encrypt em um cluster Amazon EKS usando Terraform.

## Funcionalidades

- Instalação do Cert-Manager via Helm Chart
- Configuração de ClusterIssuer para Let's Encrypt (staging e produção)
- Configuração de IAM Role para Service Account (IRSA) para acesso à Route 53
- Suporte a validação DNS01 usando Route 53

## Variáveis de Entrada

| Nome                   | Descrição                                               | Tipo          | Padrão         |
| ---------------------- | ------------------------------------------------------- | ------------- | -------------- |
| `aws_region`           | Região da AWS                                           | `string`      | -              |
| `eks_cluster_name`     | Nome do cluster EKS                                     | `string`      | -              |
| `eks_cluster_endpoint` | Endpoint do cluster EKS                                 | `string`      | -              |
| `eks_cluster_ca_cert`  | Certificado CA do cluster EKS                           | `string`      | -              |
| `namespace`            | Namespace para o Cert-Manager                           | `string`      | `cert-manager` |
| `chart_version`        | Versão do Helm chart do Cert-Manager                    | `string`      | -              |
| `enabled`              | Flag para habilitar ou desabilitar o Cert-Manager       | `bool`        | `true`         |
| `create_namespace`     | Flag para criar o namespace                             | `bool`        | `true`         |
| `letsencrypt_email`    | Email para registro no Let's Encrypt                    | `string`      | -              |
| `base_domain`          | Domínio base para o qual o Cert-Manager terá permissões | `string`      | -              |
| `create_clusterissuer` | Flag para criar o ClusterIssuer                         | `bool`        | `true`         |
| `letsencrypt_server`   | Servidor do Let's Encrypt (staging ou prod)             | `string`      | `staging`      |
| `tags`                 | Tags a serem aplicadas aos recursos                     | `map(string)` | `{}`           |

## Outputs

| Nome                   | Descrição                                          |
| ---------------------- | -------------------------------------------------- |
| `namespace`            | Namespace onde o Cert-Manager foi instalado        |
| `service_account_name` | Nome da Service Account criada para o Cert-Manager |
| `iam_role_arn`         | ARN do IAM Role criado para o Cert-Manager         |
| `letsencrypt_issuers`  | Lista de ClusterIssuers criados                    |
| `version`              | Versão do Cert-Manager instalada                   |

## Uso

```hcl
module "cert_manager" {
  source = "./modules/cert-manager"

  aws_region           = var.aws_region
  eks_cluster_name     = var.eks_cluster_name
  eks_cluster_endpoint = var.eks_cluster_endpoint
  eks_cluster_ca_cert  = var.eks_cluster_ca_cert

  base_domain        = var.base_domain
  letsencrypt_email  = "admin@example.com"
  chart_version      = "v1.13.3"

  # Para usar em produção
  # letsencrypt_server = "prod"

  tags = {
    Environment = "production"
    ManagedBy   = "terraform"
  }
}
```

## Notas

- Para produção, altere `letsencrypt_server` para `prod`
- Recomendado ter o External-DNS configurado para gerenciamento automático dos registros DNS
- Os certificados gerados pelo Let's Encrypt têm validade de 90 dias e são renovados automaticamente
