terraform {
  required_version = ">= 1.4"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.30"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.13"
    }
  }
}

######################################
# Kubernetes Provider
######################################

provider "kubernetes" {
  # ───── Kubeconfig mode ─────
  config_path    = var.use_kubeconfig ? pathexpand(var.kubeconfig_path) : null
  config_context = var.use_kubeconfig ? var.kube_context : null

  # ───── Token mode ─────
  host                   = var.use_kubeconfig ? null : var.k8s_host
  token                  = var.use_kubeconfig ? null : var.k8s_token
  cluster_ca_certificate = var.use_kubeconfig ? null : base64decode(var.k8s_cluster_ca_certificate)
}

######################################
# Helm Provider
######################################

provider "helm" {
  kubernetes {
    # ───── Kubeconfig mode ─────
    config_path    = var.use_kubeconfig ? pathexpand(var.kubeconfig_path) : null
    config_context = var.use_kubeconfig ? var.kube_context : null

    # ───── Token mode ─────
    host                   = var.use_kubeconfig ? null : var.k8s_host
    token                  = var.use_kubeconfig ? null : var.k8s_token
    cluster_ca_certificate = var.use_kubeconfig ? null : base64decode(var.k8s_cluster_ca_certificate)
  }
}