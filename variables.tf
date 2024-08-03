variable "workspace" {
  description = "workspace environment"
  type        = string
  default   =   "staging"
 }

 variable "incluster" {
  description = "Flag to indicate if the deployment is in-cluster"
  type        = bool
  default     = true
}