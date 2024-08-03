

output "postgresql_username" {
  value = base64decode(kubernetes_secret.postgres_secret.data["username"])
}

output "postgresql_password" {
  value = base64decode(kubernetes_secret.postgres_secret.data["password"])
}

output "postgresql_database" {
  value = base64decode(kubernetes_secret.postgres_secret.data["database"])
}
