resource "kubernetes_namespace" "alustan" {
  count = var.incluster ? 0 : 1

  metadata {
    name = "alustan"
  }
}

resource "kubernetes_secret_v1" "cluster" {
  count = var.incluster ? 0 : 1

  metadata {
    name        = "in-cluster"
    namespace   = "alustan"
    annotations = local.alustan_annotations
    labels      = local.alustan_labels
  }
  data = {}

  depends_on = [kubernetes_namespace.alustan]
}

resource "kubernetes_secret_v1" "in_cluster_secret" {
  count = var.incluster ? 1 : 0

  metadata {
    name        = "in-cluster"
    namespace   = "alustan"
    annotations = local.alustan_annotations
    labels      = local.alustan_labels
  }
  data = {}
}
