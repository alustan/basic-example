terraform {
  backend "kubernetes" {
    secret_suffix    = "state"
    # config_path = "~/.kube/config"
    in_cluster_config = true
  }
}



provider "kubernetes" {
   config_path = var.incluster ? "" : "~/.kube/config"
}


