# basic-example
basic IAC example to test alustan project

- Can be run `locally` or `in-cluster`

**For local setup**

- Uncomment backend `config_path` and comment `in_cluster_config` in root **version.tf**

```terraform
terraform {
  backend "kubernetes" {
    secret_suffix    = "state"
    # config_path = "~/.kube/config"
    in_cluster_config = true
  }
}

```
- Set `incluster` variable to `false` in **variables.tf**

> **`./deploy.sh` to run locally**

