# basic-example
basic IAC example to test alustan project

`./deploy.sh` to install into a local cluster

- Uncomment `config_path` and `kubernetes_namespace` in **gitops_bridge** module to execute from local machine

```
provider "kubernetes" {
  # in-cluster config
  config_path = "~/.kube/config"
  
}
```
```
resource "kubernetes_namespace" "alustan" {
 metadata {
    name = "alustan"
  }
}
```
- Uncomment `config_path` and `terraform_backend` in **root vesrion.tf** module to execute from local machine

```
provider "kubernetes" {
  config_path = "~/.kube/config"
}
```

```
terraform {
  backend "kubernetes" {
    secret_suffix    = "state"
    config_path      = "~/.kube/config"
    # in_cluster_config = true
  }
}
```