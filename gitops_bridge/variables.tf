variable "dummy_output_1" {
  description = "dummy output 1"
  type        = string
  
}
 
 variable "dummy_output_2" {
  description = "dummy output 2"
  type        = string
  
}

variable "workspace" {
  description = "workspace environment"
  type        = string
  default   =   "default"
 }
 
variable "incluster" {
  description = "Flag to indicate if the deployment is in-cluster"
  type        = bool
  default     = true
}
