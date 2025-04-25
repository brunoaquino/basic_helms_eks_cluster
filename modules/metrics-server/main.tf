# Instalação do Metrics Server via Helm
resource "helm_release" "metrics_server" {
  count = var.enabled ? 1 : 0

  name       = "metrics-server"
  namespace  = var.namespace
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  version    = var.chart_version

  # Timeout aumentado para evitar erros
  timeout = 300

  values = [
    yamlencode({
      # Configurações de recursos
      resources = var.resources

      # Adiciona argumentos para compatibilidade com o EKS
      args = [
        "--kubelet-preferred-address-types=InternalIP",
        "--kubelet-use-node-status-port",
        "--metric-resolution=15s",
        "--kubelet-insecure-tls" # Necessário se os kubelet não possuem certificados assinados
      ]

      # Labels comuns para recursos
      podLabels = {
        "app.kubernetes.io/managed-by" = "terraform"
        "app.kubernetes.io/part-of"    = "eks-monitoring"
      }

      # Configurações de afinidade/tolerâncias para garantir alta disponibilidade
      affinity = {
        nodeAffinity = {
          requiredDuringSchedulingIgnoredDuringExecution = {
            nodeSelectorTerms = [
              {
                matchExpressions = [
                  {
                    key      = "kubernetes.io/os"
                    operator = "In"
                    values   = ["linux"]
                  }
                ]
              }
            ]
          }
        }
      }

      tolerations = [
        {
          key      = "node-role.kubernetes.io/master"
          operator = "Exists"
          effect   = "NoSchedule"
        }
      ]
    })
  ]
} 
