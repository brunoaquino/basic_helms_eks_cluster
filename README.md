# External-DNS para Amazon EKS com Terraform

Este projeto implementa o External-DNS em um cluster Amazon EKS usando Terraform, seguindo uma abordagem modular para melhor organização e reutilização.

## Pré-requisitos

- Terraform >= 1.0.0
- AWS CLI configurado
- Cluster EKS existente
- Provedor OIDC configurado para o cluster (para IRSA - IAM Roles for Service Accounts)

## Configuração do AWS CLI

Para configurar o AWS CLI corretamente para trabalhar com o EKS, siga estas etapas:

1. **Instalar o AWS CLI**:

   Para Linux/macOS:

   ```bash
   curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
   unzip awscliv2.zip
   sudo ./aws/install
   ```

   Para macOS:

   ```bash
   curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
   sudo installer -pkg AWSCLIV2.pkg -target /
   ```

   Para Windows:

   ```
   Baixe e execute o instalador: https://awscli.amazonaws.com/AWSCLIV2.msi
   ```

2. **Verificar a instalação**:

   ```bash
   aws --version
   ```

3. **Configurar suas credenciais da AWS**:

   ```bash
   aws configure
   ```

   Você precisará fornecer:

   - Access Key ID
   - Secret Access Key
   - Região padrão (ex: us-east-1)
   - Formato de saída padrão (recomendado: json)

4. **Configurar múltiplos perfis (opcional)**:

   Para gerenciar múltiplos ambientes ou contas AWS, edite os arquivos:

   ```bash
   ~/.aws/credentials
   ~/.aws/config
   ```

   Exemplo de configuração de perfil:

   ```
   [profile dev]
   region = us-east-1
   output = json

   [profile prod]
   role_arn = arn:aws:iam::123456789012:role/AdminRole
   source_profile = default
   region = us-west-2
   ```

   Para usar um perfil específico:

   ```bash
   aws eks --profile dev list-clusters
   ```

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
- **Cert-Manager com Let's Encrypt**:
  - Cria um namespace dedicado para o Cert-Manager
  - Configura o IAM Role for Service Account (IRSA) para acesso ao Route 53
  - Instala o Cert-Manager via Helm Chart
  - Configura ClusterIssuer para Let's Encrypt (staging e produção)
  - Suporte a validação DNS01 usando Route 53

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

| Nome                              | Descrição                 | Valor Padrão   |
| --------------------------------- | ------------------------- | -------------- |
| `aws_region`                      | Região da AWS             | -              |
| `eks_cluster_name`                | Nome do cluster EKS       | -              |
| `eks_cluster_endpoint`            | Endpoint do cluster EKS   | -              |
| `eks_cluster_ca_cert`             | Certificado CA do cluster | -              |
| `base_domain`                     | Domínio base              | -              |
| `external_dns_namespace`          | Namespace do External-DNS | `external-dns` |
| `external_dns_chart_version`      | Versão do chart Helm      | -              |
| `external_dns_domain_filters`     | Filtros de domínio        | `[]`           |
| `external_dns_policy`             | Política de sincronização | `sync`         |
| `cert_manager_namespace`          | Namespace do Cert-Manager | `cert-manager` |
| `cert_manager_chart_version`      | Versão do chart Helm      | `v1.13.3`      |
| `cert_manager_letsencrypt_email`  | Email para Let's Encrypt  | -              |
| `cert_manager_letsencrypt_server` | Servidor Let's Encrypt    | `staging`      |

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

## Uso do Cert-Manager com Let's Encrypt

O Cert-Manager instalado permite a emissão automática de certificados TLS usando Let's Encrypt. Para utilizar:

1. **Verificar a instalação do Cert-Manager**:

   ```bash
   kubectl -n cert-manager get pods
   kubectl get clusterissuers
   ```

2. **Criar certificados para seus serviços**:

   Exemplo de Certificate para um serviço:

   ```yaml
   apiVersion: cert-manager.io/v1
   kind: Certificate
   metadata:
     name: example-tls
     namespace: seu-namespace
   spec:
     secretName: example-tls
     issuerRef:
       name: letsencrypt-staging
       kind: ClusterIssuer
     dnsNames:
       - app.seu-dominio.com
   ```

   Para usar em produção, altere o issuerRef.name para `letsencrypt-prod`.

3. **Verificar o status do certificado**:

   ```bash
   kubectl -n seu-namespace get certificates
   kubectl -n seu-namespace get certificaterequests
   kubectl -n seu-namespace describe certificate example-tls
   ```

4. **Exemplos de uso com Ingress**:

   ```yaml
   apiVersion: networking.k8s.io/v1
   kind: Ingress
   metadata:
     name: example-ingress
     namespace: seu-namespace
     annotations:
       cert-manager.io/cluster-issuer: "letsencrypt-staging"
   spec:
     tls:
       - hosts:
           - app.seu-dominio.com
         secretName: example-tls
     rules:
       - host: app.seu-dominio.com
         http:
           paths:
             - path: /
               pathType: Prefix
               backend:
                 service:
                   name: example-service
                   port:
                     number: 80
   ```

## Atualização do kubectl no AWS CLI

Para garantir que sua instalação do kubectl esteja atualizada e compatível com seu cluster EKS, siga estas instruções:

1. **Verificar a versão atual do kubectl**:

   ```bash
   kubectl version --client
   ```

2. **Instalar ou atualizar o kubectl via AWS CLI**:

   Para Linux/macOS:

   ```bash
   curl -o kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.28.3/2023-11-14/bin/linux/amd64/kubectl
   chmod +x ./kubectl
   mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
   ```

   Para macOS:

   ```bash
   curl -o kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.28.3/2023-11-14/bin/darwin/amd64/kubectl
   chmod +x ./kubectl
   mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
   ```

   Para Windows (PowerShell):

   ```powershell
   curl -o kubectl.exe https://s3.us-west-2.amazonaws.com/amazon-eks/1.28.3/2023-11-14/bin/windows/amd64/kubectl.exe
   ```

3. **Verificar a instalação**:

   ```bash
   kubectl version --client
   ```

4. **Configurar o contexto para seu cluster EKS**:

   ```bash
   aws eks update-kubeconfig --region <região-aws> --name <nome-do-cluster>
   ```

5. **Verificar a conexão com o cluster**:

   ```bash
   kubectl get nodes
   ```

> **Importante**: Substitua a versão (1.28.3) do kubectl pela versão compatível com seu cluster. É recomendável usar a mesma versão principal do seu cluster EKS ou no máximo uma versão de diferença.

## Referências

- [External-DNS - Oficial](https://github.com/kubernetes-sigs/external-dns)
- [External-DNS - Helm Chart (Bitnami)](https://github.com/bitnami/charts/tree/main/bitnami/external-dns)
- [IAM Roles for Service Accounts (IRSA)](https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html)
- [Documentação oficial da AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html)
- [Guia de instalação da AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [Configuração do kubectl para EKS](https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html)
- [Cert-Manager - Oficial](https://cert-manager.io/docs/)
- [Cert-Manager - Helm Chart](https://artifacthub.io/packages/helm/cert-manager/cert-manager)
- [Let's Encrypt - DNS Challenge](https://cert-manager.io/docs/configuration/acme/dns01/)
