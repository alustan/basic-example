

resource "local_file" "example" {
  filename = "${path.module}/example.txt"
  content  = "This is an example file created by Terraform."
}
