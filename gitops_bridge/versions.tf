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

data "terraform_remote_state" "token_ca" {
  backend = "local" # or use a different backend where the state of the first configuration is stored
  config = {
    path = "../fetch_token_ca/terraform.tfstate"
  }
}

provider "argocd" {
  port_forward_with_namespace = "argocd"
  username                    = "admin"
  password                    = bcrypt_hash.argo.id
  kubernetes {
    host                   = "https://kubernetes.default.svc"
    token                  = data.terraform_remote_state.token_ca.outputs.kubernetes_token
    cluster_ca_certificate = data.terraform_remote_state.token_ca.outputs.ca_certificate
  }
}

provider "helm" {
  kubernetes {
    host                   = "https://kubernetes.default.svc"
    token                  = data.terraform_remote_state.token_ca.outputs.kubernetes_token
    cluster_ca_certificate = data.terraform_remote_state.token_ca.outputs.ca_certificate
  }
}

provider "kubernetes" {
  host                   = "https://kubernetes.default.svc"
  token                  = data.terraform_remote_state.token_ca.outputs.kubernetes_token
  cluster_ca_certificate = data.terraform_remote_state.token_ca.outputs.ca_certificate
}

locals {
  environment = var.workspace
}
