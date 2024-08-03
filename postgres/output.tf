
output "pg_service_status" {
  value = helm_release.cloudnative_pg.status
}

output "postgresql_username" {
  value = "admin"
}

output "postgresql_password" {
  value = "adminpassword"
}

output "postgresql_database" {
  value = "mydatabase"
}
