# Módulo Terraform para External-DNS em clusters EKS

Este módulo instala e configura o External-DNS em um cluster Amazon EKS, possibilitando a sincronização automática de recursos Kubernetes (Services, Ingresses) com o Amazon Route 53.

## Funcionalidades

- Cria um namespace dedicado para o External-DNS
- Configura o IAM Role for Service Account (IRSA) para acesso ao Route 53
- Instala o External-DNS via Helm Chart
- Configuração parametrizada (domínios, política de sincronização, etc.)

## Uso

```hcl
module "external_dns" {
  source = "./modules/external-dns"

  aws_region           = "us-east-1"
  eks_cluster_name     = "meu-cluster-eks"
  eks_cluster_endpoint = "https://XXXXX.gr7.us-east-1.eks.amazonaws.com"
  eks_cluster_ca_cert  = "LS0tLS1CRUdJTiBDRVJUSUZJQ0F..."

  base_domain          = "meudominio.com.br"
  chart_version        = "6.13.1"  # Versão do Bitnami chart

  # Configurações opcionais
  namespace            = "external-dns"
  domain_filters       = ["api.meudominio.com.br", "app.meudominio.com.br"]
  policy               = "sync"
  txt_owner_id         = "meu-cluster-eks"
}
```

## Notas sobre o chart Helm

Este módulo utiliza o chart Helm do External-DNS hospedado no repositório Bitnami:

```
repository = "https://charts.bitnami.com/bitnami"
```

Recomendamos a versão 6.13.1 para melhor compatibilidade.

## Requisitos

| Nome       | Versão    |
| ---------- | --------- |
| terraform  | >= 1.0.0  |
| aws        | >= 4.0.0  |
| kubernetes | >= 2.10.0 |
| helm       | >= 2.5.0  |

## Inputs

| Nome                 | Descrição                             | Tipo           | Padrão            | Obrigatório |
| -------------------- | ------------------------------------- | -------------- | ----------------- | ----------- |
| aws_region           | Região da AWS                         | `string`       | -                 | sim         |
| eks_cluster_name     | Nome do cluster EKS                   | `string`       | -                 | sim         |
| eks_cluster_endpoint | Endpoint do cluster EKS               | `string`       | -                 | sim         |
| eks_cluster_ca_cert  | Certificado CA do cluster EKS         | `string`       | -                 | sim         |
| base_domain          | Domínio base                          | `string`       | -                 | sim         |
| chart_version        | Versão do Helm chart                  | `string`       | -                 | sim         |
| namespace            | Namespace para o External-DNS         | `string`       | `"external-dns"`  | não         |
| domain_filters       | Lista de domínios para filtrar        | `list(string)` | `[]`              | não         |
| enabled              | Habilitar/desabilitar o External-DNS  | `bool`         | `true`            | não         |
| aws_zone_type        | Tipo de zona Route53 (public/private) | `string`       | `"public"`        | não         |
| policy               | Política de sincronização             | `string`       | `"sync"`          | não         |
| txt_owner_id         | ID do proprietário para registros TXT | `string`       | `""`              | não         |
| aws_prefer_cname     | Preferência por registros CNAME       | `bool`         | `false`           | não         |
| txt_prefix           | Prefixo para registros TXT            | `string`       | `"external-dns-"` | não         |
| tags                 | Tags para recursos                    | `map(string)`  | `{}`              | não         |

## Outputs

| Nome                 | Descrição                 |
| -------------------- | ------------------------- |
| namespace            | Namespace do External-DNS |
| service_account_name | Nome da conta de serviço  |
| role_arn             | ARN da função IAM         |
| domain_filters       | Domínios configurados     |
