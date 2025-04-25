# External-DNS para Amazon EKS com Terraform

Este projeto implementa o External-DNS em um cluster Amazon EKS usando Terraform, seguindo uma abordagem modular para melhor organização e reutilização.

## Pré-requisitos

- Terraform >= 1.0.0
- AWS CLI configurado
- Cluster EKS existente
- Provedor OIDC configurado para o cluster (para IRSA - IAM Roles for Service Accounts)

## Estrutura do Projeto

```
├── main.tf                         # Arquivo principal para uso dos módulos
├── outputs.tf                      # Outputs do Terraform
├── README.md                       # Documentação
├── terraform.tfvars                # Valores de variáveis
├── variables.tf                    # Definições de variáveis
├── versions.tf                     # Configuração de versões
└── modules/                        # Diretório de módulos
    └── external-dns/               # Módulo do External-DNS
        ├── data.tf                 # Data sources do módulo
        ├── locals.tf               # Valores calculados do módulo
        ├── main.tf                 # Recursos principais do módulo
        ├── outputs.tf              # Outputs do módulo
        ├── README.md               # Documentação do módulo
        ├── variables.tf            # Variáveis do módulo
        └── versions.tf             # Configuração de versões do módulo
```

## Funcionalidades

- **Arquitetura Modular**: Facilita a manutenção e reutilização
- **External-DNS**:
  - Cria um namespace dedicado para o External-DNS
  - Configura o IAM Role for Service Account (IRSA) para acesso ao Route 53
  - Instala o External-DNS via Helm Chart
  - Configuração parametrizada (domínios, política de sincronização, etc.)

## Obtenção de Dados do Cluster EKS

Para configurar o projeto, você precisa obter informações do seu cluster EKS. Use os comandos abaixo:

1. **Listar clusters EKS disponíveis**:

   ```bash
   aws eks list-clusters --output text
   ```

2. **Obter o certificado CA do cluster** (eks_cluster_ca_cert):

   ```bash
   aws eks describe-cluster --name seu-cluster-eks --query "cluster.certificateAuthority.data" --output text
   ```

3. **Obter o endpoint do cluster** (eks_cluster_endpoint):

   ```bash
   aws eks describe-cluster --name seu-cluster-eks --query "cluster.endpoint" --output text
   ```

4. **Verificar se o cluster tem OIDC configurado**:
   ```bash
   aws eks describe-cluster --name seu-cluster-eks --query "cluster.identity.oidc.issuer" --output text
   ```

Substitua `seu-cluster-eks` pelo nome real do seu cluster EKS.

## Notas sobre o Helm Chart

Este projeto utiliza o repositório Bitnami para o chart do External-DNS:

```
repository = "https://charts.bitnami.com/bitnami"
```

Para verificar as versões disponíveis, você pode executar:

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm search repo bitnami/external-dns -l
```

A versão recomendada para o chart é `6.13.1`.

## Como Usar

1. Clone o repositório
2. Obtenha as informações do seu cluster EKS conforme descrito acima
3. Atualize o arquivo `terraform.tfvars` com suas configurações específicas
4. Inicialize o Terraform:
   ```bash
   terraform init
   ```
5. Visualize o plano de execução:
   ```bash
   terraform plan
   ```
6. Aplique as mudanças:
   ```bash
   terraform apply
   ```

## Variáveis Importantes

| Nome                          | Descrição                 | Valor Padrão   |
| ----------------------------- | ------------------------- | -------------- |
| `aws_region`                  | Região da AWS             | -              |
| `eks_cluster_name`            | Nome do cluster EKS       | -              |
| `eks_cluster_endpoint`        | Endpoint do cluster EKS   | -              |
| `eks_cluster_ca_cert`         | Certificado CA do cluster | -              |
| `base_domain`                 | Domínio base              | -              |
| `external_dns_namespace`      | Namespace do External-DNS | `external-dns` |
| `external_dns_chart_version`  | Versão do chart Helm      | -              |
| `external_dns_domain_filters` | Filtros de domínio        | `[]`           |
| `external_dns_policy`         | Política de sincronização | `sync`         |

## Extensão

Para adicionar novos módulos:

1. Crie um novo diretório em `modules/`
2. Implemente os arquivos necessários seguindo o mesmo padrão
3. Adicione a chamada do módulo em `main.tf`

## Verificação

Após a implantação, verifique se o External-DNS está funcionando corretamente:

```bash
kubectl -n external-dns get pods
kubectl -n external-dns logs -f $(kubectl -n external-dns get pods -o name)
```

## Referências

- [External-DNS - Oficial](https://github.com/kubernetes-sigs/external-dns)
- [External-DNS - Helm Chart (Bitnami)](https://github.com/bitnami/charts/tree/main/bitnami/external-dns)
- [IAM Roles for Service Accounts (IRSA)](https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html)
