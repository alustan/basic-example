module "sample" {
  source        = "./sample"

}

module "postgres" {
  source          = "./postgres"
 
}

module "gitops_bridge" {
  source        = "./gitops_bridge"
  dummy_output_1 = local.dummy_output_1
  dummy_output_2     = local.dummy_output_2
  workspace         = var.workspace
  database_name  = local.database_name
  database_user    = local.database_user
  database_password = local.database_password
}

locals {
  dummy_output_1      =  module.sample.dummy_output_1 
  dummy_output_2 =   module.sample.dummy_output_2 
}

locals {
  database_password      =  module.postgres.postgresql_password 
  database_user =   module.postgres.postgresql_username 
  database_name =   module.postgres.postgresql_database 
}


