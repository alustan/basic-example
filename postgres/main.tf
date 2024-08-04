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
    name      = "app-secret"
    namespace = var.namespace
  }

  type = "kubernetes.io/basic-auth"

  data = {
    username = base64encode("admin")
    password = base64encode("adminpassword")
    database = base64encode("db")
  }

  depends_on = [kubernetes_namespace.postgres]
}


# Fetch the Kubernetes Secret created by CNPG
data "kubernetes_secret" "postgresql_creds" {
  metadata {
    name      = "app-secret"
    namespace =  var.namespace
  }
  depends_on = [null_resource.apply_postgresql_cluster]
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
      name: alustan-pg
    spec:
      instances: 1


      bootstrap:
        initdb:
          database: db
          owner: admin
          secret:
            name: app-secret

      storage:
        size: 250Mi
      
    " | kubectl apply -f -
    EOT
  }

  depends_on = [helm_release.cloudnative_pg]
}



