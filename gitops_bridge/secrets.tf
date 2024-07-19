
################################################################################
# GitOps Bridge: Private ssh keys for git
################################################################################
resource "kubernetes_namespace" "argocd" {
 metadata {
    name = "argocd"
  }
}

resource "random_password" "argocd" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# Argo requires the password to be bcrypt, we use custom provider of bcrypt,
# as the default bcrypt function generates diff for each terraform plan
resource "bcrypt_hash" "argo" {
  cleartext = random_password.argocd.result
}

resource "kubernetes_secret_v1" "cluster" {

 metadata {
    name        = "in-cluster"
    namespace   = "argocd"
    annotations = local.argocd_annotations
    labels      = local.argocd_labels
  }
  data = {
      name   ="in-cluster"
      server = "https://kubernetes.default.svc"
      config = local.config
    }

  depends_on = [helm_release.argocd]
}

