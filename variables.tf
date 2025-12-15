######################################
# Global Deployment Configuration    #
######################################

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
}

#############################################
# Microservices Dynamic Deployment Settings #
#############################################

variable "microservices" {
  description = "Mapa de microservicios a desplegar mediante Helm"
  type = map(object({
    name            = string          # nombre del release helm
    namespace       = string          # namespace a crear / usar
    image           = string          # imagen docker completa (repo:tag)
    replicas        = number          # replicas del deployment
    port            = number          # puerto del servicio
    values_file     = string          # helm-values/*.yaml
    enable_ingress  = bool            # habilita ingress
    environment     = string          # entorno propio del microservicio
  }))
}

#############################################
# Helm Global Defaults (Overridable)        #
#############################################

variable "default_replicas" {
  description = "Valor por defecto de replicas"
  type        = number
  default     = 1
}

variable "default_enable_ingress" {
  description = "Ingress habilitado por defecto"
  type        = bool
  default     = false
}

variable "charts_base_path" {
  description = "Ruta base de los Helm charts"
  type        = string
  default     = "./charts"
}

######################################
# Kubernetes Configuration
######################################

variable "k8s_host" {
  description = "API Server endpoint"
  type        = string
}

variable "k8s_token" {
  description = "ServiceAccount token"
  type        = string
  sensitive   = true
}

variable "k8s_cluster_ca_certificate" {
  description = "Cluster CA (base64)"
  type        = string
  sensitive   = true
}