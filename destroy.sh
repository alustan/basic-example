terraform init -reconfigure
export TF_REGISTRY_CLIENT_TIMEOUT=20000
terraform destroy -auto-approve

