resource "argocd_application" "bootstrap_addons" {

  metadata {
    name      = "bootstrap-addons"
    namespace = "argocd"
    labels = {
      cluster = "in-cluster"
    }
  }
  cascade = true
  wait    = true
  spec {
    project = "default"
    destination {
      name      = "in-cluster"
      namespace = "argocd"
    }
    source {
      repo_url        = "https://github.com/alustan/cluster-manifests"
      path            =  "basic-ingress-controller"
      target_revision = "main"
      directory {
        recurse = true
        }
    }

    sync_policy {
      automated {
        prune     = true
        self_heal = true
      }
    }
  }
  depends_on = [helm_release.argocd]
}