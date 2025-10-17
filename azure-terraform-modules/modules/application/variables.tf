variable "app_name" {
  description = "Name of the application"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace for the application"
  type        = string
}

variable "create_namespace" {
  description = "Whether to create the namespace"
  type        = bool
  default     = true
}

variable "repository" {
  description = "Helm repository URL"
  type        = string
}

variable "chart" {
  description = "Helm chart name"
  type        = string
}

variable "chart_version" {
  description = "Helm chart version"
  type        = string
  default     = null
}

variable "timeout" {
  description = "Helm install timeout in seconds"
  type        = number
  default     = 300
}

variable "values_file" {
  description = "Path to values file"
  type        = string
  default     = null
}

variable "values" {
  description = "Helm values as key-value pairs"
  type        = map(string)
  default     = {}
}

variable "sensitive_values" {
  description = "Sensitive Helm values as key-value pairs"
  type        = map(string)
  default     = {}
  sensitive   = true
}

variable "set_lists" {
  description = "Helm values as lists"
  type        = map(list(string))
  default     = {}
}

variable "labels" {
  description = "Labels for the application"
  type        = map(string)
  default     = {}
}

variable "namespace_labels" {
  description = "Labels for the namespace"
  type        = map(string)
  default     = {}
}

variable "namespace_annotations" {
  description = "Annotations for the namespace"
  type        = map(string)
  default     = {}
}

variable "create_service_account" {
  description = "Whether to create a service account"
  type        = bool
  default     = false
}

variable "config_maps" {
  description = "ConfigMap data"
  type        = map(string)
  default     = {}
}

variable "secrets" {
  description = "Secret data"
  type        = map(string)
  default     = {}
  sensitive   = true
}