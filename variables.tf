##############################
# Kubernetes Provider Inputs #
##############################

variable "k8s_host" {
  description = "Endpoint API del clúster Kubernetes"
  type        = string
}

variable "k8s_client_certificate" {
  description = "Certificado del usuario para acceder al clúster (base64)"
  type        = string
  sensitive   = true
}

variable "k8s_client_key" {
  description = "Llave privada del usuario para autenticación (base64)"
  type        = string
  sensitive   = true
}

variable "k8s_cluster_ca_certificate" {
  description = "Certificado CA del clúster (base64)"
  type        = string
  sensitive   = true
}

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
  description = "Mapa de microservicios a desplegar mediante módulos dinámicos."
  type = map(object({
    name          = string          # nombre del release helm
    namespace     = string          # namespace a crear / utilizar
    image         = string          # imagen docker completa (repo:tag)
    replicas      = number          # réplicas del deployment
    port          = number          # puerto del contenedor / service
    values_file   = string          # values.yaml específico del microservicio
    enable_ingress = bool           # habilitar o no un ingress
    environment    = string         # entorno propio del microservicio
  }))
}

#############################################
# Helm Global Defaults (Overridable)        #
#############################################

variable "default_replicas" {
  description = "Valor por defecto de réplicas si no se define en microservices"
  type        = number
  default     = 1
}

variable "default_enable_ingress" {
  description = "Si true, todos los microservicios tienen ingress habilitado por defecto"
  type        = bool
  default     = false
}

variable "charts_base_path" {
  description = "Ruta base donde se encuentran los Helm charts"
  type        = string
  default     = "./charts"
}