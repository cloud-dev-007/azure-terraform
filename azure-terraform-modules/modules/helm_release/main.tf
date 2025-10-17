resource "kubernetes_namespace" "app_namespaces" {
  for_each = var.create_namespaces ? var.applications : {}

  metadata {
    name = each.value.namespace
    labels = merge(
      {
        "app" = each.key
      },
      each.value.namespace_labels
    )
    annotations = each.value.namespace_annotations
  }
}

resource "helm_release" "applications" {
  for_each = var.applications

  name       = each.key
  repository = each.value.repository
  chart      = each.value.chart
  version    = each.value.version
  namespace  = each.value.namespace
  timeout    = each.value.timeout

  # Create namespace if it doesn't exist
  create_namespace = each.value.create_namespace

  values = each.value.values_file != null ? [file(each.value.values_file)] : null

  set {
    name  = each.value.values
    value = each.value.values
  }

  set_sensitive {
    name  = each.value.sensitive_values
    value = each.value.sensitive_values
  }

  set_list {
    name  = each.value.set_lists
    value = each.value.set_lists
  }

  depends_on = [
    kubernetes_namespace.app_namespaces
  ]
}