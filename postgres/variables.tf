
variable "namespace" {
  description = "Namespace to deploy PostgreSQL"
  type        = string
  default     = "postgres"
}

variable "cluster_name" {
  description = "Name of the PostgreSQL cluster"
  type        = string
  default     = "postgres-cluster"
}

variable "storage_size" {
  description = "Size of the PostgreSQL storage"
  type        = string
  default     = "100Mi"
}

variable "database_name" {
  description = "Name of the PostgreSQL database"
  type        = string
  default     = "exampledb"
}

variable "database_user" {
  description = "PostgreSQL database user"
  type        = string
  default     = "exampleuser"
}

variable "database_password" {
  description = "PostgreSQL database password"
  type        = string
  default     = "examplepassword"
}

variable "secret_name" {
  description = "Name of the secret to store the database password"
  type        = string
  default     = "postgres-secret"
}
