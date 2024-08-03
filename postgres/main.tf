provider "kubernetes" {
  # config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "postgres" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_secret" "postgres_secret" {
  metadata {
    name      = "postgres-secret"
    namespace = var.namespace
  }
  data = {
    username = base64encode(var.database_user)
    password = base64encode(var.database_password)
    database = base64encode(var.database_name)
  }
  type = "Opaque"
}

resource "kubernetes_manifest" "cloudnativepg_operator" {
  manifest = {
    apiVersion = "operators.coreos.com/v1alpha1"
    kind       = "Subscription"
    metadata = {
      name      = "cloudnativepg"
      namespace = var.namespace
    }
    spec = {
      channel                = "stable"
      installPlanApproval    = "Automatic"
      name                   = "cloudnative-pg"
      source                 = "operatorhubio-catalog"
      sourceNamespace        = "olm"
    }
  }
}

resource "kubernetes_manifest" "postgres_cluster" {
  manifest = {
    apiVersion = "postgresql.cnpg.io/v1"
    kind       = "Cluster"
    metadata = {
      name      = var.cluster_name
      namespace = var.namespace
    }
    spec = {
      instances  = 1
      postgresql = {
        version = "14"
      }
      storage = {
        size = var.storage_size
      }
      bootstrap = {
        initdb = {
          database = base64decode(kubernetes_secret.postgres_secret.data["database"])
          owner    = base64decode(kubernetes_secret.postgres_secret.data["username"])
          secret = {
            name = kubernetes_secret.postgres_secret.metadata[0].name
          }
        }
      }
    }
  }

  depends_on = [kubernetes_manifest.cloudnativepg_operator]
}

