terraform init 
terraform destroy -target="module.fetch_token_ca" -auto-approve
terraform destroy -auto-approve

