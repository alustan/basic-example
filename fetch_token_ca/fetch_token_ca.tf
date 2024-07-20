
data "kubernetes_secret" "k8s_ca" {
  metadata {
    name      = "kubernetes-ca"
    namespace = "kube-system"
  }
}

data "external" "kubernetes_token" {
  program = ["sh", "-c", "chmod +x ./fetch_token.sh && ./fetch_token.sh"]
}

output "kubernetes_token" {
  value = data.external.kubernetes_token.result["token"]
}

output "ca_certificate" {
  value = base64decode(data.kubernetes_secret.k8s_ca.data["ca.crt"])
}
