module "kafka" {
  source = "../azure-terraform-modules/modules/application"

  app_name    = "kafka-cluster"
  namespace   = "kafka"
  repository  = "https://charts.bitnami.com/bitnami"
  chart       = "kafka"
  chart_version = "14.0.0"

  values = {
    # Service Configuration
    "service.type" = "LoadBalancer"
    "service.ports.client" = "9092"
    "service.ports.external" = "9094"
    "service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-internal" = "true" 
    
    # Kafka Configuration
    "persistence.size" = "50Gi"
    "replicaCount" = 3
    "numPartitions" = 3
    "defaultReplicationFactor" = 2
    "offsetsTopicReplicationFactor" = 2
    "transactionStateLogReplicationFactor" = 2
    
    # External Access (if needed)
    "externalAccess.enabled" = "true"
    "externalAccess.service.type" = "LoadBalancer"
    "externalAccess.service.port" = "9094"
    "externalAccess.autoDiscovery.enabled" = "true"
    "externalAccess.autoDiscovery.serviceName" = "kafka"
    "externalAccess.autoDiscovery.servicePort" = "9094"
    "externalAccess.autoDiscovery.servicePortName" = "external"
    "externalAccess.autoDiscovery.servicePortProtocol" = "TCP"

    "resources.requests.memory" = "1Gi"
    "resources.requests.cpu" = "500m"
    "resources.limits.memory" = "2Gi"
    "resources.limits.cpu" = "1000m"
    
    "zookeeper.enabled" = "true"
    "zookeeper.persistence.size" = "20Gi"
    "zookeeper.replicaCount" = 3
  }

  create_namespace = true
}