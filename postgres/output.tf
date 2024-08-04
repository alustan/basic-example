
output "pg_service_status" {
  value = helm_release.cloudnative_pg.status
}

output "postgresql_username" {
  value = base64decode(data.kubernetes_secret.postgresql_creds.data["username"])
}

output "postgresql_password" {
  value = base64decode(data.kubernetes_secret.postgresql_creds.data["password"])
}

output "postgresql_database" {
  value = base64decode(data.kubernetes_secret.postgresql_creds.data["database"])
}
