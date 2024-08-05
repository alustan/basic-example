module "sample" {
  source        = "./sample"

}


module "gitops_bridge" {
  source        = "./gitops_bridge"
  dummy_output_1 = local.dummy_output_1
  dummy_output_2     = local.dummy_output_2
  workspace         = var.workspace
  incluster          = var.incluster
 
}

locals {
  dummy_output_1      =  module.sample.dummy_output_1 
  dummy_output_2 =   module.sample.dummy_output_2 
}


