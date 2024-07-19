################################################################################
# Install ArgoCD: To be replaced by addon manifest later, So argo will manage itself
################################################################################
resource "helm_release" "argocd" {

  name             = "argo-cd"
  description      = "A Helm chart to install the ArgoCD"
  namespace        = "argocd"
  create_namespace = false
  chart            = "argo-cd"
  version          = "6.6.0"
  repository       = "https://argoproj.github.io/argo-helm"

 set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }

  set_sensitive {
    name  = "configs.secret.argocdServerAdminPassword"
    value = bcrypt_hash.argo.id
  }

 
depends_on = [kubernetes_namespace.argocd]

}