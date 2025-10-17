variable "applications" {
  description = "Map of applications to deploy via Helm"
  type = map(object({
    repository       = string
    chart            = string
    version          = string
    namespace        = string
    create_namespace = optional(bool, true)
    timeout          = optional(number, 300)
    values_file      = optional(string)
    values = optional(map(string), {})
    sensitive_values = optional(map(string), {})
    set_lists        = optional(map(list(string)), {})
    namespace_labels = optional(map(string), {})
    namespace_annotations = optional(map(string), {})
  }))
  default = {}
}

variable "create_namespaces" {
  description = "Whether to create namespaces for applications"
  type        = bool
  default     = true
}