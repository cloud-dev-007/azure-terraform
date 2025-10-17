output "application_status" {
  description = "The status of all application Helm releases"
  value = {
    for k, v in helm_release.applications : k => {
      status  = v.status
      version = v.version
      namespace = v.namespace
    }
  }
}

output "application_namespaces" {
  description = "The namespaces created for applications"
  value       = { for k, v in kubernetes_namespace.app_namespaces : k => v.metadata[0].name }
}