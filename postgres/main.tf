provider "kubernetes" {

   config_path = var.incluster ? "" : "~/.kube/config"
  
}

provider "helm" {
  kubernetes {
    config_path = var.incluster ? "" : "~/.kube/config"
  }
}

resource "kubernetes_namespace" "postgres" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_secret" "pg_admin_secret" {
  metadata {
    name      = "pg-admin-secret"
    namespace = var.namespace
  }

  data = {
    username: "admin"
    password = "adminpassword"
  }
  depends_on = [kubernetes_namespace.postgres]
}





resource "helm_release" "cloudnative_pg" {
  name       = "cloudnative-pg"
  namespace  = var.namespace
  chart      = "cloudnative-pg"  
  version    = "0.21.6" 
  repository = "https://cloudnative-pg.github.io/charts"


  timeout         = 1200
  wait            = true
  cleanup_on_fail = true
}


resource "null_resource" "apply_postgresql_cluster" {
  provisioner "local-exec" {
    command = <<EOT
    echo "
    apiVersion: postgresql.cnpg.io/v1
    kind: Cluster
    metadata:
      name: my-postgres-cluster
      namespace: postgres
    spec:
      instances: 1
      storage:
        size: 100Mi
      bootstrap:
        initdb:
          database: mydatabase
          owner: admin
          secret:
            name: pg_admin_secret
    " | kubectl apply -f -
    EOT
  }

  depends_on = [helm_release.cloudnative_pg]
}



