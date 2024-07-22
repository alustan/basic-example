
resource "kubernetes_namespace" "argocd" {
 metadata {
    name = "alustan"
  }
}



resource "kubernetes_secret_v1" "cluster" {

 metadata {
    name        = "in-cluster"
    namespace   = "alustan"
    annotations = local.alustan_annotations
    labels      = local.alustan_labels
  }
  data = {}

}

