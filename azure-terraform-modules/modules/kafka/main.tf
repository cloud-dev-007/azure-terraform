resource "kubernetes_namespace" "kafka" {
  metadata {
    name = var.namespace
    labels = {
      "app" = "kafka"
    }
  }
}

resource "helm_release" "kafka" {
  name       = var.release_name
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "kafka"
  version    = var.chart_version
  namespace  = var.namespace

  values = [
    templatefile("${path.module}/values.yaml", {
      persistence_size    = var.persistence_size
      replica_count       = var.replica_count
      service_type        = var.service_type
      load_balancer_internal = var.load_balancer_internal
      resources           = var.resources
    })
  ]

  depends_on = [kubernetes_namespace.kafka]
}

# Service for internal cluster communication
resource "kubernetes_service" "kafka_internal" {
  metadata {
    name      = "${var.release_name}-internal"
    namespace = var.namespace
    labels = {
      "app" = "kafka"
    }
  }

  spec {
    type = "ClusterIP"
    selector = {
      "app.kubernetes.io/name" = "kafka"
    }
    port {
      name        = "client"
      port        = 9092
      target_port = 9092
    }
  }

  depends_on = [helm_release.kafka]
}