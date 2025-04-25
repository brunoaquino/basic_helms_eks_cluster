# Módulo Metrics Server

Este módulo instala o Kubernetes Metrics Server no cluster EKS, que é necessário para habilitar comandos como `kubectl top nodes` e `kubectl top pods`, além de ser requisito para o Horizontal Pod Autoscaler (HPA).

## Funcionalidades

- Instalação do Metrics Server via Helm
- Configuração otimizada para funcionar com o Amazon EKS
- Configuração de recursos (CPU/memória) escalável conforme tamanho do cluster
- Suporte a alta disponibilidade com tolerâncias e afinidade

## Pré-requisitos

- Cluster EKS em execução
- Terraform 1.0+
- Helm provider configurado

## Variáveis de Entrada

| Nome          | Descrição                                      | Tipo   | Padrão      | Obrigatório |
| ------------- | ---------------------------------------------- | ------ | ----------- | ----------- |
| enabled       | Habilita ou desabilita o módulo                | bool   | true        | não         |
| namespace     | Namespace onde o Metrics Server será instalado | string | kube-system | não         |
| chart_version | Versão do chart Helm do Metrics Server         | string | 3.10.0      | não         |
| resources     | Configuração de recursos para o Metrics Server | object | ver default | não         |

## Outputs

| Nome                     | Descrição                                      |
| ------------------------ | ---------------------------------------------- |
| metrics_server_enabled   | Indica se o Metrics Server está habilitado     |
| metrics_server_namespace | Namespace onde o Metrics Server está instalado |
| metrics_server_version   | Versão do chart do Metrics Server instalada    |

## Uso

```hcl
module "metrics_server" {
  source = "./modules/metrics-server"

  aws_region           = "us-east-1"
  eks_cluster_name     = "meu-cluster-eks"
  eks_cluster_endpoint = "https://endpoint-do-eks.us-east-1.amazonaws.com"
  eks_cluster_ca_cert  = "cert-base64-encoded"

  # Configurações opcionais
  namespace     = "kube-system"
  chart_version = "3.10.0"

  # Recursos personalizados
  resources = {
    requests = {
      cpu    = "100m"
      memory = "128Mi"
    }
    limits = {
      cpu    = "300m"
      memory = "512Mi"
    }
  }
}
```

## Notas

O Metrics Server é configurado com a flag `--kubelet-insecure-tls` para compatibilidade com a maioria das configurações do EKS. Em ambientes de produção com requisitos de segurança mais rigorosos, considere configurar certificados TLS adequados.
