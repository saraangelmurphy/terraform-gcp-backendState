module "example" {
  source = "./state_bucket"
  project_name = "example-project"
  project_owner = "gcp-admins@example.com"
  #this_repo = "${var.this_repo}"
}
