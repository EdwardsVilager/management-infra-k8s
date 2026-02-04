#############################################
# 1. Namespaces desplegados
#############################################

output "core_namespaces" {
  description = "Namespaces base instalados (ingress-nginx y cert-manager)"
  value = [
    kubernetes_namespace.ingress.metadata[0].name,
    kubernetes_namespace.cert_manager.metadata[0].name
  ]
}

output "microservice_namespaces" {
  description = "Namespaces creados para microservicios"
  value       = { for k, ns in kubernetes_namespace.microservice_ns : k => ns.metadata[0].name }
}

#############################################
# 2. Releases de Helm instalados
#############################################

output "ingress_nginx_release" {
  description = "Estado del release de ingress-nginx"
  value = {
    name      = helm_release.ingress_nginx.name
    namespace = helm_release.ingress_nginx.namespace
    version   = helm_release.ingress_nginx.version
  }
}

output "cert_manager_release" {
  description = "Estado del release de cert-manager"
  value = {
    name      = helm_release.cert_manager.name
    namespace = helm_release.cert_manager.namespace
    version   = helm_release.cert_manager.version
  }
}

output "microservices_releases" {
  description = "Microservicios desplegados por Helm"
  value = {
    for k, r in helm_release.microservice :
    k => {
      name      = r.name
      namespace = r.namespace
      version   = r.version
      status    = r.status
    }
  }
}

#############################################
# 3. Opcional: Lista de servicios expuestos
#############################################

output "services_ports" {
  description = "Puertos expuestos de cada microservicio"
  value = {
    for k, s in var.microservices :
    k => {
      port       = s.port
      ingress    = s.enable_ingress
      namespace  = s.namespace
    }
  }
}