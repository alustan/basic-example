
locals {
  


   cluster_metadata = merge(
  
    {
      dummy_output_1      = var.dummy_output_1
      dummy_output_2      = var.dummy_output_2
      DB_PASSWORD = var.database_password
      DB_USER = var.database_user
      DB_NAME = var.database_name
    }
  )

}


locals {
 
  alustan_labels = merge({
    cluster_name                     = "in-cluster"
    environment                      = local.environment
   "alustan.io/secret-type"  = "cluster"
    
    }
   
  )

  alustan_annotations = merge(
    {
      cluster_name = "in-cluster"
      environment  = local.environment
    },
    try(local.cluster_metadata, {})
  )

}




