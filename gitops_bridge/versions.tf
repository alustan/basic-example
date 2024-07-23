terraform {
  required_version = ">= 1.0"

  required_providers {
  
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.22.0"
    }
   
   
  }
}

provider "kubernetes" {
  # in-cluster config
  # config_path = "~/.kube/config"
  
}

locals {
  environment = var.workspace
}
