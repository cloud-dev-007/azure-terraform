output "app_status" {
  description = "The status of the application Helm release"
  value       = helm_release.app.status
}

output "namespace" {
  description = "The namespace of the application"
  value       = var.namespace
}

output "service_account_name" {
  description = "The name of the service account"
  value       = var.create_service_account ? kubernetes_service_account.app[0].metadata[0].name : null
}

output "config_map_name" {
  description = "The name of the config map"
  value       = length(var.config_maps) > 0 ? kubernetes_config_map.app[0].metadata[0].name : null
}

output "secret_name" {
  description = "The name of the secret"
  value       = length(var.secrets) > 0 ? kubernetes_secret.app[0].metadata[0].name : null
}

output "app_labels" {
  description = "The labels of the application"
  value       = var.labels
}
