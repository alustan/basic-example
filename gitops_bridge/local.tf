
locals {
  


   cluster_metadata = merge(
  
    {
      dummy_output_1      = var.dummy_output_1
      dummy_output_2      = var.dummy_output_2
    }
  )

}


################################################################################
# ArgoCD Cluster
################################################################################
locals {
 
  argocd_labels = merge({
    cluster_name                     = "in-cluster"
    environment                      = local.environment
    enable_argocd                    = true
   "argocd.argoproj.io/secret-type"  = "cluster"
    
    }
   
  )

  argocd_annotations = merge(
    {
      cluster_name = "in-cluster"
      environment  = local.environment
    },
    try(local.cluster_metadata, {})
  )

  config = <<-EOT
    {
      "tlsClientConfig": {
        "insecure": false
      }
    }
  EOT

 
}




