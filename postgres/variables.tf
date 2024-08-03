variable "namespace" {
  description = "The namespace to deploy Cloud-native PostgreSQL"
  default     = "postgres"
}


variable "incluster" {
  description = "Flag to indicate if the deployment is in-cluster"
  type        = bool
  default     = true
}