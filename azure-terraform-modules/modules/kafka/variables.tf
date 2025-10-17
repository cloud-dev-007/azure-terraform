variable "release_name" {
  description = "Name of the Kafka Helm release"
  type        = string
  default     = "kafka"
}

variable "namespace" {
  description = "Kubernetes namespace for Kafka"
  type        = string
  default     = "kafka"
}

variable "chart_version" {
  description = "Kafka chart version"
  type        = string
  default     = "14.0.0"
}

variable "persistence_size" {
  description = "Persistent volume size for Kafka brokers"
  type        = string
  default     = "100Gi"
}

variable "replica_count" {
  description = "Number of Kafka brokers"
  type        = number
  default     = 3
}

variable "service_type" {
  description = "Service type for external access"
  type        = string
  default     = "LoadBalancer"
}

variable "load_balancer_internal" {
  description = "Whether to use internal load balancer"
  type        = bool
  default     = true
}

variable "resources" {
  description = "Resource requests and limits for Kafka brokers"
  type = object({
    requests = object({
      memory = string
      cpu    = string
    })
    limits = object({
      memory = string
      cpu    = string
    })
  })
  default = {
    requests = {
      memory = "1Gi"
      cpu    = "500m"
    }
    limits = {
      memory = "2Gi"
      cpu    = "1000m"
    }
  }
}