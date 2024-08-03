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

   config_path = var.incluster ? "" : "~/.kube/config"
  
}

locals {
  environment = var.workspace
}
