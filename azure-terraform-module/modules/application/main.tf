resource "kubernetes_namespace" "app" {
  count = var.create_namespace ? 1 : 0

  metadata {
    name = var.namespace
    labels = merge(
      {
        "app" = var.app_name
      },
      var.namespace_labels
    )
    annotations = var.namespace_annotations
  }
}

resource "helm_release" "app" {
  name       = var.app_name
  repository = var.repository
  chart      = var.chart
  version    = var.chart_version
  namespace  = var.namespace
  timeout    = var.timeout

  create_namespace = var.create_namespace

  values = var.values_file != null ? [file(var.values_file)] : null

  dynamic "set" {
    for_each = var.values
    content {
      name  = set.key
      value = set.value
    }
  }

  dynamic "set_sensitive" {
    for_each = var.sensitive_values
    content {
      name  = set_sensitive.key
      value = set_sensitive.value
    }
  }

  dynamic "set_list" {
    for_each = var.set_lists
    content {
      name  = set_list.key
      value = set_list.value
    }
  }

  depends_on = [
    kubernetes_namespace.app
  ]
}

# Service Account for the application
resource "kubernetes_service_account" "app" {
  count = var.create_service_account ? 1 : 0

  metadata {
    name      = "${var.app_name}-sa"
    namespace = var.namespace
    labels    = var.labels
  }

  automount_service_account_token = true

  depends_on = [
    kubernetes_namespace.app
  ]
}

# ConfigMap for application configuration
resource "kubernetes_config_map" "app" {
  count = length(var.config_maps) > 0 ? 1 : 0

  metadata {
    name      = "${var.app_name}-config"
    namespace = var.namespace
    labels    = var.labels
  }

  data = var.config_maps

  depends_on = [
    kubernetes_namespace.app
  ]
}

# Secret for sensitive configuration
resource "kubernetes_secret" "app" {
  count = length(var.secrets) > 0 ? 1 : 0

  metadata {
    name      = "${var.app_name}-secrets"
    namespace = var.namespace
    labels    = var.labels
  }

  data = var.secrets

  depends_on = [
    kubernetes_namespace.app
  ]
}