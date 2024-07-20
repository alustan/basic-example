terraform {
  required_version = ">= 1.0"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.10.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.22.0"
    }
    argocd = {
      source  = "oboukili/argocd"
      version = "6.0.3"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.3.2"
    }
    bcrypt = {
      source  = "viktorradnai/bcrypt"
      version = ">= 0.1.2"
    }
    external = {
      source = "hashicorp/external"
      version = "2.3.3"
    }
  }
}

data "external" "kubernetes_token" {
  program = ["sh", "-c", "token=$(kubectl create token terraform-sa -n alustan); echo '{\"token\":\"'$token'\"}'"]
}

provider "argocd" {
  port_forward_with_namespace = "argocd"
  username                    = "admin"
  password                    = bcrypt_hash.argo.id
  kubernetes {
    host                   = "https://kubernetes.default.svc"
    token                  = data.external.kubernetes_token.result.token
    insecure               = true
  }
}

provider "helm" {
  kubernetes {
    host                   = "https://kubernetes.default.svc"
    token                  = data.external.kubernetes_token.result.token
    insecure               = true
  }
}

provider "kubernetes" {
  host                   = "https://kubernetes.default.svc"
  token                  = data.external.kubernetes_token.result.token
  insecure               = true
}

locals {
  environment = var.workspace
}
