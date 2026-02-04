#########################################
# 1. NAMESPACES CORE
#########################################

resource "kubernetes_namespace" "ingress" {
  metadata {
    name = "ingress-nginx"
  }
}

resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = "cert-manager"
  }
}

#########################################
# 2. INGRESS NGINX
#########################################

resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx"
  namespace  = kubernetes_namespace.ingress.metadata[0].name
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.11.0"

  # Chart LOCAL
  #chart = "${path.module}/charts/ingress-nginx"

  values = [
    file("${path.module}/helm-values/ingress-nginx-values.yaml")
  ]
}

#########################################
# 3. CERT-MANAGER
#########################################

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  namespace  = kubernetes_namespace.cert_manager.metadata[0].name
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.14.3"

  # Chart LOCAL
  #chart = "${path.module}/charts/cert-manager"

  values = [
    file("${path.module}/helm-values/cert-manager-values.yaml")
  ]
}

#########################################
# 4. MICROSERVICIOS (ENFOQUE SIMPLE)
#########################################

resource "kubernetes_namespace" "microservice_ns" {
  for_each = var.microservices

  metadata {
    name = each.value.namespace
  }
}

resource "helm_release" "microservice" {
  for_each = var.microservices

  name      = each.value.name
  namespace = kubernetes_namespace.microservice_ns[each.key].metadata[0].name

  # El chart viene del folder local ./charts/<nombre-del-servicio>
  chart = "${var.charts_base_path}/${each.value.name}"

  # Version opcional
  version = "1.0.0"

  values = [
    file("${path.module}/${each.value.values_file}")
  ]

  # Opcional (solo si enable_ingress = true)
  dynamic "set" {
    for_each = each.value.enable_ingress ? [1] : []

    content {
      name  = "ingress.enabled"
      value = "true"
    }
  }
}